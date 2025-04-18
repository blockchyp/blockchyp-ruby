# frozen_string_literal: true

# Copyright 2019-2025 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class TCEntryTest < TestCase
    def test_tc_entry

      puts "Running test_tc_entry..."

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
      }
      response = blockchyp.tc_log(setup_request)

      # Set request parameters
      request = {
        logEntryId: response[:results][0][:id]
      }

      response = blockchyp.tc_entry(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert(!response[:id].empty?)
      assert(!response[:terminalId].empty?)
      assert(!response[:terminalName].empty?)
      assert(!response[:timestamp].empty?)
      assert(!response[:name].empty?)
      assert(!response[:content].empty?)
      assert(response[:hasSignature])
      assert(!response[:signature].empty?)
    end
  end
end
