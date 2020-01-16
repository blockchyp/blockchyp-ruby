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
request['transactionId'] = '<PREVIOUS TRANSACTION ID>'
request['amount'] = '5.00'

response = blockchyp.refund(request)

puts "Response: #{response.inspect}"
