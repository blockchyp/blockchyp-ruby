# frozen_string_literal: true

# Copyright 2019-2024 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class TCTemplateUpdateTest < TestCase
    def test_tc_template_update

      puts "Running test_tc_template_update..."

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
        alias: uuid,
        name: 'HIPPA Disclosure',
        content: 'Lorem ipsum dolor sit amet.'
      }

      response = blockchyp.tc_update_template(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert(!response[:alias].empty?)
      assert_equal('HIPPA Disclosure', response[:name])
      assert_equal('Lorem ipsum dolor sit amet.', response[:content])
    end
  end
end
