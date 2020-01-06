# frozen_string_literal: true

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class TerminalClearTest < TestCase
    def test_terminal_clear
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'TerminalClearTest')
      # setup request object
      request = {}
      request['test'] = true
      request['terminalName'] = 'Test Terminal'
      response = blockchyp.clear(request)

      assert_not_nil(response)
      # response assertions
      assert(response['success'])
    end

  end
end
