# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  mediaId: '<MEDIA ID>',
  padded: true,
  ordinal: 10,
  startDate: '01/06/2021',
  startTime: '14:00',
  endDate: '11/05/2024',
  endTime: '16:00',
  notes: 'Test Branding Asset',
  preview: false,
  enabled: true
}

response = blockchyp.updateBrandingAsset(request)

puts "Response: #{response.inspect}"
