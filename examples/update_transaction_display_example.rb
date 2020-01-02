# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new("SPBXTSDAQVFFX5MGQMUMIRINVI", "7BXBTBUPSL3BP7I6Z2CFU6H3WQ", "bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e")

# setup request object
request = Hash.new
request["test"] = true
request["terminalName"] = "Test Terminal"
request["transaction"] = newTransactionDisplayTransaction()

response = blockchyp.updateTransactionDisplay(request)

if (response["success"])
  puts "Succeded"
end

def newTransactionDisplayTransaction()
  val = hash.new
  val["subtotal"] = "60.00"
  val["tax"] = "5.00"
  val["total"] = "65.00"
  val["items"] = newTransactionDisplayItems()
  return val
end
def newTransactionDisplayItems()
  val = Array.new
  val = val.push(newTransactionDisplayItem2())
  return val
end
def newTransactionDisplayItem2()
  val = Hash.new
  val["description"] = "Leki Trekking Poles"
  val["price"] = "35.00"
  val["quantity"] = 2
  val["extended"] = "70.00"
  val["discounts"] = newTransactionDisplayDiscounts()
  return val
end
def newTransactionDisplayDiscounts()
  val = Array.new
  val = val.push(newTransactionDisplayDiscount2())
  return val
end
def newTransactionDisplayDiscount2()
  val = Hash.new
  val["description"] = "memberDiscount"
  val["amount"] = "10.00"
  return val
end
