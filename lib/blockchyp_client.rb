# frozen_string_literal: true

require "base64"
require 'digest'
require 'json'
require 'net/http'
require 'openssl'
require 'time'
require 'tmpdir'
require 'uri'

require_relative "crypto_utils"

module BlockChyp
  class BlockChypClient

    def initialize(apiKey, bearerToken, signingKey)
      @apiKey = apiKey
      @bearerToken = bearerToken
      @signingKey = signingKey
      @gatewayHost = "https://api.blockchyp.com"
      @testGatewayHost = "https://test.blockchyp.com"
      @https = false
      @routeCacheLocation = File.join(Dir.tmpdir(), ".blockchyp_routes")
      @routeCacheTTL = 60
      @gatewayTimeout = 20
      @terminalTimeout = 120
      @terminalConnectTimeout = 5
      @offlineCacheEnabled = true
      @routeCache = Hash.new
      @offlineFixedKey = "cb22789c9d5c344a10e0474f134db39e25eb3bbf5a1b1a5e89b507f15ea9519c"
    end

    attr_reader :apiKey
    attr_reader :bearerToken
    attr_reader :signingKey
    attr_reader :offlineFixedKey
    attr_accessor :gatewayHost
    attr_accessor :testGatewayHost
    attr_accessor :https
    attr_accessor :routeCacheTTL
    attr_accessor :gatewayTimeout
    attr_accessor :terminalTimeout
    attr_accessor :offlineCacheEnabled
    attr_accessor :terminalConnectTimeout
    attr_accessor :routeCacheLocation

    def gateway_get(path, test)

      path = self.resolve_gateway_url(path, test)
      puts "GET: " + path
      uri = URI(path)
      req = Net::HTTP::Get.new(uri)
      headers = self.generateGatewayHeaders()
      headers.each do | key, value |
        req[key] = value
      end
      res = Net::HTTP::new(uri.host, uri.port).start do |http|
        http.request(req)
      end
      if res.is_a?(Net::HTTPSuccess)
        return JSON.parse(res.body)
      else
        raise res.message
      end

    end

    def generateGatewayHeaders()

      nonce = CryptoUtils::generateNonce()
      ts = CryptoUtils::timestamp()

      sig = self.compute_hmac(ts, nonce)

      headers = {
        "Nonce" => nonce,
        'Timestamp' => ts,
        "Authorization" => "Dual " + self.bearerToken + ":" + self.apiKey + ":" + sig
      }

      return headers

    end

    def compute_hmac(ts, nonce)

      canonicalString = self.apiKey + self.bearerToken + ts + nonce

      return OpenSSL::HMAC.hexdigest('SHA256', CryptoUtils::hex2bin(self.signingKey), canonicalString)

    end

    def resolve_gateway_url(path, test)

      url = ""
      if test
        url = url + self.testGatewayHost
      else
        url = url + self.gatewayHost
      end

      return url + path

    end

    def generate_error_response(msg)

      return [
        "success" => false,
        "error" => $msg,
        "responseDescription" => $msg
      ]

    end

    def route_terminal_request(request, terminalPath, gatewayPath, method)
      if (!request["terminalName"].nil?)
        route = resolve_terminal_route(request["terminalName"])
        if (!route)
          return generate_error_response("Unkown Terminal")
        elsif (route["cloudRelayEnabled"])
          return gateway_request(gatewayPath, request, method)
        end
        return terminal_request(route, terminalPath, request, method, true)
      end
      return gateway_request(gatewayPath, request, method)
    end

    def terminal_request(route, path, request, method, openRetry)

      url = resolve_terminal_url(route, path)

      txCreds = route["transientCredentials"]

      terminalRequest = {
        "apiKey" => txCreds["apiKey"],
        "bearerToken" => txCreds["bearerToken"],
        "signingKey" => txCreds["signingKey"],
        "request" => request
      }

      puts method + ": " + url
      puts terminalRequest.to_json

      uri = URI(url)
      req = nil
      if method == "PUT"
        req = Net::HTTP::Put.new(uri)
      elsif
        req = Net::HTTP::Post.new(uri)
      end
      json = terminalRequest.to_json
      req["Content-Type"] = "application/json"
      req["Content-Length"] = json.length
      req.body = json
      http = Net::HTTP::new(uri.host, uri.port)
      http.open_timeout = self.terminalConnectTimeout
      http.read_timeout = self.terminalTimeout
      begin
        res = http.start() do |http|
            http.request(req)
        end
      rescue Net::OpenTimeout, Errno::EHOSTDOWN, Errno::EHOSTUNREACH, Errno::ETIMEDOUT, Errno::ENETUNREACH
        if openRetry
          evict(route["terminalName"])
          route = resolve_terminal_route(route["terminalName"])
          return terminal_request(route, path, request, method, false)
        end
      end
      if res.is_a?(Net::HTTPSuccess)
        puts "Response: " + res.body
        return JSON.parse(res.body)
      else
        raise res.message
      end

    end

    def resolve_terminal_url(route, path)

      url = ""
      if self.https
        url = url + "https://"
      elsif
        url = url + "http://"
      end
      url = url + route["ipAddress"]
      if self.https
        url = url + ":8443"
      elsif
        url = url + ":8080"
      end
      url = url + path
      return url

    end

    def gateway_request(path, request, method)

      url = resolve_gateway_url(path, request["test"])

      puts method + ": " + url
      puts request.to_json

      uri = URI(url)
      req = nil
      if method == "PUT"
        req = Net::HTTP::Put.new(uri)
      elsif
        req = Net::HTTP::Post.new(uri)
      end
      json = request.to_json
      req["Content-Type"] = "application/json"
      req["Content-Length"] = json.length
      headers = self.generateGatewayHeaders()
      headers.each do | key, value |
        req[key] = value
      end
      req.body = json
      res = Net::HTTP::new(uri.host, uri.port).start do |http|
        http.request(req)
      end
      if res.is_a?(Net::HTTPSuccess)
        puts "Response: " + res.body
        return JSON.parse(res.body)
      else
        raise res.message
      end

    end

    attr_accessor :routeCache

    def resolve_terminal_route(terminal_name)

      route = route_cache_get(terminal_name, false)

      if route.nil?
        route = request_route_from_gateway(terminal_name)
        if !route.nil?
          ttl = Time.now.utc + (self.routeCacheTTL * 60)
          routeCacheEntry = Hash.new
          routeCacheEntry["route"] = route
          routeCacheEntry["ttl"] = ttl
          routeCache[self.apiKey + terminal_name] = routeCacheEntry
          update_offline_cache(routeCacheEntry)
        end
      end

      return route

    end

    def update_offline_cache(routeCacheEntry)

      if self.offlineCacheEnabled
        offlineCache = self.read_offline_cache
        offlineEntry = routeCacheEntry.clone
        route = routeCacheEntry["route"].clone
        txCreds = route["transientCredentials"].clone
        txCreds["apiKey"] = encrypt(txCreds["apiKey"])
        txCreds["bearerToken"] = encrypt(txCreds["bearerToken"])
        txCreds["signingKey"] = encrypt(txCreds["signingKey"])
        route["transientCredentials"] = txCreds
        offlineEntry["route"] = route
        routeCache[self.apiKey + route["terminalName"]] = offlineEntry
        File.write(self.routeCacheLocation, routeCache.to_json)
      end

    end

    def encrypt(plainText)

      cipher = OpenSSL::Cipher::AES256.new(:CBC)
      cipher.encrypt
      cipher.key = derive_offline_key()
      iv = cipher.random_iv

      encrypted = Base64.encode64(iv) + ":" + Base64.encode64(cipher.update(plainText) + cipher.final)

      return encrypted

    end

    def decrypt(cipherText)

      tokens = cipherText.split(':')

      iv = Base64.decode64(tokens[0])
      cp = Base64.decode64(tokens[1])

      decipher = OpenSSL::Cipher::AES256.new(:CBC)
      decipher.decrypt
      decipher.key = derive_offline_key()
      decipher.iv = iv

      return decipher.update(cp) + decipher.final

    end

    def derive_offline_key()

      return Digest::SHA256.digest self.offlineFixedKey + self.signingKey

    end

    def request_route_from_gateway(terminal_name)

      route = self.gateway_get("/api/terminal-route?terminal=" + URI.escape(terminal_name), false)
      if (!route.nil?  && !route["ipAddress"].empty?)
        route["exists"] = true
      end

      return route

    end

    def evict(terminal_name)

      routeCache.delete(self.apiKey + terminal_name)

      offlineCache = read_offline_cache
      offlineCache.delete(self.apiKey + terminal_name)
      File.write(self.routeCacheLocation, routeCache.to_json)

    end

    def route_cache_get(terminal_name, stale)

      routeCacheEntry = routeCache[self.apiKey + terminal_name]

      if (routeCacheEntry.nil? && self.offlineCacheEnabled)
        offlineCache = read_offline_cache()
        routeCacheEntry = offlineCache[self.apiKey + terminal_name]
        if (routeCacheEntry)
          route = routeCacheEntry["route"]
          txCreds = route["transientCredentials"]
          txCreds["apiKey"] = decrypt(txCreds["apiKey"])
          txCreds["bearerToken"] = decrypt(txCreds["bearerToken"])
          txCreds["signingKey"] = decrypt(txCreds["signingKey"])
          route["transientCredentials"] = txCreds
          routeCacheEntry["route"] = route
        end
      end

      if (routeCacheEntry)
        now = Time.new
        ttl = Time.parse(routeCacheEntry["ttl"])
        if (stale || now < ttl)
          puts "Cache Hit " + routeCacheEntry.to_json
          return routeCacheEntry["route"]
        end
      end

      return nil;

    end

    def read_offline_cache

      puts self.routeCacheLocation

      if !File.file?(self.routeCacheLocation)
        return Hash.new
      end

      configFile = open(self.routeCacheLocation)
      content = configFile.read

      return JSON.parse(content)

    end

  end
end
