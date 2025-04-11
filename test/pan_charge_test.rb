# frozen_string_literal: true

# Copyright 2019-2025 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class PANChargeTest < TestCase
    def test_pan_charge

      puts "Running test_pan_charge..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]

      test_delay(blockchyp, 'pan_charge_test', config[:defaultTerminalName])




      # Set request parameters
      request = {
        pan: '4111111111111111',
        expMonth: '12',
        expYear: '2025',
        amount: '25.55',
        test: true,
        transactionRef: uuid
      }

      response = blockchyp.charge(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert(response[:approved])
      assert(response[:test])
      assert_equal(response[:authCode].length, 6)
      assert(!response[:transactionId].empty?)
      assert(!response[:timestamp].empty?)
      assert(!response[:tickBlock].empty?)
      assert_equal('approved', response[:responseDescription])
      assert(!response[:paymentType].empty?)
      assert(!response[:maskedPan].empty?)
      assert(!response[:entryMethod].empty?)
      assert_equal('25.55', response[:authorizedAmount])
      assert_equal('KEYED', response[:entryMethod])
    end
  end
end
