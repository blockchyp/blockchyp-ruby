# frozen_string_literal: true

require 'securerandom'
require 'date'

module BlockChyp
  class CryptoUtils

    def self.generateNonce()
      return self.bin2hex(SecureRandom.bytes(32))
    end

    def self.timestamp()
      return Time.now.utc.to_datetime.rfc3339
    end

    def self.bin2hex(s)
      s.each_byte.map { |b| b.to_s(16) }.join
    end

    def self.hex2bin(s)
     s.scan(/../).map { |x| x.hex.chr }.join
    end

  end
end
