# frozen_string_literal: true

# Copyright 2019-2025 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class SimpleRefundTest < TestCase
    def test_simple_refund

      puts "Running test_simple_refund..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]

      test_delay(blockchyp, 'simple_refund_test', config[:defaultTerminalName])




      # Set request parameters
      setup_request = {
        pan: '4111111111111111',
        expMonth: '12',
        expYear: '2025',
        amount: '25.55',
        test: true,
        transactionRef: uuid
      }
      response = blockchyp.charge(setup_request)

      # Set request parameters
      request = {
        transactionId: response[:transactionId],
        test: true
      }

      response = blockchyp.refund(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert(response[:approved])
    end
  end
end
