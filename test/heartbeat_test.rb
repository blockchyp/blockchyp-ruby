# frozen_string_literal: true

require ::File.expand_path('test_helper', __dir__)

module BlockChyp
  class HeartbeatTest < TestCase
    def test_heartbeat
      config = load_test_config

      blockchyp = BlockChyp.new(
        config['apiKey'],
        config['bearerToken'],
        config['signingKey']
      )
      blockchyp.gateway_host = config['gatewayHost']
      blockchyp.test_gateway_host = config['testGatewayHost']

      response = blockchyp.heartbeat(true)
      assert_not_nil(response)
      assert(response['success'])
      assert(!response['timestamp'].empty?)
      assert(!response['clockchain'].empty?)
      assert(!response['latestTick'].empty?)
      assert(!response['merchantPk'].empty?)
    end
  end
end
