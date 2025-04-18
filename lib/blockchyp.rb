# frozen_string_literal: true

# Copyright 2019-2025 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require_relative 'blockchyp_client'

module CardType
  CREDIT = 0
  DEBIT = 1
  EBT = 2
  BLOCKCHAIN_GIFT = 3
  HEALTHCARE = 4
end

module SignatureFormat
  NONE = ''
  PNG = 'png'
  JPG = 'jpg'
  GIF = 'gif'
end

module RoundingMode
  UP = 'up'
  NEAREST = 'nearest'
  DOWN = 'down'
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

module CVMType
  SIGNATURE = 'Signature'
  OFFLINE_PIN = 'Offline PIN'
  ONLINE_PIN = 'Online PIN'
  CDCVM = 'CDCVM'
  NO_CVM = 'No CVM'
end

module HealthcareType
  HEALTHCARE = 'healthcare'
  PRESCRIPTION = 'prescription'
  VISION = 'vision'
  CLINIC = 'clinic'
  DENTAL = 'dental'
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

    # Retrieves card metadata.
    def card_metadata(request)
      route_terminal_request('POST', '/api/card-metadata', '/api/card-metadata', request)
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

    # Returns a list of queued transactions on a terminal.
    def list_queued_transactions(request)
      route_terminal_request('POST', '/api/queue/list', '/api/queue/list', request)
    end

    # Deletes a queued transaction from the terminal.
    def delete_queued_transaction(request)
      route_terminal_request('POST', '/api/queue/delete', '/api/queue/delete', request)
    end

    # Reboot a payment terminal.
    def reboot(request)
      route_terminal_request('POST', '/api/reboot', '/api/terminal-reboot', request)
    end
    
    # Returns routing and location data for a payment terminal.
    def locate(request)
      gateway_request('POST', '/api/terminal-locate', request)
    end

    # Captures a preauthorization.
    def capture(request)
      gateway_request('POST', '/api/capture', request)
    end

    # Discards a previous transaction.
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

    # Resends payment link.
    def resend_payment_link(request)
      gateway_request('POST', '/api/resend-payment-link', request)
    end

    # Cancels a payment link.
    def cancel_payment_link(request)
      gateway_request('POST', '/api/cancel-payment-link', request)
    end

    # Retrieves the status of a payment link.
    def payment_link_status(request)
      gateway_request('POST', '/api/payment-link-status', request)
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

    # Returns pricing policy for a merchant.
    def pricing_policy(request)
      gateway_request('POST', '/api/read-pricing-policy', request)
    end

    # Returns a list of partner statements.
    def partner_statements(request)
      gateway_request('POST', '/api/partner-statement-list', request)
    end

    # Returns detail for a single partner statement.
    def partner_statement_detail(request)
      gateway_request('POST', '/api/partner-statement-detail', request)
    end

    # Returns a list of merchant invoices.
    def merchant_invoices(request)
      gateway_request('POST', '/api/merchant-invoice-list', request)
    end

    # Returns detail for a single merchant-invoice statement.
    def merchant_invoice_detail(request)
      gateway_request('POST', '/api/merchant-invoice-detail', request)
    end

    # Returns low level details for how partner commissions were calculated
    # for a specific merchant statement.
    def partner_commission_breakdown(request)
      gateway_request('POST', '/api/partner-commission-breakdown', request)
    end

    # Returns profile information for a merchant.
    def merchant_profile(request)
      gateway_request('POST', '/api/public-merchant-profile', request)
    end

    # Deletes a customer record.
    def delete_customer(request)
      gateway_request('DELETE', '/api/customer/' + request[:customerId], request)
    end

    # Retrieves payment token metadata.
    def token_metadata(request)
      gateway_request('GET', '/api/token/' + request[:token], request)
    end

    # Links a token to a customer record.
    def link_token(request)
      gateway_request('POST', '/api/link-token', request)
    end

    # Removes a link between a customer and a token.
    def unlink_token(request)
      gateway_request('POST', '/api/unlink-token', request)
    end

    # Deletes a payment token.
    def delete_token(request)
      gateway_request('DELETE', '/api/token/' + request[:token], request)
    end


    # Generates and returns api credentials for a given merchant.
    def merchant_credential_generation(request)
      dashboard_request('POST', '/api/generate-merchant-creds', request)
    end

    # Submits and application to add a new merchant account.
    def submit_application(request)
      dashboard_request('POST', '/api/submit-application', request)
    end

    # Adds a test merchant account.
    def get_merchants(request)
      dashboard_request('POST', '/api/get-merchants', request)
    end

    # Adds or updates a merchant account. Can be used to create or update test
    # merchants. Only gateway partners may create new live merchants.
    def update_merchant(request)
      dashboard_request('POST', '/api/update-merchant', request)
    end

    # List all active users and pending invites for a merchant account.
    def merchant_users(request)
      dashboard_request('POST', '/api/merchant-users', request)
    end

    # Invites a user to join a merchant account.
    def invite_merchant_user(request)
      dashboard_request('POST', '/api/invite-merchant-user', request)
    end

    # Adds a live gateway merchant account.
    def add_gateway_merchant(request)
      dashboard_request('POST', '/api/add-gateway-merchant', request)
    end

    # Adds a test merchant account.
    def add_test_merchant(request)
      dashboard_request('POST', '/api/add-test-merchant', request)
    end

    # Deletes a test merchant account. Supports partner scoped API credentials
    # only. Live merchant accounts cannot be deleted.
    def delete_test_merchant(request)
      dashboard_request('DELETE', '/api/test-merchant/' + request[:merchantId], request)
    end

    # List all merchant platforms configured for a gateway merchant.
    def merchant_platforms(request)
      dashboard_request('GET', '/api/plugin-configs/' + request[:merchantId], request)
    end

    # List all merchant platforms configured for a gateway merchant.
    def update_merchant_platforms(request)
      dashboard_request('POST', '/api/plugin-configs', request)
    end

    # Deletes a boarding platform configuration.
    def delete_merchant_platforms(request)
      dashboard_request('DELETE', '/api/plugin-config/' + request[:platformId], request)
    end

    # Returns all terminals associated with the merchant account.
    def terminals(request)
      dashboard_request('GET', '/api/terminals', request)
    end

    # Deactivates a terminal.
    def deactivate_terminal(request)
      dashboard_request('DELETE', '/api/terminal/' + request[:terminalId], request)
    end

    # Activates a terminal.
    def activate_terminal(request)
      dashboard_request('POST', '/api/terminal-activate', request)
    end

    # Returns a list of terms and conditions templates associated with a
    # merchant account.
    def tc_templates(request)
      dashboard_request('GET', '/api/tc-templates', request)
    end

    # Returns a single terms and conditions template.
    def tc_template(request)
      dashboard_request('GET', '/api/tc-templates/' + request[:templateId], request)
    end

    # Updates or creates a terms and conditions template.
    def tc_update_template(request)
      dashboard_request('POST', '/api/tc-templates', request)
    end

    # Deletes a single terms and conditions template.
    def tc_delete_template(request)
      dashboard_request('DELETE', '/api/tc-templates/' + request[:templateId], request)
    end

    # Returns up to 250 entries from the Terms and Conditions log.
    def tc_log(request)
      dashboard_request('POST', '/api/tc-log', request)
    end

    # Returns a single detailed Terms and Conditions entry.
    def tc_entry(request)
      dashboard_request('GET', '/api/tc-entry/' + request[:logEntryId], request)
    end

    # Returns all survey questions for a given merchant.
    def survey_questions(request)
      dashboard_request('GET', '/api/survey-questions', request)
    end

    # Returns a single survey question with response data.
    def survey_question(request)
      dashboard_request('GET', '/api/survey-questions/' + request[:questionId], request)
    end

    # Updates or creates a survey question.
    def update_survey_question(request)
      dashboard_request('POST', '/api/survey-questions', request)
    end

    # Deletes a survey question.
    def delete_survey_question(request)
      dashboard_request('DELETE', '/api/survey-questions/' + request[:questionId], request)
    end

    # Returns results for a single survey question.
    def survey_results(request)
      dashboard_request('POST', '/api/survey-results', request)
    end

    # Returns the media library for a given partner, merchant, or
    # organization.
    def media(request)
      dashboard_request('GET', '/api/media', request)
    end

    # Uploads a media asset to the media library.
    def upload_media(request, file)
      upload_request('/api/upload-media', request, file)
    end

    # Retrieves the current status of a file upload.
    def upload_status(request)
      dashboard_request('GET', '/api/media-upload/' + request[:uploadId], request)
    end

    # Returns the media details for a single media asset.
    def media_asset(request)
      dashboard_request('GET', '/api/media/' + request[:mediaId], request)
    end

    # Deletes a media asset.
    def delete_media_asset(request)
      dashboard_request('DELETE', '/api/media/' + request[:mediaId], request)
    end

    # Returns a collection of slide shows.
    def slide_shows(request)
      dashboard_request('GET', '/api/slide-shows', request)
    end

    # Returns a single slide show with slides.
    def slide_show(request)
      dashboard_request('GET', '/api/slide-shows/' + request[:slideShowId], request)
    end

    # Updates or creates a slide show.
    def update_slide_show(request)
      dashboard_request('POST', '/api/slide-shows', request)
    end

    # Deletes a single slide show.
    def delete_slide_show(request)
      dashboard_request('DELETE', '/api/slide-shows/' + request[:slideShowId], request)
    end

    # Returns the terminal branding stack for a given set of API credentials.
    def terminal_branding(request)
      dashboard_request('GET', '/api/terminal-branding', request)
    end

    # Updates a branding asset.
    def update_branding_asset(request)
      dashboard_request('POST', '/api/terminal-branding', request)
    end

    # Deletes a branding asset.
    def delete_branding_asset(request)
      dashboard_request('DELETE', '/api/terminal-branding/' + request[:assetId], request)
    end

  end
end
