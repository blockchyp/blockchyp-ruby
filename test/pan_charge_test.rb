# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class PANChargeTest < TestCase
    def test_pan_charge

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]

      self.test_delay(blockchyp, "PANChargeTest")


      # setup request object
      request = Hash.new
      request["pan"] = "4111111111111111"
      request["amount"] = "25.55"
      request["test"] = true
      request["transactionRef"] = self.get_uuid
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
      assert_equal("25.55", response["authorizedAmount"])
      assert_equal("KEYED", response["entryMethod"])
    end

  end
end