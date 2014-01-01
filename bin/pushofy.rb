require_relative "../lib/pushofy/applepush"
require_relative "../lib/pushofy/androidpush"
require_relative "../lib/pushofy/push"
require "active_support/core_ext"

# puts "Enter the message you want to send >"
# message = gets.chomp
# puts "Select the device you want to push to: "
# puts "iOS (1)"
# puts "Android(2)"
# choice = gets.to_i

# if choice == 1
# 	puts "Enter the device token of the iOS device:" 
#   device_token = gets.chomp
#   puts "Enter the certificate name >"
#   cert_name = gets.chomp

#   payload_hash = {}
# 	payload_hash['aps'] = {}
#   payload_hash['aps']['alert'] = {}
# 	payload_hash['aps']['alert']['body'] = message
# 	payload_hash['aps']['sound'] = 'default'
# 	payload_hash['aps']['badge'] = 1
# 	payload_hash['app'] = "dsfsdf"
# 	payload_hash['url'] = "dsfdfdsf"


#   Pushofy::ApplePush.new(payload_hash, device_token,"/#{cert_name}").push
# elsif choice == 2
# 	puts "Enter the device registration id of the Android device:"
#   device_registration = gets.chomp
# 	puts "Enter the api-key >"
# 	api_key = gets.chomp

# 	body = {}
# 	arr = []
# 	arr << device_registration
# 	body['registration_ids'] = arr
# 	app = "asdasd"
# 	from = "SAdasd"
# 	url = "asdas"
# 	android_payload = { 'message' =>  message }
# 	android_payload['app'] = app
# 	android_payload['url'] = url
# 	body['data'] = android_payload


#   a = Pushofy::AndroidPush.new(body,api_key).push
# end

# Things needed
# 1. Certificate CertificateName
# 2. device_token_hex
# 3. message
payload_hash = {}
payload_hash['aps'] = {}
payload_hash['aps']['alert'] = {}
payload_hash['aps']['alert']['body'] = "You have a new asdsada"
payload_hash['aps']['sound'] = 'default'
payload_hash['aps']['badge'] = 1
payload_hash['app'] = "dsfsdf"
payload_hash['url'] = "dsfdfdsf"

device_token_hex = "A078F1658F68521A278D0F5C41B9C4B0613E4A6DDC157FD8ED1567CDA5634DA4"
# puts payload_hash
Pushofy::ApplePush.new(payload_hash, device_token_hex,'/Users/apple/Documents/workspace/pushofy/DevCert.pem').push

# # Things needed
# # 1. key
# # 2. device_token_hex
# # 3. message
body = {}
arr = []
arr << "APA91bFrtSnrO-ySKb8wn4Jevou1qpsOVXzqVSxzMcKEkgvcDsnqt1-3VPEYoMQZeQyPajffJo3s7ra5KrfBUhpdRJkXVe43mOWeIKc8y2H9SMqvgrbtOTBvS69sNhUmLX0FQK5s1h8q"
body['registration_ids'] = arr
app = "asdasd"
from = "SAdasd"
url = "asdas"
android_payload = { 'message' =>  "You have a new #{app} from #{from}" }
android_payload['app'] = app
android_payload['url'] = url
body['data'] = android_payload
p body
a = Pushofy::AndroidPush.new(body,"AIzaSyCoTPiIlC9OKuLh6i66focOp3zygWWOKXs")
a.push
