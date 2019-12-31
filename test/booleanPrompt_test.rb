# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class BooleanPromptTest < TestCase
    def test_booleanPrompt

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]



      # setup request object
      request = Hash.new
      request["test"] = true
      request["terminalName"] = "Test Terminal"
      request["prompt"] = "Would you like to become a member?"
      request["yesCaption"] = "Yes"
      request["noCaption"] = "No"
      response = blockchyp.booleanPrompt(request)


      assert_not_nil(response)
      # response assertions
      assert(response["success"])
      assert(response["response"])
    end








  end
end
