# frozen_string_literal: true

# Copyright 2019-2023 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class MediaAssetTest < TestCase
    def test_media_asset

      puts "Running test_media_asset..."

      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]
      blockchyp.dashboard_host = config[:dashboardHost]





      # Set request parameters
      setup_request = {
        fileName: 'aviato.png',
        fileSize: 18843,
        uploadId: uuid
      }
      file = File.open("test/testdata/aviato.png")
      content = file.read
      response = blockchyp.upload_media(setup_request, content)

      # Set request parameters
      request = {
        mediaId: response[:id]
      }

      response = blockchyp.media_asset(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert(!response[:id].empty?)
      assert_equal('aviato.png', response[:originalFile])
      assert(!response[:fileUrl].empty?)
      assert(!response[:thumbnailUrl].empty?)
    end
  end
end
