# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# setup request object
request = {}
request['customer'] = new_customer

response = blockchyp.updateCustomer(request)

puts "Response: #{response.inspect}"
def new_customer
  val = {}
  val['id'] = 'ID of the customer to update'
  val['customerRef'] = 'Customer reference string'
  val['firstName'] = 'FirstName'
  val['lastName'] = 'LastName'
  val['companyName'] = 'Company Name'
  val['emailAddress'] = 'support@blockchyp.com'
  val['smsNumber'] = '(123) 123-1231'
  val
end

