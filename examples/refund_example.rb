# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "terminalName": 'Test Terminal',
  "transactionId": '<PREVIOUS TRANSACTION ID>',

  # Optional amount for partial refunds.
  "amount": '5.00'
}

response = blockchyp.refund(request)

puts "Response: #{response.inspect}"
