# frozen_string_literal: true

# Copyright 2019-2024 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class PaymentLinkStatusTest < TestCase
    def test_payment_link_status

      puts "Running test_payment_link_status..."

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
        amount: '199.99',
        description: 'Widget',
        subject: 'Widget invoice',
        transaction: {
          subtotal: '195.00',
          tax: '4.99',
          total: '199.99',
          items: [
            {
              description: 'Widget',
              price: '195.00',
              quantity: 1
            }
          ]
        },
        autoSend: true,
        customer: {
          customerRef: 'Customer reference string',
          firstName: 'FirstName',
          lastName: 'LastName',
          companyName: 'Company Name',
          emailAddress: 'notifications@blockchypteam.m8r.co',
          smsNumber: '(123) 123-1231'
        }
      }
      response = blockchyp.send_payment_link(setup_request)

      # Set request parameters
      request = {
        linkCode: response[:linkCode]
      }

      response = blockchyp.payment_link_status(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
