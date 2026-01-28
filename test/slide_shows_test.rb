# frozen_string_literal: true

# Copyright 2019-2026 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class SlideShowsTest < TestCase
    def test_slide_shows

      puts "Running test_slide_shows..."

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
        name: 'Test Slide Show',
        delay: 5
      }
      response = blockchyp.update_slide_show(setup_request)

      # Set request parameters
      request = {
      }

      response = blockchyp.slide_shows(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
