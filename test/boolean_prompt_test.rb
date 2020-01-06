# frozen_string_literal: true

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class BooleanPromptTest < TestCase
    def test_boolean_prompt
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'BooleanPromptTest')
      # setup request object
      request = {}
      request['test'] = true
      request['terminalName'] = 'Test Terminal'
      request['prompt'] = 'Would you like to become a member?'
      request['yesCaption'] = 'Yes'
      request['noCaption'] = 'No'
      response = blockchyp.booleanPrompt(request)

      assert_not_nil(response)
      # response assertions
      assert(response['success'])
      assert(response['response'])
    end

  end
end
