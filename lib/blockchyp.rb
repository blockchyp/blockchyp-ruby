# frozen_string_literal: true

require_relative "blockchyp_client"

module CardType
  CREDIT = 0
  DEBIT = 1
  EBT = 2
  BLOCKCHAIN_GIFT = 3
end

module SignatureFormat
  NONE = ""
  PNG = "png"
  JPG = "jpg"
  GIF = "gif"
end

module PromptType
  AMOUNT = "amount"
  EMAIL = "email"
  PHONE_NUMBER = "phone"
  CUSTOMER_NUMBER = "customer-number"
  REWARDS_NUMBER = "rewards-number"
end

module BlockChyp
  class BlockChyp < BlockChypClient

    def heartbeat(test)
      return self.gateway_get("/api/heartbeat", test)
    end


    # Executes a standard direct preauth and capture.
    def charge(request)
      return self.route_terminal_request(request, "/api/charge", "/api/charge", "POST")
    end

    # Executes a preauthorization intended to be captured later.
    def preauth(request)
      return self.route_terminal_request(request, "/api/preauth", "/api/preauth", "POST")
    end

    # Tests connectivity with a payment terminal.
    def ping(request)
      return self.route_terminal_request(request, "/api/test", "/api/terminal-test", "POST")
    end

    # Checks the remaining balance on a payment method.
    def balance(request)
      return self.route_terminal_request(request, "/api/balance", "/api/balance", "POST")
    end

    # Clears the line item display and any in progress transaction.
    def clear(request)
      return self.route_terminal_request(request, "/api/clear", "/api/terminal-clear", "POST")
    end

    # Prompts the user to accept terms and conditions.
    def termsAndConditions(request)
      return self.route_terminal_request(request, "/api/tc", "/api/terminal-tc", "POST")
    end

    # Appends items to an existing transaction display Subtotal, Tax, and
    # Total are overwritten by the request. Items with the same description
    # are combined into groups.
    def updateTransactionDisplay(request)
      return self.route_terminal_request(request, "/api/txdisplay", "/api/terminal-txdisplay", "PUT")
    end

    # Displays a new transaction on the terminal.
    def newTransactionDisplay(request)
      return self.route_terminal_request(request, "/api/txdisplay", "/api/terminal-txdisplay", "POST")
    end

    # Asks the consumer text based question.
    def textPrompt(request)
      return self.route_terminal_request(request, "/api/text-prompt", "/api/text-prompt", "POST")
    end

    # Asks the consumer a yes/no question.
    def booleanPrompt(request)
      return self.route_terminal_request(request, "/api/boolean-prompt", "/api/boolean-prompt", "POST")
    end

    # Displays a short message on the terminal.
    def message(request)
      return self.route_terminal_request(request, "/api/message", "/api/message", "POST")
    end

    # Executes a refund.
    def refund(request)
      return self.route_terminal_request(request, "/api/refund", "/api/refund", "POST")
    end

    # Adds a new payment method to the token vault.
    def enroll(request)
      return self.route_terminal_request(request, "/api/enroll", "/api/enroll", "POST")
    end

    # Activates or recharges a gift card.
    def giftActivate(request)
      return self.route_terminal_request(request, "/api/gift-activate", "/api/gift-activate", "POST")
    end



    # Executes a manual time out reversal.
    #
    # We love time out reversals. Don't be afraid to use them whenever a
    # request to a BlockChyp terminal times out. You have up to two minutes to
    # reverse any transaction. The only caveat is that you must assign
    # transactionRef values when you build the original request. Otherwise, we
    # have no real way of knowing which transaction you're trying to reverse
    # because we may not have assigned it an id yet. And if we did assign it
    # an id, you wouldn't know what it is because your request to the terminal
    # timed out before you got a response.
    def reverse(request)
      return self.gateway_request("/api/reverse", request, "POST")
    end

    # Captures a preauthorization.
    def capture(request)
      return self.gateway_request("/api/capture", request, "POST")
    end

    # Closes the current credit card batch.
    def closeBatch(request)
      return self.gateway_request("/api/close-batch", request, "POST")
    end

    # Discards a previous preauth transaction.
    def void(request)
      return self.gateway_request("/api/void", request, "POST")
    end


  end
end
