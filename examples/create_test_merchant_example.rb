# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  dbaName: 'DBA name.',
  companyName: 'test merchant customer name.'
}

response = blockchyp.createTestMerchant(request)

puts "Response: #{response.inspect}"
