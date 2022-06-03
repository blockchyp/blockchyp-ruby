# frozen_string_literal: true

# Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class TransactionHistoryTest < TestCase
    def test_transaction_history

      puts "Running test_transaction_history..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]





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
        maxResults: 10
      }

      response = blockchyp.transaction_history(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
