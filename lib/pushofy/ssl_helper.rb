require 'openssl'
require 'socket'
require_relative 'sslconnection'

module Pushofy
  module ConnectionToAppleServer
    def self.ssl_connect(host, port, cerfile)
      ssl_connect = SSLConnection.new
      ssl_connect.context = OpenSSL::SSL::SSLContext.new
      key4_pem = File.read(cerfile)
      ssl_connect.context.key = OpenSSL::PKey::RSA.new(key4_pem, 'akk322')
      ssl_connect.context.cert = OpenSSL::X509::Certificate.new(key4_pem)
      host = 'gateway.push.apple.com'
      ssl_connect.tcp_client = TCPSocket.new host, 2195
      OpenSSL::SSL::SSLSocket.new(ssl_connect.tcp_client, ssl_connect.context)
    end
  end
end
