# frozen_string_literal: true

# Copyright 2019 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically. Changes to this file will be lost
# every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class TerminalKeyedChargeTest < TestCase
    def test_terminal_keyed_charge
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'terminal_keyed_charge_test')

      # Set request parameters
      request = {
        "terminalName": 'Test Terminal',
        "amount": '11.11',
        "manualEntry": true,
        "test": true
      }

      response = blockchyp.charge(request)

      assert_not_nil(response)
      # response assertions
      assert(response['success'])
      assert(response['approved'])
      assert(response['test'])
      assert_equal(response['authCode'].length, 6)
      assert(!response['transactionId'].empty?)
      assert(!response['timestamp'].empty?)
      assert(!response['tickBlock'].empty?)
      assert_equal('approved', response['responseDescription'])
      assert(!response['paymentType'].empty?)
      assert(!response['maskedPan'].empty?)
      assert(!response['entryMethod'].empty?)
      assert_equal('11.11', response['authorizedAmount'])
    end
  end
end
