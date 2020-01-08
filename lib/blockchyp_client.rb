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

    def gateway_get(path, test)
      path = resolve_gateway_url(path, test)
      puts 'GET: ' + path
      uri = URI(path)
      req = Net::HTTP::Get.new(uri)
      headers = generate_gateway_headers
      headers.each do |key, value|
        req[key] = value
      end
      res = Net::HTTP.new(uri.host, uri.port).start do |inner_http|
        inner_http.request(req)
      end
      if res.is_a?(Net::HTTPSuccess)
        JSON.parse(res.body)
      else
        raise res.message
      end
    end

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

    def resolve_gateway_url(path, test)
      url = if test
              test_gateway_host
            else
              gateway_host
            end

      url + path
    end

    def generate_error_response(msg)
      [
        'success' => false,
        'error' => msg,
        'responseDescription' => msg
      ]
    end

    def route_terminal_request(request, terminal_path, gateway_path, method)
      if request['terminalName'].nil?
        return gateway_request(gateway_path, request, method)
      end

      route = resolve_terminal_route(request['terminalName'])
      if !route
        return generate_error_response('Unkown Terminal')
      elsif route['cloudRelayEnabled']
        return gateway_request(gateway_path, request, method)
      end

      terminal_request(route, terminal_path, request, method, true)
    end

    def terminal_request(route, path, request, method, open_retry)
      url = resolve_terminal_url(route, path)

      tx_creds = route['transientCredentials']

      terminal_request = {
        'apiKey' => tx_creds['apiKey'],
        'bearerToken' => tx_creds['bearerToken'],
        'signingKey' => tx_creds['signingKey'],
        'request' => request
      }

      puts method + ': ' + url
      puts terminal_request.to_json

      uri = URI(url)
      req = if method == 'PUT'
              Net::HTTP::Put.new(uri)
            else
              Net::HTTP::Post.new(uri)
            end
      json = terminal_request.to_json
      req['Content-Type'] = 'application/json'
      req['Content-Length'] = json.length
      req.body = json
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = terminal_connect_timeout
      http.read_timeout = terminal_timeout
      begin
        res = http.start do |inner_http|
          inner_http.request(req)
        end
      rescue Net::OpenTimeout, Errno::EHOSTDOWN, Errno::EHOSTUNREACH, Errno::ETIMEDOUT, Errno::ENETUNREACH
        if open_retry
          evict(route['terminalName'])
          route = resolve_terminal_route(route['terminalName'])
          return terminal_request(route, path, request, method, false)
        end
      end
      if res.is_a?(Net::HTTPSuccess)
        puts 'Response: ' + res.body
        JSON.parse(res.body)
      else
        raise res.message
      end
    end

    def resolve_terminal_url(route, path)
      url = if https
              'https://'
            else
              'http://'
            end
      url += route['ipAddress']
      port = if https
               ':8443'
             else
               ':8080'
             end
      url + port + path
    end

    def gateway_request(path, request, method)
      url = resolve_gateway_url(path, request['test'])

      puts method + ': ' + url
      puts request.to_json

      uri = URI(url)
      req = if method == 'PUT'
              Net::HTTP::Put.new(uri)
            else
              Net::HTTP::Post.new(uri)
            end
      json = request.to_json
      req['Content-Type'] = 'application/json'
      req['Content-Length'] = json.length
      headers = generate_gateway_headers
      headers.each do |key, value|
        req[key] = value
      end
      req.body = json
      res = Net::HTTP.new(uri.host, uri.port).start do |http|
        http.request(req)
      end
      if res.is_a?(Net::HTTPSuccess)
        puts 'Response: ' + res.body
        JSON.parse(res.body)
      else
        raise res.message
      end
    end

    attr_accessor :routeCache

    def resolve_terminal_route(terminal_name)
      route = route_cache_get(terminal_name, false)

      if route.nil?
        route = request_route_from_gateway(terminal_name)
        if route.nil?
          return route
        end

        ttl = Time.now.utc + (route_cache_ttl * 60)
        route_cache_entry = {}
        route_cache_entry['route'] = route
        route_cache_entry['ttl'] = ttl
        @route_cache[api_key + terminal_name] = route_cache_entry
        update_offline_cache(route_cache_entry)
      end
      route
    end

    def update_offline_cache(route_cache_entry)
      if offline_cache_enabled
        offline_cache = read_offline_cache
        offline_entry = route_cache_entry.clone
        route = route_cache_entry['route'].clone
        tx_creds = route['transientCredentials'].clone
        tx_creds['apiKey'] = encrypt(tx_creds['apiKey'])
        tx_creds['bearerToken'] = encrypt(tx_creds['bearerToken'])
        tx_creds['signingKey'] = encrypt(tx_creds['signingKey'])
        route['transientCredentials'] = tx_creds
        puts 'ENCRYPTED:'
        puts route
        offline_entry['route'] = route
        offline_cache[api_key + route['terminalName']] = offline_entry
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
      route = gateway_get('/api/terminal-route?terminal=' + CGI.escape(terminal_name), false)
      if !route.nil? && !route['ipAddress'].empty?
        route['exists'] = true
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
        route = route_cache_entry['route']
        tx_creds = route['transientCredentials']
        tx_creds['apiKey'] = decrypt(tx_creds['apiKey'])
        tx_creds['bearerToken'] = decrypt(tx_creds['bearerToken'])
        tx_creds['signingKey'] = decrypt(tx_creds['signingKey'])
        route['transientCredentials'] = tx_creds
        route_cache_entry['route'] = route
      end

      if route_cache_entry
        now = Time.new
        ttl = Time.parse(route_cache_entry['ttl'])
        if stale || now < ttl
          puts 'Cache Hit ' + route_cache_entry.to_json
          route_cache_entry['route']
        end
      end
    end

    def read_offline_cache
      puts route_cache_location

      if File.file?(route_cache_location)

        config_file = File.open(route_cache_location)
        content = config_file.read

        return JSON.parse(content)
      end
      {}
    end
  end
end
