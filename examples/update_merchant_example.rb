# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  merchantId: '<MERCHANT ID>',
  test: true,
  dbaName: 'Test Merchant',
  companyName: 'Test Merchant',
  billingAddress: {
    address1: '1060 West Addison',
    city: 'Chicago',
    stateOrProvince: 'IL',
    postalCode: '60613'
  }
}

response = blockchyp.updateMerchant(request)

puts "Response: #{response.inspect}"
