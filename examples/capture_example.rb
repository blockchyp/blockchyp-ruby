# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# setup request object
request = {}
request['test'] = true
request['transactionId'] = '<PREAUTH TRANSACTION ID>'

response = blockchyp.capture(request)

puts "Response: #{response.inspect}"
