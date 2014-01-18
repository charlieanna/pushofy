require "pushofy/version"
require 'rubygems'
require 'socket'
require_relative 'applepayload'
require_relative 'ssl_helper'
require 'openssl'
module Pushofy
  #
  class Push

    def initialize(args = {})
      @id = args[:id]
      @message = args[:message]
      @app = args[:app]
      @from = args[:from]
    end



    def send_push
      device = Device.find(@id)
      device_type = device.device_type
      if device_type == 'IOS'
        send_to_ios(device)
      elsif device_type == 'Android'
        send_to_android(device)
      end
    end

    def send_to_ios(device)


      payload_hash = {
        aps: {
          alert: {
            body: "You have a new #{@app}, form #{@from}"
          },
          sound: 'default',
          badge: 1,
        },
        app: @app,
        url: @message
      }

      ApplePush.new(payload_hash, device_token_hex).push
    end

    def send_to_android(device)
      body = {}
      arr = []
      arr << device.registration_id
      body['registration_ids'] = arr
      # body['collapse_key'] = 'Updates Available'
      #    body['registration_ids'] = registration_ids
      #    body['data'] = 'Hi this is my first push message'
      #    body['delay_while_idle'] = # true or false
      #    body['time_to_live'] = # number in seconds
      android_payload = { 'message' =>  "You have a new #{app} from #{from}" }
      android_payload['app'] = @app
      android_payload['url'] = @message
      body['data'] = android_payload
      a = AndroidPush.new
      a.push(body)
    end
  end

end
