# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  id: '<QUESTION ID>',
  ordinal: 1,
  questionText: 'Would you shop here again?',
  questionType: 'yes_no',
  enabled: true
}

response = blockchyp.updateSurveyQuestion(request)

puts "Response: #{response.inspect}"
