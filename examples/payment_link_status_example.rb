# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  linkCode: '<PAYMENT LINK CODE>'
}

response = blockchyp.paymentLinkStatus(request)

puts "Response: #{response.inspect}"
