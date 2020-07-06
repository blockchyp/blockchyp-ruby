# frozen_string_literal: true

# Copyright 2019 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically. Changes to this file will be lost
# every time the code is regenerated.

require_relative 'blockchyp_client'

module CardType
  CREDIT = 0
  DEBIT = 1
  EBT = 2
  BLOCKCHAIN_GIFT = 3
end

module SignatureFormat
  NONE = ''
  PNG = 'png'
  JPG = 'jpg'
  GIF = 'gif'
end

module PromptType
  AMOUNT = 'amount'
  EMAIL = 'email'
  PHONE_NUMBER = 'phone'
  CUSTOMER_NUMBER = 'customer-number'
  REWARDS_NUMBER = 'rewards-number'
  FIRST_NAME = 'first-name'
  LAST_NAME = 'last-name'
end

module AVSResponse
  NOT_APPLICABLE = ''
  NOT_SUPPORTED = 'not_supported'
  RETRY = 'retry'
  NO_MATCH = 'no_match'
  ADDRESS_MATCH = 'address_match'
  POSTAL_CODE_MATCH = 'zip_match'
  ADDRESS_AND_POSTAL_CODE_MATCH = 'match'
end

module BlockChyp
  # the main autogenerated blockchyp client
  class BlockChyp < BlockChypClient

    def heartbeat(test)
      gateway_request('GET', '/api/heartbeat', { test: test })
    end

    # Tests connectivity with a payment terminal.
    def ping(request)
      route_terminal_request('POST', '/api/test', '/api/terminal-test', request)
    end

    # Executes a standard direct preauth and capture.
    def charge(request)
      route_terminal_request('POST', '/api/charge', '/api/charge', request)
    end

    # Executes a preauthorization intended to be captured later.
    def preauth(request)
      route_terminal_request('POST', '/api/preauth', '/api/preauth', request)
    end

    # Executes a refund.
    def refund(request)
      route_terminal_request('POST', '/api/refund', '/api/refund', request)
    end

    # Adds a new payment method to the token vault.
    def enroll(request)
      route_terminal_request('POST', '/api/enroll', '/api/enroll', request)
    end

    # Activates or recharges a gift card.
    def gift_activate(request)
      route_terminal_request('POST', '/api/gift-activate', '/api/gift-activate', request)
    end

    # Checks the remaining balance on a payment method.
    def balance(request)
      route_terminal_request('POST', '/api/balance', '/api/balance', request)
    end

    # Clears the line item display and any in progress transaction.
    def clear(request)
      route_terminal_request('POST', '/api/clear', '/api/terminal-clear', request)
    end

    # Returns the current status of a terminal.
    def terminal_status(request)
      route_terminal_request('POST', '/api/terminal-status', '/api/terminal-status', request)
    end

    # Prompts the user to accept terms and conditions.
    def terms_and_conditions(request)
      route_terminal_request('POST', '/api/tc', '/api/terminal-tc', request)
    end

    # Captures and returns a signature.
    def capture_signature(request)
      route_terminal_request('POST', '/api/capture-signature', '/api/capture-signature', request)
    end

    # Displays a new transaction on the terminal.
    def new_transaction_display(request)
      route_terminal_request('POST', '/api/txdisplay', '/api/terminal-txdisplay', request)
    end

    # Appends items to an existing transaction display. Subtotal, Tax, and
    # Total are overwritten by the request. Items with the same description
    # are combined into groups.
    def update_transaction_display(request)
      route_terminal_request('PUT', '/api/txdisplay', '/api/terminal-txdisplay', request)
    end

    # Displays a short message on the terminal.
    def message(request)
      route_terminal_request('POST', '/api/message', '/api/message', request)
    end

    # Asks the consumer a yes/no question.
    def boolean_prompt(request)
      route_terminal_request('POST', '/api/boolean-prompt', '/api/boolean-prompt', request)
    end

    # Asks the consumer a text based question.
    def text_prompt(request)
      route_terminal_request('POST', '/api/text-prompt', '/api/text-prompt', request)
    end
    
    # Captures a preauthorization.
    def capture(request)
      gateway_request('POST', '/api/capture', request)
    end

    # Discards a previous preauth transaction.
    def void(request)
      gateway_request('POST', '/api/void', request)
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
      gateway_request('POST', '/api/reverse', request)
    end

    # Closes the current credit card batch.
    def close_batch(request)
      gateway_request('POST', '/api/close-batch', request)
    end

    # Creates and send a payment link to a customer.
    def send_payment_link(request)
      gateway_request('POST', '/api/send-payment-link', request)
    end

    # Retrieves the current status of a transaction.
    def transaction_status(request)
      gateway_request('POST', '/api/tx-status', request)
    end

    # Updates or creates a customer record.
    def update_customer(request)
      gateway_request('POST', '/api/update-customer', request)
    end

    # Retrieves a customer by id.
    def customer(request)
      gateway_request('POST', '/api/customer', request)
    end

    # Searches the customer database.
    def customer_search(request)
      gateway_request('POST', '/api/customer-search', request)
    end

    # Calculates the discount for actual cash transactions.
    def cash_discount(request)
      gateway_request('POST', '/api/cash-discount', request)
    end

    # Returns the batch history for a merchant.
    def batch_history(request)
      gateway_request('POST', '/api/batch-history', request)
    end

    # Returns the batch details for a single batch.
    def batch_details(request)
      gateway_request('POST', '/api/batch-details', request)
    end

    # Returns the transaction history for a merchant.
    def transaction_history(request)
      gateway_request('POST', '/api/tx-history', request)
    end

    # Returns profile information for a merchant.
    def merchant_profile(request)
      gateway_request('POST', '/api/public-merchant-profile', request)
    end

  end
end
