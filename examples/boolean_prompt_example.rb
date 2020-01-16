# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['prompt'] = 'Would you like to become a member?'
request['yesCaption'] = 'Yes'
request['noCaption'] = 'No'

response = blockchyp.booleanPrompt(request)

puts "Response: #{response.inspect}"
