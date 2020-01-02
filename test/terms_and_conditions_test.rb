# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class TermsAndConditionsTest < TestCase
    def test_terms_and_conditions

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]

      self.test_delay(blockchyp, "TermsAndConditionsTest")


      # setup request object
      request = Hash.new
      request["test"] = true
      request["terminalName"] = "Test Terminal"
      request["tcName"] = "HIPPA Disclosure"
      request["tcContent"] = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ullamcorper id urna quis pulvinar. Pellentesque vestibulum justo ac nulla consectetur tristique. Suspendisse arcu arcu, viverra vel luctus non, dapibus vitae augue. Aenean ac volutpat purus. Curabitur in lacus nisi. Nam vel sagittis eros. Curabitur faucibus ut nisl in pulvinar. Nunc egestas, orci ut porttitor tempus, ante mauris pellentesque ex, nec feugiat purus arcu ac metus. Cras sodales ornare lobortis. Aenean lacinia ultricies purus quis pharetra. Cras vestibulum nulla et magna eleifend eleifend. Nunc nibh dolor, malesuada ut suscipit vitae, bibendum quis dolor. Phasellus ultricies ex vitae dolor malesuada, vel dignissim neque accumsan."
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
