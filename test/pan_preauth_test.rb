# frozen_string_literal: true

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class PANPreauthTest < TestCase
    def test_pan_preauth
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'PANPreauthTest')
      # setup request object
      request = {}
      request['pan'] = '4111111111111111'
      request['amount'] = '25.55'
      request['test'] = true
      response = blockchyp.preauth(request)

      assert_not_nil(response)
      # response assertions
      assert(response['approved'])
      assert(response['test'])
      assert_equal(response['authCode'].length, 6)
      assert(!response['transactionId'].empty?)
      assert(!response['timestamp'].empty?)
      assert(!response['tickBlock'].empty?)
      assert_equal('Approved', response['responseDescription'])
      assert(!response['paymentType'].empty?)
      assert(!response['maskedPan'].empty?)
      assert(!response['entryMethod'].empty?)
      assert_equal('25.55', response['authorizedAmount'])
      assert_equal('KEYED', response['entryMethod'])
    end

  end
end
