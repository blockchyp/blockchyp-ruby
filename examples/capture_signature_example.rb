# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# setup request object
request = {}
request['terminalName'] = 'Test Terminal'
request['sigFormat'] = SignatureFormat::PNG
request['sigWidth'] = 200

response = blockchyp.captureSignature(request)

puts "Response: #{response.inspect}"
