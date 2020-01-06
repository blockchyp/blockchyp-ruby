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
request['transaction'] = new_transaction_display_transaction

response = blockchyp.newTransactionDisplay(request)

if response['success']
  puts 'Succeded'
end

def new_transaction_display_transaction
  val = {}
  val['subtotal'] = '60.00'
  val['tax'] = '5.00'
  val['total'] = '65.00'
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
  val['description'] = 'Leki Trekking Poles'
  val['price'] = '35.00'
  val['quantity'] = 2
  val['extended'] = '70.00'
  val['discounts'] = new_transaction_display_discounts
  val
end

def new_transaction_display_discounts
  val = []
  val = val.push(new_transaction_display_discount_2)
  val
end

def new_transaction_display_discount_2
  val = {}
  val['description'] = 'memberDiscount'
  val['amount'] = '10.00'
  val
end


