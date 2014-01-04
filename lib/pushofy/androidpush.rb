require 'rubygems'
require 'net/http'
require 'net/https'
require 'uri'
#
module Pushofy
  class AndroidPush
    def initialize(body,settings)
      @settings = settings
      @body = body
    end
    def push
      uri = URI('https://android.googleapis.com/gcm/send')
      auth_key = "key=#{@settings[:api_key]}"
      headers = { 'Content-Type' => 'application/json',
                  'Authorization' => auth_key }
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.post(uri.path, @body.to_json, headers)
    end
  end
end
