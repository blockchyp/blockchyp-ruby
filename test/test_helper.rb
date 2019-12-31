# frozen_string_literal: true

require 'etc'
require 'json'

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

    def is_windows
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

  end
end
