# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class SimpleBatchCloseTest < TestCase
    def test_simple_batch_close

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]

      self.test_delay(blockchyp, "SimpleBatchCloseTest")

      # setup request object
      request = Hash.new
      request["pan"] = "4111111111111111"
      request["amount"] = "25.55"
      request["test"] = true
      request["transactionRef"] = self.get_uuid
      response = blockchyp.charge(request)


      # setup request object
      request = Hash.new
      request["test"] = true
      response = blockchyp.closeBatch(request)

      assert_not_nil(response)
      # response assertions
      assert(response["success"])
      assert(!response["capturedTotal"].empty?)
      assert(!response["openPreauths"].empty?)
    end

  end
end
