# frozen_string_literal: true

require ::File.expand_path("test_helper", __dir__)

module BlockChyp
  class UpdateTransactionDisplayTest < TestCase
    def test_update_transaction_display

      config = self.load_test_config()

      blockchyp = BlockChyp.new(config["apiKey"], config["bearerToken"], config["signingKey"])
      blockchyp.gatewayHost = config["gatewayHost"]
      blockchyp.testGatewayHost = config["testGatewayHost"]

      self.test_delay(blockchyp, "UpdateTransactionDisplayTest")


      # setup request object
      request = Hash.new
      request["test"] = true
      request["terminalName"] = "Test Terminal"
      request["transaction"] = newTransactionDisplayTransaction()
      response = blockchyp.updateTransactionDisplay(request)

      assert_not_nil(response)
      # response assertions
      assert(response["success"])
    end
    def newTransactionDisplayTransaction
      val = Hash.new
      val["subtotal"] = "35.00"
      val["tax"] = "5.00"
      val["total"] = "70.00"
      val["items"] = newTransactionDisplayItems()
      return val
    end
    def newTransactionDisplayItems()
      val = Array.new
      val.push(newTransactionDisplayItem2())
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
      val.push(newTransactionDisplayDiscount2())
      return val
    end
    def newTransactionDisplayDiscount2()
      val = Hash.new
      val["description"] = "memberDiscount"
      val["amount"] = "10.00"
      return val
    end

  end
end
