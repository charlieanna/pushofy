require_relative "../lib/pushofy/applepush"
require_relative "../lib/pushofy/androidpush"
require_relative "../lib/pushofy/push"
require "active_support/core_ext"


payload_hash = {}
payload_hash['aps'] = {}
payload_hash['aps']['alert'] = {}
payload_hash['aps']['alert']['body'] = "You have a new asdsada"
payload_hash['aps']['sound'] = 'default'
payload_hash['aps']['badge'] = 1
payload_hash['app'] = "dsfsdf"
payload_hash['url'] = "dsfdfdsf"
device_token_hex = "a078f1658f68521a278d0f5c41b9c4b0613e4a6ddc157fd8ed1567cda5634da4"
# puts payload_hash
Pushofy::ApplePush.new(payload_hash, device_token_hex,'/CertificateName.pem').push


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
a = Pushofy::AndroidPush.new(body)
a.push
