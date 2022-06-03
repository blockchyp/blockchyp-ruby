# frozen_string_literal: true

# Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class BooleanPromptTest < TestCase
    def test_boolean_prompt

      puts "Running test_boolean_prompt..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]

      test_delay(blockchyp, 'boolean_prompt_test', config[:defaultTerminalName])




      # Set request parameters
      request = {
        test: true,
        terminalName: config[:defaultTerminalName],
        prompt: 'Would you like to become a member?',
        yesCaption: 'Yes',
        noCaption: 'No'
      }

      response = blockchyp.boolean_prompt(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert(response[:response])
    end
  end
end
