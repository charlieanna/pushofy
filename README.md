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


  String serverUrl = "http://developer.idlecampus.com" + "/devices";
        Log.i("idlecampus",serverUrl);
        Map<String, String> params = new HashMap<String, String>();
        params.put("registration_id", regId);
     // Restore preferences
        
        SharedPreferences settings = context.getSharedPreferences("XMPP", 0);
        String device_identifier = settings.getString("device_identifier", "");
        params.put("device_identifier",device_identifier);
        params.put("device_type","Android");

## Contributing

1. Fork it ( http://github.com/<my-github-username>/pushify/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
