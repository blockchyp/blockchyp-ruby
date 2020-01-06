# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['amount'] = '27.00'

response = blockchyp.preauth(request)

if response['approved']
  puts 'Approved'
end

puts 'authCode:' + response['authCode']
puts 'authorizedAmount:' + response['authorizedAmount']
