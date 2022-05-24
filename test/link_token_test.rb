# frozen_string_literal: true

# Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class LinkTokenTest < TestCase
    def test_link_token
      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]

      test_delay(blockchyp, 'link_token_test', config[:defaultTerminalName])

      # Set request parameters
      setup_request = {
        pan: '4111111111111111',
        test: true,
        customer: {
          customerRef: 'TESTCUSTOMER',
          firstName: 'Test',
          lastName: 'Customer'
        }
      }

      response = blockchyp.enroll(setup_request)

      # Set request parameters
      request = {
        token: response[:token],
        customerId: response[:customer][:id]
      }

      response = blockchyp.link_token(request)

      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
