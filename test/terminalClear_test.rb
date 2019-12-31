# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class TerminalClearTest < TestCase
    def test_terminalClear

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]



      # setup request object
      request = Hash.new
      request["test"] = true
      request["terminalName"] = "Test Terminal"
      response = blockchyp.clear(request)


      assert_not_nil(response)
      # response assertions
      assert(response["success"])
    end





  end
end
