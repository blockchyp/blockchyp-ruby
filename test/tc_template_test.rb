# frozen_string_literal: true

# Copyright 2019-2026 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class TCTemplateTest < TestCase
    def test_tc_template

      puts "Running test_tc_template..."

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
        alias: uuid,
        name: 'HIPPA Disclosure',
        content: 'Lorem ipsum dolor sit amet.'
      }
      response = blockchyp.tc_update_template(setup_request)

      # Set request parameters
      request = {
        templateId: response[:id]
      }

      response = blockchyp.tc_template(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert_equal('HIPPA Disclosure', response[:name])
      assert_equal('Lorem ipsum dolor sit amet.', response[:content])
    end
  end
end
