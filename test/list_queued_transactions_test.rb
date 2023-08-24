# frozen_string_literal: true

# Copyright 2019-2023 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class ListQueuedTransactionsTest < TestCase
    def test_list_queued_transactions

      puts "Running test_list_queued_transactions..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]

      test_delay(blockchyp, 'list_queued_transactions_test', config[:defaultTerminalName])




      # Set request parameters
      setup_request = {
        terminalName: config[:defaultTerminalName],
        transactionRef: uuid,
        description: '1060 West Addison',
        amount: '25.15',
        test: true,
        queue: true
      }
      response = blockchyp.charge(setup_request)

      # Set request parameters
      request = {
        terminalName: config[:defaultTerminalName]
      }

      response = blockchyp.list_queued_transactions(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
