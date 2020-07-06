# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  maxResults: 250,
  startIndex: 1
}

response = blockchyp.batchHistory(request)

puts "Response: #{response.inspect}"
