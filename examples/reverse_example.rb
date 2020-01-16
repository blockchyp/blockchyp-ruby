# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# setup request object
request = {}
request['terminalName'] = 'Test Terminal'
request['transactionRef'] = '<LAST TRANSACTION REF>'

response = blockchyp.reverse(request)

puts "Response: #{response.inspect}"
