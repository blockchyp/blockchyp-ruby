# frozen_string_literal: true

# Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code is
# governed by a license that can be found in the LICENSE file.
#
# This file was generated automatically by the BlockChyp SDK Generator.
# Changes to this file will be lost every time the code is regenerated.

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class UpdateSlideShowTest < TestCase
    def test_update_slide_show
      config = load_test_config

      blockchyp = BlockChyp.new(
        config[:apiKey],
        config[:bearerToken],
        config[:signingKey]
      )
      blockchyp.gateway_host = config[:gatewayHost]
      blockchyp.test_gateway_host = config[:testGatewayHost]

      test_delay(blockchyp, 'update_slide_show_test', config[:defaultTerminalName])

      # Set request parameters
      setup_request = {
        fileName: 'aviato.png',
        fileSize: 18843,
        uploadId: uuid
      }

      response = blockchyp.upload_media(setup_request)

      # Set request parameters
      request = {
        name: 'Test Slide Show',
        delay: 5,
        slides: [
          {
            mediaId: 
          }
        ]
      }

      response = blockchyp.update_slide_show(request)

      assert_not_nil(response)
      # response assertions
      assert(response[:success])
      assert_equal('Test Slide Show', response[:name])
    end
  end
end
