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
request['amount'] = '50.00'

response = blockchyp.giftActivate(request)

puts "Response: #{response.inspect}"
