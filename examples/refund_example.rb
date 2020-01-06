# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['terminalName'] = 'Test Terminal'
request['transactionId'] = '<PREVIOUS TRANSACTION ID>'
request['amount'] = '5.00'

response = blockchyp.refund(request)

if response['approved']
  puts 'Approved'
end

