require 'openssl'
#
module Pushofy
  class SSLConnection
    attr_accessor :context, :tcp_client, :ssl_client
    def initialize
    end
  end
end
