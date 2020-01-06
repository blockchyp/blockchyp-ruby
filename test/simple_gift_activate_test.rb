# frozen_string_literal: true

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class SimpleGiftActivateTest < TestCase
    def test_simple_gift_activate
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'SimpleGiftActivateTest')
      # setup request object
      request = {}
      request['test'] = true
      request['terminalName'] = 'Test Terminal'
      request['amount'] = '50.00'
      response = blockchyp.giftActivate(request)

      assert_not_nil(response)
      # response assertions
      assert(response['approved'])
      assert(!response['publicKey'].empty?)
    end

  end
end
