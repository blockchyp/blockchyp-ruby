# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  name: 'Test Slide Show',
  delay: 5,
  slides: [
    {
      mediaId: '<MEDIA ID>'
    }
  ]
}

response = blockchyp.updateSlideShow(request)

puts "Response: #{response.inspect}"
