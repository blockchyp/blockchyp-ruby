# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  customer: {
    id: '<CUSTOMER ID>',
    customerRef: 'Customer reference string',
    firstName: 'FirstName',
    lastName: 'LastName',
    companyName: 'Company Name',
    emailAddress: 'notifications@blockchypteam.m8r.co',
    smsNumber: '(123) 123-1231'
  }
}

response = blockchyp.updateCustomer(request)

puts "Response: #{response.inspect}"
