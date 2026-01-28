# frozen_string_literal: true

# Copyright 2019-2026 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class PANEnrollTest < TestCase
    def test_pan_enroll

      puts "Running test_pan_enroll..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]

      test_delay(blockchyp, 'pan_enroll_test', config[:defaultTerminalName])




      # Set request parameters
      request = {
        pan: '4111111111111111',
        test: true,
        customer: {
          customerRef: 'TESTCUSTOMER',
          firstName: 'Test',
          lastName: 'Customer'
        }
      }

      response = blockchyp.enroll(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert(response[:approved])
      assert(response[:test])
      assert_equal(response[:authCode].length, 6)
      assert(!response[:transactionId].empty?)
      assert(!response[:timestamp].empty?)
      assert(!response[:tickBlock].empty?)
      assert_equal('approved', response[:responseDescription])
      assert(!response[:paymentType].empty?)
      assert(!response[:maskedPan].empty?)
      assert(!response[:entryMethod].empty?)
      assert_equal('KEYED', response[:entryMethod])
      assert(!response[:token].empty?)
    end
  end
end
