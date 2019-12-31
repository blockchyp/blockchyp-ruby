# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class SimpleBatchCloseTest < TestCase
    def test_simpleBatchClose

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]



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
