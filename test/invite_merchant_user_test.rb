# frozen_string_literal: true

# Copyright 2019-2023 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class InviteMerchantUserTest < TestCase
    def test_invite_merchant_user

      puts "Running test_invite_merchant_user..."

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
      request = {
        email: 'doublea@blockchypteam.m8r.co',
        firstName: 'Aaron',
        lastName: 'Anderson'
      }

      response = blockchyp.invite_merchant_user(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
