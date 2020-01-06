# frozen_string_literal: true

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class SimpleBatchCloseTest < TestCase
    def test_simple_batch_close
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'SimpleBatchCloseTest')
      # setup request object
      request = {}
      request['pan'] = '4111111111111111'
      request['amount'] = '25.55'
      request['test'] = true
      request['transactionRef'] = uuid
      response = blockchyp.charge(request)

      # setup request object
      request = {}
      request['test'] = true
      response = blockchyp.closeBatch(request)

      assert_not_nil(response)
      # response assertions
      assert(response['success'])
      assert(!response['capturedTotal'].empty?)
      assert(!response['openPreauths'].empty?)
    end

  end
end
