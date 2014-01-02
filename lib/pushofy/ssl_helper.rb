require 'openssl'
require 'socket'
require_relative 'sslconnection'

module Pushofy
  module ConnectionToAppleServer
    def self.ssl_connect(host, port, password,cerfile)
      ssl_connect = SSLConnection.new
      ssl_connect.context = OpenSSL::SSL::SSLContext.new
      key4_pem = File.read(cerfile)
      ssl_connect.context.key = OpenSSL::PKey::RSA.new(key4_pem, password)
      ssl_connect.context.cert = OpenSSL::X509::Certificate.new(key4_pem)
      ssl_connect.tcp_client = TCPSocket.new host, port
      OpenSSL::SSL::SSLSocket.new(ssl_connect.tcp_client, ssl_connect.context)
    end
  end
end
