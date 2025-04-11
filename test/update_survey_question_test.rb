# frozen_string_literal: true

# Copyright 2019-2025 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class UpdateSurveyQuestionTest < TestCase
    def test_update_survey_question

      puts "Running test_update_survey_question..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]





      # Set request parameters
      request = {
        ordinal: 1,
        questionText: 'Would you shop here again?',
        questionType: 'yes_no'
      }

      response = blockchyp.update_survey_question(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert_equal('Would you shop here again?', response[:questionText])
      assert_equal('yes_no', response[:questionType])
    end
  end
end
