# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  customerId: 'ID of the customer to delete'
}

response = blockchyp.deleteCustomer(request)

puts "Response: #{response.inspect}"
