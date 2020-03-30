# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "terminalName": 'Test Terminal',

  # File format for the signature image.
  "sigFormat": SignatureFormat::PNG,

  # Width of the signature image in pixels.
  "sigWidth": 200
}

response = blockchyp.captureSignature(request)

puts "Response: #{response.inspect}"
