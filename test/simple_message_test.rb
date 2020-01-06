# frozen_string_literal: true

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class SimpleMessageTest < TestCase
    def test_simple_message
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'SimpleMessageTest')
      # setup request object
      request = {}
      request['test'] = true
      request['terminalName'] = 'Test Terminal'
      request['message'] = 'Thank You For Your Business'
      response = blockchyp.message(request)

      assert_not_nil(response)
      # response assertions
      assert(response['success'])
    end

  end
end
