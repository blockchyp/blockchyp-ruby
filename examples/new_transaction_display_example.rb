# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  test: true,
  terminalName: 'Test Terminal',
  transaction: {
    subtotal: '60.00',
    tax: '5.00',
    total: '65.00',
    items: [
      {
        description: 'Leki Trekking Poles',
        price: '35.00',
        quantity: 2,
        extended: '70.00',
        discounts: [
          {
            description: 'memberDiscount',
            amount: '10.00'
          }
        ]
      }
    ]
  }
}

response = blockchyp.newTransactionDisplay(request)

puts "Response: #{response.inspect}"
