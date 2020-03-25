# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# setup request object
request = {}
request['amount'] = '199.99'
request['description'] = 'Widget'
request['subject'] = 'Widget invoice'
request['transaction'] = new_transaction_display_transaction
request['autoSend'] = true
request['customer'] = new_customer

response = blockchyp.sendPaymentLink(request)

puts "Response: #{response.inspect}"
def new_transaction_display_transaction
  val = {}
  val['subtotal'] = '195.00'
  val['tax'] = '4.99'
  val['total'] = '199.99'
  val['items'] = new_transaction_display_items
  val
end

def new_transaction_display_items
  val = []
  val = val.push(new_transaction_display_item_2)
  val
end

def new_transaction_display_item_2
  val = {}
  val['description'] = 'Widget'
  val['price'] = '195.00'
  val['quantity'] = 1
  val
end

def new_customer
  val = {}
  val['customerRef'] = 'Customer reference string'
  val['firstName'] = 'FirstName'
  val['lastName'] = 'LastName'
  val['companyName'] = 'Company Name'
  val['emailAddress'] = 'support@blockchyp.com'
  val['smsNumber'] = '(123) 123-1231'
  val
end

