# frozen_string_literal: true

# Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class TermsAndConditionsTest < TestCase
    def test_terms_and_conditions

      puts "Running test_terms_and_conditions..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]

      test_delay(blockchyp, 'terms_and_conditions_test', config[:defaultTerminalName])




      # Set request parameters
      request = {
        test: true,
        terminalName: config[:defaultTerminalName],
        tcName: 'HIPPA Disclosure',
        tcContent: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ullamcorper id urna quis pulvinar. Pellentesque vestibulum justo ac nulla consectetur tristique. Suspendisse arcu arcu, viverra vel luctus non, dapibus vitae augue. Aenean ac volutpat purus. Curabitur in lacus nisi. Nam vel sagittis eros. Curabitur faucibus ut nisl in pulvinar. Nunc egestas, orci ut porttitor tempus, ante mauris pellentesque ex, nec feugiat purus arcu ac metus. Cras sodales ornare lobortis. Aenean lacinia ultricies purus quis pharetra. Cras vestibulum nulla et magna eleifend eleifend. Nunc nibh dolor, malesuada ut suscipit vitae, bibendum quis dolor. Phasellus ultricies ex vitae dolor malesuada, vel dignissim neque accumsan.',
        sigFormat: SignatureFormat::PNG,
        sigWidth: 200,
        sigRequired: true
      }

      response = blockchyp.terms_and_conditions(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
