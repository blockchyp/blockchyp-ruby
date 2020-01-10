# frozen_string_literal: true

# Copyright 2019 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically. Changes to this file will be lost
# every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class SimpleRefundTest < TestCase
    def test_simple_refund
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'simple_refund_test')
      # setup request object
      request = {}
      request['pan'] = '4111111111111111'
      request['amount'] = '25.55'
      request['test'] = true
      request['transactionRef'] = uuid
      response = blockchyp.charge(request)


      # setup request object
      request = {}
      request['transactionId'] = response['transactionId']
      request['test'] = true

      response = blockchyp.refund(request)

      assert_not_nil(response)
      # response assertions
      assert(response['approved'])
    end

  end
end
