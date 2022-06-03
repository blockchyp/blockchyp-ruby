# frozen_string_literal: true

# Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class UpdateMerchantTest < TestCase
    def test_update_merchant

      puts "Running test_update_merchant..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]


      profile = config[:profiles][:partner]
      blockchyp = BlockChyp.new(
        profile[:apiKey],
        profile[:bearerToken],
        profile[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]



      # Set request parameters
      request = {
        test: true,
        dbaName: 'Test Merchant',
        companyName: 'Test Merchant',
        billingAddress: {
          address1: '1060 West Addison',
          city: 'Chicago',
          stateOrProvince: 'IL',
          postalCode: '60613'
        }
      }

      response = blockchyp.update_merchant(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
