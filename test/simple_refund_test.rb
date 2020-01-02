# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class SimpleRefundTest < TestCase
    def test_simple_refund

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]

      self.test_delay(blockchyp, "SimpleRefundTest")

      # setup request object
      request = Hash.new
      request["pan"] = "4111111111111111"
      request["amount"] = "25.55"
      request["test"] = true
      request["transactionRef"] = self.get_uuid
      response = blockchyp.charge(request)


      # setup request object
      request = Hash.new
      request["transactionId"] = response["transactionId"]
      request["test"] = true
      response = blockchyp.refund(request)

      assert_not_nil(response)
      # response assertions
      assert(response["approved"])
    end

  end
end
