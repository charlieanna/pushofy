require 'rubygems'
require 'socket'
require_relative 'applepayload'
require_relative 'ssl_helper'
require 'openssl'
#
module Pushofy
  class ApplePush
    def push(payload_hash, deviceTokenHex,cert_name)
      host = 'gateway.push.apple.com'
      # path =  Dir.pwd + '/app/controllers/ProductionCertificate.pem'
      path = Dir.pwd + cert_name
      ssl_client = Pushify::ConnectionToAppleServer::ssl_connect("gateway.push.apple.com", 2195, path)
      ssl_client.connect
      device = [deviceTokenHex]
      device_token_binary = device.pack('H*')
      pt = device_token_binary
      pm = payload_hash.to_json
      message = [0, 0, 32, pt, 0, pm.size, pm].pack('ccca*cca*')
      ssl_client.write(message)
      ssl_client.flush
    end

    def feedback
      host = 'feedback.sandbox.push.apple.com'
      path =  Dir.pwd + '/app/controllers/CertificateName.pem'
      ssl_client = ConnectionToAppleServer::ssl_connect(host, 2196, path)
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
