#import "AppDelegate.h"
#import "Backendless.h"
#import "StartViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@import AudioToolbox;

//static NSString *APP_ID = @"9F503152-806A-C808-FF6B-40270E725800";
//static NSString *SECRET_KEY = @"E4E278FE-2493-468E-FFD9-E0458F0F1500";
static NSString *APP_ID = @"9C6CEC32-9137-2041-FFDA-B524DC109800";
static NSString *SECRET_KEY = @"B16C6437-49E2-736D-FF29-03322C2B5B00";
static NSString *VERSION_NUM = @"v1";


@implementation AppDelegate
+ (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{

    
    BOOL result = [[FBSDKApplicationDelegate sharedInstance]
                   application:application
                   openURL:url
                   sourceApplication:sourceApplication
                   annotation:annotation];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"cover,picture.type(large),id,name,first_name,last_name,gender,birthday,email,location,hometown,bio,photos"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 
                 NSLog(@"fetched user:%@", result);
                 
                 @try {
                     
                     NSDictionary * fields = @{
                                               @"email":@"email",
                                               @"first_name":@"firstname",
                                               @"last_name":@"lastname",
                                               @"name":@"name",
                                               @"gender":@"gender"
                                               
                                               };
                     
                    
                     FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
                     BackendlessUser *user = [backendless.userService loginWithFacebookSDK:token fieldsMapping:fields];

                     NSLog(@"USER: %@, %@", user,backendless.userService.currentUser);
                     [backendless.userService setStayLoggedIn:YES];
                     
                     
                     NSDictionary * picture = [result objectForKey:@"picture"];
                     if(picture){
                         NSString * url = [[picture objectForKey:@"data"] objectForKey:@"url"];
                         if(isSet(url)){
                             [backendless.userService.currentUser setProperty:@"avatar" object:url];
                           
                         }
                     }
                     [backendless.userService.currentUser setProperty:@"firstname" object:[result objectForKey:@"first_name"]];
                     [backendless.userService.currentUser setProperty:@"lastname" object:[result objectForKey:@"last_name"]];
                     [backendless.userService.currentUser setProperty:@"gender" object:[result objectForKey:@"gender"]];
                   
                     id<IDataStore> ds = [backendless.persistenceService of:[BackendlessUser class]];
                     [ds save:backendless.userService.currentUser];
                     
                     
                     // userInto table updating
                    
                     
                     [self UpdateUserInfo:backendless.userService.currentUser];
                     
//                     [(StartViewController *)self.window.rootViewController showSuccessView];
                     
//                     [GD WriteDefaultStore:backendless.userService.currentUser.email forKey:@"useremail"];
//                     [GD WriteDefaultStore:backendless.userService.currentUser.password forKey:@"userpwd"];

                     
                     
                     
                     
                     [GD onMain:^{
                         
                         [CYAnimation ChangeRootViewAnimation: [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_main"]];
                         
                     }];    
                     
                     
                 }
                 @catch (Fault *fault) {
                     NSLog(@"openURL: %@", fault);
                 }
                 
             }
         }];
    }
   
      return result;
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    [DebLog setIsActive:YES];
//
    backendless.hostURL = @"https://api.backendless.com";
//    [backendless initApp:APP_ID secret:SECRET_KEY version:VERSION_NUM];
//
//    return YES;
    _appStoreUrl = @"https://itunes.apple.com/app/id1148625354";
    NSString * langID = [[NSLocale preferredLanguages] objectAtIndex:0];
//    NSString *lang = [[NSLocale currentLocale] displayNameForKey:NSLocaleLanguageCode value:langID];
    
//    NSString * langCode = [langID substringToIndex:1];
 
    // check if iOS8

    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
        
    }
    
    
    NSString * firstStr =[langID substringToIndex:2];
    NSString * lang= [firstStr isEqualToString:@"fr"]?@"fr":@"en";
//    [MCLocalization loadFromLanguageURLPairs:languageURLPairs defaultLanguage:lang];
    
    NSDictionary * languageURLPairs = @{
                                        @"en":[[NSBundle mainBundle] URLForResource:@"en.json" withExtension:nil],
                                        @"fr":[[NSBundle mainBundle] URLForResource:@"fr.json" withExtension:nil],
                                        };
    [MCLocalization loadFromLanguageURLPairs:languageURLPairs defaultLanguage:@"en"];
    [MCLocalization sharedInstance].language = lang;
    [MCLocalization sharedInstance].noKeyPlaceholder = @"[No '{key}' in '{language}']";
    NSLog(@"%@", MCLocalString(@"TODAY"));
    
    _genderList = @[MCLocalString(@"Male"),MCLocalString(@"Female")];
    [backendless initApp:APP_ID secret:SECRET_KEY version:VERSION_NUM];
    @try {
        [backendless initAppFault];
    }
    @catch (Fault *fault) {
        NSLog(@"didFinishLaunchingWithOptions: %@", fault);
    }
   
    
 
    NSLog(@"USER: %@",backendless.userService.currentUser);
    
//        NSString * userEmail = [GD ReadDefaultStoreforKey:@"useremail"];
//        NSString * userPwd = [GD ReadDefaultStoreforKey:@"userpwd"];
    
        if(!backendless.userService.currentUser){
            
            NSNumber * isPassedIntro = [GD ReadDefaultStoreforKey:@"isPassedIntro"];
            
            if(isPassedIntro.integerValue != 1){
               
                    self.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"IntroVC"];
            }else{
                self.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_logo"];
            }

            
//            self.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"Splash2VC"];
        }else{
             self.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_main"];
        }
    
    // ONE SIGNAL
    self.signal = [[OneSignal alloc] initWithLaunchOptions:launchOptions appId:@"7007fdb3-c55f-44d1-8be9-f830070b54c1" handleNotification:^(NSString *message, NSDictionary *additionalData, BOOL isActive) {
        
    } autoRegister:NO];
    [self.signal registerForPushNotifications];
    [self.signal setSubscription:YES];

    
    //[backendless.messaging registerForRemoteNotifications];
    application.applicationIconBadgeNumber = 0;
    
   
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
//    NSLog(@"%@", userInfo);
//    AudioServicesPlaySystemSound(1307);
//    UIAlertView *message = [[UIAlertView alloc] initWithTitle:MCLocalString(@"Notification")
//                                                      message:[userInfo[@"aps"] objectForKey:@"alert"]
//                                                     delegate:nil
//                                            cancelButtonTitle:@"Ok"
//                                            otherButtonTitles:nil, nil];
//    [message show];
//    
    application.applicationIconBadgeNumber = 0;

    
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    NSLog(@"%@", notificationSettings);
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *deviceTokenStr = [backendless.messagingService deviceTokenAsString:deviceToken];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
            //        DeviceRegistration * der = [backendless.messagingService getRegistrations];
            
            //    AlertViewWithMSG(der.deviceId)
            NSLog(@"application:didRegisterForRemoteNotificationsWithDeviceToken: ->  deviceToken = %@", deviceTokenStr);
            NSDate *today = [NSDate date]; // get the current date
            NSCalendar* cal = [NSCalendar currentCalendar]; // get current calender
            NSDateComponents* dateOnlyToday = [cal components:( NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay ) fromDate:today];
            [dateOnlyToday setYear:([dateOnlyToday year] + 5)];
            NSDate *nextYear = [cal dateFromComponents:dateOnlyToday];
            [backendless.messagingService registerDeviceExpiration:nextYear];
            NSString *deviceRegistrationId = [backendless.messagingService registerDeviceToken:deviceTokenStr];
            //        kAppDelegate.deviceRegistrationID = deviceRegistrationId;
            kAppDelegate.deviceRegistrationID = [backendless.messaging getRegistrations].deviceId ;
            [self userDeviceTokenUpdate];
            NSLog(@"application:didRegisterForRemoteNotificationsWithDeviceToken: -> deviceRegistrationId = %@", deviceRegistrationId);
            
        }
        @catch (Fault *fault) {
            NSLog(@"application:didRegisterForRemoteNotificationsWithDeviceToken: -> deviceRegistrationId: FAULT = %@", fault);
            
        }
    });
   
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_DIDREGISTER_DEVICETOKEN object:nil];

}

-(void)userDeviceTokenUpdate{
    
    if(backendless.userService.currentUser && isSet(kAppDelegate.deviceRegistrationID)){
        [backendless.userService.currentUser updateProperties:@{@"deviceid": kAppDelegate.deviceRegistrationID}];
        
        [backendless.userService update:backendless.userService.currentUser response:^(BackendlessUser * buser) {
            NSLog(@"User has been updated (SYNC): %@", backendless.userService.currentUser);
        } error:^(Fault * error) {
            NSLog(@"FAULT: %@", error);
        }];
    }

}

-(void)UpdateUserInfo:(BackendlessUser * )user{
    
    BackendlessDataQuery *query = [BackendlessDataQuery new];
    
    query.whereClause = [NSString stringWithFormat:@"user_id = \'%@\'",user.userId ];
    
    QueryOptions *queryOptions = [QueryOptions new];
    
    query.queryOptions = queryOptions;
    id<IDataStore> dsUI = [backendless.persistenceService of:[UserInfo class]];
    Fault * fault;
    BackendlessCollection * coll = [dsUI find:query fault:&fault];
    
    if(coll.data.count > 0){
        UserInfo * ui = (UserInfo*)[coll.data objectAtIndex:0];
        ui.first_name = [user getProperty:@"firstname"];
        ui.last_name = [user getProperty:@"lastname"];
        ui.gender =  [user getProperty:@"gender"];
        ui.avatar =  [user getProperty:@"avatar"];
        ui.user_id = user.userId;
        ui.device_id = [user getProperty:@"deviceid"];
        ui.birthday = [user getProperty:@"birthday"];
        
        id<IDataStore> ds = [backendless.persistenceService of:[UserInfo class]];
        
        [ds save:ui];
    }else{
        UserInfo * ui = [[UserInfo alloc] init];
        ui.first_name = [user getProperty:@"firstname"];
        ui.last_name = [user getProperty:@"lastname"];
        ui.gender =  [user getProperty:@"gender"];
        ui.avatar =  [user getProperty:@"avatar"];
        ui.user_id = user.userId;
        ui.device_id = [user getProperty:@"deviceid"];
        ui.birthday = [user getProperty:@"birthday"];
        
        id<IDataStore> ds = [backendless.persistenceService of:[UserInfo class]];
        
        [ds save:ui];
    }
    
}

-(UserInfo *)GetUserInfo:(BackendlessUser * )user{
    
    
    BackendlessDataQuery *query = [BackendlessDataQuery new];
    
    query.whereClause = [NSString stringWithFormat:@"user_id = \'%@\'", user.userId ];
    
    QueryOptions *queryOptions = [QueryOptions new];
    
    query.queryOptions = queryOptions;
    id<IDataStore> dsUI = [backendless.persistenceService of:[UserInfo class]];
    
    
    BackendlessCollection *becoll = [dsUI find:query];
    if(becoll.data.count > 0){
        UserInfo * ui = [becoll.data objectAtIndex:0];
        return ui;
    }else{
        return nil;
    }
    
}
-(void)GetUserInfo:(BackendlessUser * )user completion:(void(^)(UserInfo * userInfo))completion{
    
    
    BackendlessDataQuery *query = [BackendlessDataQuery new];
    
    query.whereClause = [NSString stringWithFormat:@"user_id = \'%@\'", user.userId ];
    NSLog(@"whereClausre : %@", query.whereClause );
    QueryOptions *queryOptions = [QueryOptions new];
    
    query.queryOptions = queryOptions;
    id<IDataStore> dsUI = [backendless.persistenceService of:[UserInfo class]];
    
    
    [dsUI find:^(BackendlessCollection *becoll) {
        
        if(becoll.data.count > 0){
            UserInfo * ui = [becoll.data objectAtIndex:0];
            completion(ui);
            
        }else{
           completion(nil);
        }

        
    } error:^(Fault * fault) {
        completion(nil);
    }];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
     [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
