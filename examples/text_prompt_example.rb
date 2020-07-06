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

  # Type of prompt. Can be 'email', 'phone', 'customer-number', or
  # 'rewards-number'.
  promptType: PromptType::EMAIL
}

response = blockchyp.textPrompt(request)

puts "Response: #{response.inspect}"
