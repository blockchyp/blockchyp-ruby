# frozen_string_literal: true

require 'base64'
require 'cgi'
require 'digest'
require 'json'
require 'net/http'
require 'openssl'
require 'time'
require 'tmpdir'
require 'uri'

require_relative 'crypto_utils'

module BlockChyp
  # base class for the blockchyp generated blockchyp client
  class BlockChypClient
    def initialize(api_key, bearer_token, signing_key)
      @api_key = api_key
      @bearer_token = bearer_token
      @signing_key = signing_key
      @gateway_host = 'https://api.blockchyp.com'
      @test_gateway_host = 'https://test.blockchyp.com'
      @https = false
      @route_cache_location = File.join(Dir.tmpdir, '.blockchyp_route')
      @route_cache_ttl = 60
      @gateway_timeout = 20
      @terminal_timeout = 120
      @terminal_connect_timeout = 5
      @offline_cache_enabled = true
      @route_cache = {}
      @offline_fixed_key = 'cb22789c9d5c344a10e0474f134db39e25eb3bbf5a1b1a5e89b507f15ea9519c'
    end

    attr_reader :api_key
    attr_reader :bearer_token
    attr_reader :signing_key
    attr_reader :offline_fixed_key
    attr_accessor :gateway_host
    attr_accessor :test_gateway_host
    attr_accessor :https
    attr_accessor :route_cache_ttl
    attr_accessor :gateway_timeout
    attr_accessor :terminal_timeout
    attr_accessor :offline_cache_enabled
    attr_accessor :terminal_connect_timeout
    attr_accessor :route_cache_location
    attr_accessor :route_cache

    def generate_gateway_headers
      nonce = CryptoUtils.generate_nonce
      tsp = CryptoUtils.timestamp

      sig = compute_hmac(tsp, nonce)

      {
        'Nonce' => nonce,
        'Timestamp' => tsp,
        'Authorization' => 'Dual ' + bearer_token + ':' + api_key + ':' + sig
      }
    end

    def compute_hmac(tsp, nonce)
      canonical_string = api_key + bearer_token + tsp + nonce

      OpenSSL::HMAC.hexdigest('SHA256', CryptoUtils.hex2bin(signing_key), canonical_string)
    end

    def resolve_gateway_uri(path, request)
      url = request.nil? || !request[:test] ? gateway_host : test_gateway_host

      URI.parse(path.nil? ? url : url + path)
    end

    def generate_error_response(msg)
      {
        success: false,
        error: msg,
        responseDescription: msg
      }
    end

    def route_terminal_request(method, terminal_path, gateway_path, request)
      unless request.key?(:terminalName)
        return gateway_request(method, gateway_path, request)
      end

      route = resolve_terminal_route(request[:terminalName])
      if !route
        return generate_error_response('Unkown Terminal')
      elsif route[:cloudRelayEnabled]
        return gateway_request(method, gateway_path, request, relay: true)
      end

      terminal_request(method, route, terminal_path, request, true)
    end

    def terminal_request(method, route, path, request, open_retry)
      uri = resolve_terminal_uri(route, path)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.instance_of?(URI::HTTPS)
      timeout = get_timeout(request, terminal_timeout)
      http.open_timeout = timeout
      http.read_timeout = timeout

      tx_creds = route[:transientCredentials]

      wrapped_request = {
        apiKey: tx_creds[:apiKey],
        bearerToken: tx_creds[:bearerToken],
        signingKey: tx_creds[:signingKey],
        request: request
      }

      req = get_http_request(method, uri)

      req['User-Agent'] = user_agent
      json = wrapped_request.to_json
      req['Content-Type'] = 'application/json'
      req['Content-Length'] = json.length
      req.body = json

      begin
        response = http.request(req)
      rescue Net::OpenTimeout, Errno::EHOSTDOWN, Errno::EHOSTUNREACH, Errno::ETIMEDOUT, Errno::ENETUNREACH
        if open_retry
          evict(route[:terminalName])
          route = resolve_terminal_route(route[:terminalName])
          return terminal_request(method, route, path, request, false)
        end
        raise
      end
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body, symbolize_names: true)
      else
        raise response.message
      end
    end

    def get_http_request(method, uri)
      case method
      when 'GET'
        Net::HTTP::Get.new(uri.request_uri)
      when 'PUT'
        Net::HTTP::Put.new(uri.request_uri)
      when 'POST'
        Net::HTTP::Post.new(uri.request_uri)
      when 'DELETE'
        Net::HTTP::Delete.new(uri.request_uri)
      end
    end

    def resolve_terminal_uri(route, path)
      url = if https
              'https://'
            else
              'http://'
            end
      url += route[:ipAddress]
      port = if https
               ':8443'
             else
               ':8080'
             end
      URI.parse(url + port + path)
    end

    def gateway_request(method, path, request = nil, relay = false)
      uri = resolve_gateway_uri(path, request)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.instance_of?(URI::HTTPS)
      timeout = get_timeout(request, relay ? terminal_timeout : gateway_timeout)
      http.open_timeout = timeout
      http.read_timeout = timeout

      req = get_http_request(method, uri)

      req['User-Agent'] = user_agent
      unless request.nil?
        json = request.to_json
        req['Content-Type'] = 'application/json'
        req['Content-Length'] = json.length
        req.body = json
      end

      headers = generate_gateway_headers
      headers.each do |key, value|
        req[key] = value
      end

      response = http.request(req)

      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body, symbolize_names: true)
      else
        raise response.message
      end
    end

    def resolve_terminal_route(terminal_name)
      route = route_cache_get(terminal_name, false)

      if route.nil?
        route = request_route_from_gateway(terminal_name)
        if route.nil?
          return route
        end

        ttl = Time.now.utc + (route_cache_ttl * 60)
        route_cache_entry = {}
        route_cache_entry[:route] = route
        route_cache_entry[:ttl] = ttl
        @route_cache[api_key + terminal_name] = route_cache_entry
        update_offline_cache(route_cache_entry)
      end
      route
    end

    def update_offline_cache(route_cache_entry)
      if offline_cache_enabled
        offline_cache = read_offline_cache
        offline_entry = route_cache_entry.clone
        route = route_cache_entry[:route].clone
        tx_creds = route[:transientCredentials].clone
        tx_creds[:apiKey] = encrypt(tx_creds[:apiKey])
        tx_creds[:bearerToken] = encrypt(tx_creds[:bearerToken])
        tx_creds[:signingKey] = encrypt(tx_creds[:signingKey])
        route[:transientCredentials] = tx_creds
        offline_entry[:route] = route
        offline_cache[api_key + route[:terminalName]] = offline_entry
        File.write(route_cache_location, offline_cache.to_json)
      end
    end

    def encrypt(plain_text)
      return plain_text if plain_text.nil? || plain_text.empty?

      cipher = OpenSSL::Cipher::AES256.new(:CBC)
      cipher.encrypt
      cipher.key = derive_offline_key
      iv = cipher.random_iv

      Base64.encode64(iv) + ':' + Base64.encode64(cipher.update(plain_text) + cipher.final)
    end

    def decrypt(cipher_text)
      return cipher_text if cipher_text.nil? || cipher_text.empty?

      tokens = cipher_text.split(':')

      return cipher_text if tokens[0].nil? || tokens[1].nil?

      iv = Base64.decode64(tokens[0])
      cp = Base64.decode64(tokens[1])

      decipher = OpenSSL::Cipher::AES256.new(:CBC)
      decipher.decrypt
      decipher.key = derive_offline_key
      decipher.iv = iv

      decipher.update(cp) + decipher.final
    end

    def derive_offline_key
      Digest::SHA256.digest offline_fixed_key + signing_key
    end

    def request_route_from_gateway(terminal_name)
      route = gateway_request('GET', '/api/terminal-route?terminal=' + CGI.escape(terminal_name))
      if !route.nil? && !route[:ipAddress].empty?
        route[:exists] = true
      end
      route
    end

    def evict(terminal_name)
      route_cache.delete(api_key + terminal_name)

      offline_cache = read_offline_cache
      offline_cache.delete(api_key + terminal_name)
      File.write(route_cache_location, route_cache.to_json)
    end

    def route_cache_get(terminal_name, stale)
      route_cache_entry = @route_cache[api_key + terminal_name]

      if route_cache_entry.nil? && offline_cache_enabled
        offline_cache = read_offline_cache
        route_cache_entry = offline_cache[@api_key + terminal_name]
      end

      if route_cache_entry
        route = route_cache_entry[:route]
        tx_creds = route[:transientCredentials]
        tx_creds[:apiKey] = decrypt(tx_creds[:apiKey])
        tx_creds[:bearerToken] = decrypt(tx_creds[:bearerToken])
        tx_creds[:signingKey] = decrypt(tx_creds[:signingKey])
        route[:transientCredentials] = tx_creds
        route_cache_entry[:route] = route

        raw_ttl = route_cache_entry[:ttl]

        ttl = raw_ttl.instance_of?(Time) ? raw_ttl : Time.parse(route_cache_entry[:ttl])

        if stale || Time.new < ttl
          route_cache_entry[:route]
        end
      end
    end

    def read_offline_cache
      if File.file?(route_cache_location)

        config_file = File.open(route_cache_location)
        content = config_file.read

        return JSON.parse(content, symbolize_names: true)
      end
      {}
    end

    def user_agent
      if defined? VERSION
        "BlockChyp-Ruby/#{VERSION}"
      else
        'BlockChyp-Ruby'
      end
    end

    def get_timeout(request, default)
      if request.nil? || !request.key?(:timeout) || request[:timeout].zero?
        return default
      end

      request[:timeout]
    end
  end
end
