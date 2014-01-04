require 'rubygems'
require 'socket'
require_relative 'applepayload'
require_relative 'ssl_helper'
require 'openssl'
#
module Pushofy
  class ApplePush
    def initialize(payload_hash, settings)
      @deviceTokenHex = payload_hash["device"]
      @payload_hash = payload_hash.delete('device')
      @settings = settings
    end
    def push
      path = @cert_name
      ssl_client = Pushofy::ConnectionToAppleServer::ssl_connect(@settings[:host], @settings[:port], @settings[:password], @settings[:cert])
      ssl_client.connect
      device = [@deviceTokenHex]
      device_token_binary = device.pack('H*')
      pt = device_token_binary
      pm = @payload_hash.to_json
      message = [0, 0, 32, pt, 0, pm.size, pm].pack('ccca*cca*')
      ssl_client.write(message)
      ssl_client.flush
    end

    def feedback
      host = 'feedback.sandbox.push.apple.com'
      path =  Dir.pwd + '/app/controllers/CertificateName.pem'
      ssl_client = Pushofy::ConnectionToAppleServer::ssl_connect(host, 2196, path)
      ssl_client.connect
      apns_feedback = []
      while message = ssl_client.gets
        timestamp, _token_size, token = message.unpack('N1n1H*')
        apns_feedback << [Time.at(timestamp), token]
      end
      ssl.close
      sock.close
    end
  end
end
