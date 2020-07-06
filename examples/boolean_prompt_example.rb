# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  test: true,
  terminalName: 'Test Terminal',
  prompt: 'Would you like to become a member?',
  yesCaption: 'Yes',
  noCaption: 'No'
}

response = blockchyp.booleanPrompt(request)

puts "Response: #{response.inspect}"
