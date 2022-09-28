# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  transactionRef: '<TX REF>',
  amount: '199.99',
  description: 'Widget',
  subject: 'Widget invoice',
  transaction: {
    subtotal: '195.00',
    tax: '4.99',
    total: '199.99',
    items: [
      {
        description: 'Widget',
        price: '195.00',
        quantity: 1
      }
    ]
  },
  autoSend: true,
  customer: {
    customerRef: 'Customer reference string',
    firstName: 'FirstName',
    lastName: 'LastName',
    companyName: 'Company Name',
    emailAddress: 'notifications@blockchypteam.m8r.co',
    smsNumber: '(123) 123-1231'
  }
}

response = blockchyp.sendPaymentLink(request)

puts "Response: #{response.inspect}"
