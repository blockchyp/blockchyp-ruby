# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class TerminalManualEBTChargeTest < TestCase
    def test_terminalManualEbtCharge

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]



      # setup request object
      request = Hash.new
      request["terminalName"] = "Test Terminal"
      request["amount"] = "27.00"
      request["test"] = true
      request["cardType"] = CardType::EBT
      request["manualEntry"] = true
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
      assert_equal("27.00", response["authorizedAmount"])
      assert_equal("73.00", response["remainingBalance"])
    end








  end
end
