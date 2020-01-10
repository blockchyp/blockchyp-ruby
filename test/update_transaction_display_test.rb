# frozen_string_literal: true

# Copyright 2019 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically. Changes to this file will be lost
# every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class UpdateTransactionDisplayTest < TestCase
    def test_update_transaction_display
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'update_transaction_display_test')

      # setup request object
      request = {}
      request['test'] = true
      request['terminalName'] = 'Test Terminal'
      request['transaction'] = new_transaction_display_transaction

      response = blockchyp.update_transaction_display(request)

      assert_not_nil(response)
      # response assertions
      assert(response['success'])
    end

    def new_transaction_display_transaction
      val = {}
      val['subtotal'] = '35.00'
      val['tax'] = '5.00'
      val['total'] = '70.00'
      val['items'] = new_transaction_display_items
      val
    end

    def new_transaction_display_items
      val = []
      val.push(new_transaction_display_item_2)
      val
    end

    def new_transaction_display_item_2
      val = {}
      val['description'] = 'Leki Trekking Poles'
      val['price'] = '35.00'
      val['quantity'] = 2
      val['extended'] = '70.00'
      val['discounts'] = new_transaction_display_discounts
      val
    end
          
    def new_transaction_display_discounts
      val = []
      val.push(new_transaction_display_discount_2)
      val
    end

    def new_transaction_display_discount_2
      val = {}
      val['description'] = 'memberDiscount'
      val['amount'] = '10.00'
      val
    end
            
  end
end
