# Pushify

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'pushify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pushify

## Usage


Copy the code below in your AppDelegate.m file and also upload your certificate on developer.idlecampus.com by creating an account if you don't want to use push notifications yourself.

// Delegation methods
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
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
   // self.registered = YES;
   
    
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


## Contributing

1. Fork it ( http://github.com/<my-github-username>/pushify/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
