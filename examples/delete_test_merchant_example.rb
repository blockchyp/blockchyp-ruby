# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  merchantId: 'ID for the test merchant being deleted.'
}

response = blockchyp.deleteTestMerchant(request)

puts "Response: #{response.inspect}"
