# frozen_string_literal: true

# Copyright 2019 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically. Changes to this file will be lost
# every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class TerminalManualEBTChargeTest < TestCase
    def test_terminal_manual_ebt_charge
      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]

      test_delay(blockchyp, 'terminal_manual_ebt_charge_test', config[:defaultTerminalName])

      # Set request parameters
      request = {
        terminalName: config[:defaultTerminalName],
        amount: '27.00',
        test: true,
        cardType: CardType::EBT,
        manualEntry: true
      }

      response = blockchyp.charge(request)

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
      assert_equal('27.00', response[:authorizedAmount])
      assert_equal('73.00', response[:remainingBalance])
    end
  end
end
