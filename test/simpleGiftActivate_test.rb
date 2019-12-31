# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class SimpleGiftActivateTest < TestCase
    def test_simpleGiftActivate

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]



      # setup request object
      request = Hash.new
      request["test"] = true
      request["terminalName"] = "Test Terminal"
      request["amount"] = "50.00"
      response = blockchyp.giftActivate(request)


      assert_not_nil(response)
      # response assertions
      assert(response["approved"])
      assert(!response["publicKey"].empty?)
    end






  end
end
