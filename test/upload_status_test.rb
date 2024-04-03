# frozen_string_literal: true

# Copyright 2019-2024 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class UploadStatusTest < TestCase
    def test_upload_status

      puts "Running test_upload_status..."

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
        uploadId: setup_request[:uploadId]
      }

      response = blockchyp.upload_status(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
