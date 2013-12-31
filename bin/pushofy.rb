require_relative "../lib/pushofy/applepush"
require_relative "../lib/pushofy/androidpush"
require "active_support/core_ext"


payload_hash = {}
payload_hash['aps'] = {}
payload_hash['aps']['alert'] = {}
payload_hash['aps']['alert']['body'] = "You have a new asdsada"
payload_hash['aps']['sound'] = 'default'
payload_hash['aps']['badge'] = 1
payload_hash['app'] = "dsfsdf"
payload_hash['url'] = "dsfdfdsf"
device_token_hex = "0C2C51D03FA6126CD25537F7CA68B32685B129629EE512DD8B0A4B61CB9B76B9"
puts payload_hash
Pushofy::ApplePush.new.push(payload_hash, device_token_hex,'/ProductionCertificate.pem')


body = {}
arr = []
arr << "0C2C51D03FA6126CD25537F7CA68B32685B129629EE512DD8B0A4B61CB9B76B9"
body['registration_ids'] = arr
app = "asdasd"
from = "SAdasd"
url = "asdas"
android_payload = { 'message' =>  "You have a new #{app} from #{from}" }
android_payload['app'] = app
android_payload['url'] = url
body['data'] = android_payload
a = Pushofy::AndroidPush.new
a.push(body)
