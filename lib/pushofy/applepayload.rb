require_relative 'payload'
#
module Pushofy
  class ApplePayload < Payload
    attr_accessor :message
    attr_accessor :sound_name
    attr_accessor :badge_number
    attr_accessor :action_key_caption
    attr_accessor :dict
    def initialize(message, sound_name, badge_number, action_key_caption, dict)
      @message = message
      @sound_name = sound_name
      @badge_number = badge_number
      @action_key_caption = action_key_caption
      @dict = dict
    end
  end
end
