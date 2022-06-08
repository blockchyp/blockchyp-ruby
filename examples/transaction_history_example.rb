# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  maxResults: 10,
  batchId: '<BATCH ID>'
}

response = blockchyp.transactionHistory(request)

puts "Response: #{response.inspect}"
