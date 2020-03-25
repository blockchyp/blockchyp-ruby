# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# setup request object
request = {}
request['transactionId'] = 'ID of transaction to retrieve'

response = blockchyp.transactionStatus(request)

puts "Response: #{response.inspect}"
