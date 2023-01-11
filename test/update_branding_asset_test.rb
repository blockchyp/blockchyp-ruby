# frozen_string_literal: true

# Copyright 2019-2023 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class UpdateBrandingAssetTest < TestCase
    def test_update_branding_asset

      puts "Running test_update_branding_asset..."

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
        mediaId: response[:id],
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

      response = blockchyp.update_branding_asset(request)
      assert_not_nil(response)
      # response assertions
      assert(response[:success])
    end
  end
end
