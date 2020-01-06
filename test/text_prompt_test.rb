# frozen_string_literal: true

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class TextPromptTest < TestCase
    def test_text_prompt
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      test_delay(blockchyp, 'TextPromptTest')
      # setup request object
      request = {}
      request['test'] = true
      request['terminalName'] = 'Test Terminal'
      request['promptType'] = PromptType::EMAIL
      response = blockchyp.textPrompt(request)

      assert_not_nil(response)
      # response assertions
      assert(response['success'])
      assert(!response['response'].empty?)
    end

  end
end
