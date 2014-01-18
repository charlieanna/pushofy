# Pushify

This gem has support for both APNS(sending push notifications to iOS devices) and also GCM(sending push notifications to Android Devices). This gem was extracted the push notification server I built for IdleCampus. 

The basic idea behind this gem is that first you each device has a unique device id. So when the user starts his app, you send the device id along with the device type and the device token(APNS) or Registeration id(GCM) to the developer.idlecampus.com server and within your own app you save the save along with the device id. For example Ankur is saved to the application server database with a device id 12345485459 and in the push notification server his details get saved as device_id:12345485459, device_type:Android and device_token:sdhbfdsfbdjkbkjfbdksljbfdskjbfs. So when you want to send a notification to particular user, you only call something like 
```
uri = URI('http://developer.idlecampus.com/push/push1')
headers = { 'Content-Type' => 'application/json' }
http = Net::HTTP.new(uri.host, uri.port)
resp, _ = http.post(uri.path, hash.to_json, headers)
```
          
where hash is
```ruby
entries_hash = {}
entries_hash['devices'] = devices
entries_hash['message'] = @message
entries_hash['app'] = @app
entries_hash['from'] = @from
timetable_hash['push'] = entries_hash 
```
    

    
and devices are all the unique ids you get from the database.

You can also use the website to store your certificate for you in case of APNS and the register id in case of GCM. You only have to go and create an account for yourself.

Use this gem for sending push to iOS devices and Android Devices just by uploading your certificate to developer.idlecampus.com and registering your users on it.

Below you will also find the iOS code and Android Code you can use in your mobile applications if you wish to leave handling the push notifications and the ceritfications to us. 

Feel free to fork the code to contribute to the project as shown at the bottom of this file.

## Installation

Add this line to your application's Gemfile:

    gem 'pushify'

And then execute:

   $ bundle

Or install it yourself as:

    $ gem install pushify

## Usage


Copy the code below in your AppDelegate.m file and also upload your certificate on developer.idlecampus.com by creating an account if you don't want to use push notifications yourself.

      - (void)application:(UIApplication *)app   didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
      NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
      NSString        *uuidString    = [defaults objectForKey: @"device_identifier"];
      
      if (!uuidString)
      {
      uuidString = (NSString *) CFUUIDCreateString (NULL, CFUUIDCreate(NULL));
      [defaults setObject: uuidString forKey: @"device_identifier"];
      [defaults synchronize]; // handle error
      }
      
      NSString *deviceToken = [[devToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
      deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
      [self sendProviderDeviceToken:deviceToken device_identifier:uuidString]; // custom method
      }
      
      
      -(void)sendProviderDeviceToken:(NSString *)registration_Id device_identifier:(NSString *)device_identifier {
      NSURL *aUrl = [NSURL URLWithString:@"http://developer.idlecampus.com/devices"];
      NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                         cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                     timeoutInterval:60.0];
      
      
      
      [request setHTTPMethod:@"POST"];
      NSString *postString = [NSString stringWithFormat:@"registration_id=%@&device_identifier=%@&device_type=IOS",registration_Id,device_identifier];
      [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
      NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request
                                                               delegate:self];
                                                               }


Android

Use the code below to send your device id to developer.idlecampus.com. 

      String serverUrl = "http://developer.idlecampus.com/devices";
      Log.i("idlecampus",serverUrl);
      Map<String, String> params = new HashMap<String, String>();
      params.put("registration_id", regId);
              
     String device_identifier = Settings.Secure.getString(getBaseContext().getContentResolver(), Settings.Secure.ANDROID_ID);
      
      params.put("device_identifier",device_identifier);
      params.put("device_type","Android");


 You can use this method for sending data to any server using a hashmap.

      public static void post(String endpoint, Map<String, String> params)
                throws IOException {
            URL url;
            try {
                url = new URL(endpoint);
            } catch (MalformedURLException e) {
                throw new IllegalArgumentException("invalid url: " + endpoint);
            }
            StringBuilder bodyBuilder = new StringBuilder();
            Iterator<Entry<String, String>> iterator = params.entrySet().iterator();
            // constructs the POST body using the parameters
            while (iterator.hasNext()) {
                Entry<String, String> param = iterator.next();
                bodyBuilder.append(param.getKey()).append('=')
                        .append(param.getValue());
                if (iterator.hasNext()) {
                    bodyBuilder.append('&');
                }
            }
            String body = bodyBuilder.toString();
            Log.i("idlecampus", "Posting '" + body + "' to " + url);
            byte[] bytes = body.getBytes();
            HttpURLConnection conn = null;
            try {
                conn = (HttpURLConnection) url.openConnection();
                conn.setDoOutput(true);
                conn.setUseCaches(false);
                conn.setFixedLengthStreamingMode(bytes.length);
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type",
                        "application/x-www-form-urlencoded;charset=UTF-8");
                // post the request
                OutputStream out = conn.getOutputStream();
                out.write(bytes);
                out.close();
                // handle the response
                int status = conn.getResponseCode();
                if (status != 200) {
                  throw new IOException("Post failed with error code " + status);
                }
            } finally {
                if (conn != null) {
                    conn.disconnect();
                }
            }
          }



 but if you want to design an app to send a push to user then register users along with their device ids

     NSString *cuser = [NSString stringWithCString:user.c_str()
                                           encoding:[NSString defaultCStringEncoding]];
      NSString *cemail =  [NSString stringWithCString:email.c_str()
                                             encoding:[NSString defaultCStringEncoding]];
      
      NSString *urlString = [NSString stringWithFormat:@"http://idlecampus.com/users/%@",cuser];
      NSURL *aUrl = [NSURL URLWithString:urlString];  //http://10.124.7.63:3000/users
     
      
      
      //The user has been registered here. and his details are now sent to the server for storage.
      HTTPDelegate *dd = [[HTTPDelegate alloc] init];
      
      
      
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      NSString *uuidString = [defaults objectForKey:@"device_identifier"];
      cout << uuidString;
      
      NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                         timeoutInterval:60.0];
      
      
      [request setHTTPMethod:@"POST"];
      NSString *postString = [NSString stringWithFormat:@"email=%@&jabber_id=%@&user[device_identifier]=%@&_method=%@", cemail,cuser, uuidString,@"PUT"];
      [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
      NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                    delegate:dd];
    }


and for Android use this

http://idlecampus.com/api/users

with params

```java
Map<String, String> params = new HashMap<String, String>();
String device_identifier = settings.getString("device_identifier", "");
params.put("device_identifier", device_identifier);
params.put("jabber_id", name + "@idlecampus.com");
params.put("email", email);
params.put("name", name);
params.put("password", password);
```



## Contributing

1. Fork it ( http://github.com/<my-github-username>/pushify/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
