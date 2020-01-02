# frozen_string_literal: true

require 'etc'
require 'json'
require 'securerandom'

require "test/unit"

require ::File.expand_path("../lib/blockchyp", __dir__)

module BlockChyp
  class TestCase < Test::Unit::TestCase

    def load_test_config

      configHome = ""
      if self.is_windows()
        configHome = ENV["userprofile"]
      else
        configHome = ENV["XDG_CONFIG_HOME"]
        if configHome.nil?
          configHome = Etc.getpwuid.dir
        end
        configHome = configHome + "/.config"
      end

      fileName = File.join(configHome, "blockchyp", "sdk-itest-config.json")

      puts "load config: " + fileName

      if !File.file?(fileName)
        raise "file not found: " + fileName
      end

      configFile = open(fileName)
      content = configFile.read

      return JSON.parse(content)

    end

    def test_delay(client, test_name)

      testDelay = ENV["BC_TEST_DELAY"]

      if (testDelay)
        testDelayInt = Integer(testDelay)
        if (testDelayInt > 0)
          request = Hash.new
          request["test"] = true
          request["terminalName"] = "Test Terminal"
          request["message"] = "Running " + test_name + " in " + testDelay + " seconds..."
          response = client.message(request)

          assert_not_nil(response)
          # response assertions
          assert(response["success"])
          sleep testDelayInt
        end
      end

    end

    def get_uuid

      return SecureRandom.uuid

    end

    def is_windows
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

  end
end
