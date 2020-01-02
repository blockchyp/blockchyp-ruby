# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class TerminalGiftCardBalanceTest < TestCase
    def test_terminal_gift_card_balance

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]

      self.test_delay(blockchyp, "TerminalGiftCardBalanceTest")


      # setup request object
      request = Hash.new
      request["test"] = true
      request["terminalName"] = "Test Terminal"
      response = blockchyp.balance(request)

      assert_not_nil(response)
      # response assertions
      assert(response["success"])
      assert(!response["remainingBalance"].empty?)
    end

  end
end
