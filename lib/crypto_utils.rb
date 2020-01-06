# frozen_string_literal: true

require 'securerandom'
require 'date'

module BlockChyp
  # crypto and encoding utilities
  class CryptoUtils
    def self.generate_nonce
      bin2hex(SecureRandom.bytes(32))
    end

    def self.timestamp
      Time.now.utc.to_datetime.rfc3339
    end

    def self.bin2hex(val)
      val.each_byte.map { |b| b.to_s(16) }.join
    end

    def self.hex2bin(val)
      val.scan(/../).map { |x| x.hex.chr }.join
    end
  end
end
