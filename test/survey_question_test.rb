# frozen_string_literal: true

# Copyright 2019 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically. Changes to this file will be lost
# every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class SurveyQuestionTest < TestCase
    def test_survey_question
      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]

      test_delay(blockchyp, 'survey_question_test', config[:defaultTerminalName])

      # Set request parameters
      request = {
      }

      response = blockchyp.survey_question(request)

      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
