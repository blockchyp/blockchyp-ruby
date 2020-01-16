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
request['terminalName'] = 'Test Terminal'
request['tcAlias'] = 'hippa'
request['tcName'] = 'HIPPA Disclosure'
request['tcContent'] = 'Full contract text'
request['sigFormat'] = SignatureFormat::PNG
request['sigWidth'] = 200
request['sigRequired'] = true

response = blockchyp.termsAndConditions(request)

puts "Response: #{response.inspect}"
