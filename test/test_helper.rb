# frozen_string_literal: true

require 'etc'
require 'json'
require 'securerandom'

require 'test/unit'

require ::File.expand_path('../lib/blockchyp', __dir__)

module BlockChyp
  class TestCase < Test::Unit::TestCase
    def load_test_config
      config_home = ''
      if windows?
        config_home = ENV['userprofile']
      else
        config_home = ENV['XDG_CONFIG_HOME']
        if config_home.nil?
          config_home = ENV['HOME']
        end
        config_home = File.join(config_home, '.config')
      end

      file_name = File.join(config_home, 'blockchyp', 'sdk-itest-config.json')

      raise 'file not found: ' + file_name unless File.file?(file_name)

      config_file = File.open(file_name)
      content = config_file.read

      JSON.parse(content, symbolize_names: true)
    end

    def test_delay(client, test_name, terminal_name)
      test_delay = ENV['BC_TEST_DELAY']

      if test_delay
        test_delay_int = Integer(test_delay)
        if test_delay_int.positive?
          request = {
            test: true,
            terminalName: terminal_name,
            message: "Running #{test_name} in #{test_delay} seconds.."
          }
          response = client.message(request)

          assert_not_nil(response)
          # response assertions
          assert(response[:success])
          sleep test_delay_int
        end
      end
    end

    def uuid
      SecureRandom.uuid
    end

    def windows?
      !(/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
    end
  end
end
