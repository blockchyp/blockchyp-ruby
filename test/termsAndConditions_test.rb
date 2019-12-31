# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class TermsAndConditionsTest < TestCase
    def test_termsAndConditions

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]



      # setup request object
      request = Hash.new
      request["test"] = true
      request["terminalName"] = "Test Terminal"
      request["tcName"] = "HIPPA Disclosure"
      request["tcContent"] = "Full contract text"
      request["sigFormat"] = SignatureFormat::PNG
      request["sigWidth"] = 200
      request["sigRequired"] = true
      response = blockchyp.termsAndConditions(request)


      assert_not_nil(response)
      # response assertions
      assert(response["success"])
    end










  end
end
