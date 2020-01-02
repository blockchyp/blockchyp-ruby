# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class TerminalChargeTest < TestCase
    def test_terminal_charge

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]

      self.test_delay(blockchyp, "TerminalChargeTest")


      # setup request object
      request = Hash.new
      request["terminalName"] = "Test Terminal"
      request["amount"] = "25.15"
      request["test"] = true
      response = blockchyp.charge(request)

      assert_not_nil(response)
      # response assertions
      assert(response["approved"])
      assert(response["test"])
      assert_equal(response["authCode"].length, 6)
      assert(!response["transactionId"].empty?)
      assert(!response["timestamp"].empty?)
      assert(!response["tickBlock"].empty?)
      assert_equal("Approved", response["responseDescription"])
      assert(!response["paymentType"].empty?)
      assert(!response["maskedPan"].empty?)
      assert(!response["entryMethod"].empty?)
      assert_equal("25.15", response["authorizedAmount"])
    end

  end
end