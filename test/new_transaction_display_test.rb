# frozen_string_literal: true

# Copyright 2019-2024 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class NewTransactionDisplayTest < TestCase
    def test_new_transaction_display

      puts "Running test_new_transaction_display..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]

      test_delay(blockchyp, 'new_transaction_display_test', config[:defaultTerminalName])




      # Set request parameters
      request = {
        test: true,
        terminalName: config[:defaultTerminalName],
        transaction: {
          subtotal: '35.00',
          tax: '5.00',
          total: '70.00',
          items: [
            {
              description: 'Leki Trekking Poles',
              price: '35.00',
              quantity: 2,
              extended: '70.00',
              discounts: [
                {
                  description: 'memberDiscount',
                  amount: '10.00'
                }
              ]
            }
          ]
        }
      }

      response = blockchyp.new_transaction_display(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
