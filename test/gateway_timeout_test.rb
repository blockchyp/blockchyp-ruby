# frozen_string_literal: true

# Copyright 2019-2025 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class GatewayTimeoutTest < TestCase
    def test_gateway_timeout

      puts "Running test_gateway_timeout..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]

      test_delay(blockchyp, 'gateway_timeout_test', config[:defaultTerminalName])




      # Set request parameters
      request = {
        timeout: 1,
        pan: '5555555555554444',
        expMonth: '12',
        expYear: '2025',
        amount: '25.55',
        test: true,
        transactionRef: uuid
      }

      assert_raise Net::ReadTimeout do
      blockchyp.charge(request)
      end
    end
  end
end
