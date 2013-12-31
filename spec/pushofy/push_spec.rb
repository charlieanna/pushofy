require_relative '../../lib/pushofy/push'
describe Pushofy::Push do

  before do

    args = {}
    args['id'] = "sadsda"
    args['message'] = "message"
    args['app'] = "app"
    args['from'] = "from"

    @push = Pushofy::Push.new(args)
  end
  subject {@push}
  it{should respond_to(:send_push)}
  it{should respond_to(:send_to_android)}
  it{should respond_to(:send_to_ios)}

  # context "#send_push" do
  #   it "sends a push to the device depending on the device type" do
  #     @push.send_push

  #   end
  # end

    context "#send_to_android" do
      it "sends a push to the android device" do
        @push.send_to_android
      end
    end

    context "#send_to_ios" do
      it "sends a push to the ios device" do
        @push.send_to_ios
      end
    end
  end
