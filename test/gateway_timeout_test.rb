# frozen_string_literal: true

# Copyright 2019 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically. Changes to this file will be lost
# every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class GatewayTimeoutTest < TestCase
    def test_gateway_timeout
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'gateway_timeout_test')

      # setup request object
      request = {}
      request['timeout'] = 1
      request['pan'] = '5555555555554444'
      request['amount'] = '25.55'
      request['test'] = true
      request['transactionRef'] = uuid

      assert_raise Net::ReadTimeout do
      blockchyp.charge(request)
      end
    end

  end
end
