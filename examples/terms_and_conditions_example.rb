# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  test: true,
  terminalName: 'Test Terminal',

  # Alias for a Terms and Conditions template configured in the BlockChyp
  # dashboard.
  tcAlias: 'hippa',

  # Name of the contract or document if not using an alias.
  tcName: 'HIPPA Disclosure',

  # Full text of the contract or disclosure if not using an alias.
  tcContent: 'Full contract text',

  # File format for the signature image.
  sigFormat: SignatureFormat::PNG,

  # Width of the signature image in pixels.
  sigWidth: 200,

  # Whether or not a signature is required. Defaults to true.
  sigRequired: true
}

response = blockchyp.termsAndConditions(request)

puts "Response: #{response.inspect}"
