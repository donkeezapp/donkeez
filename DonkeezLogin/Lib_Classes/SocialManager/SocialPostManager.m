

#import "SocialPostManager.h"
#import <FBSDKShareKit/FBSDKShareKit.h>

@implementation SocialPostManager

+ (SocialPostManager *)sharedManager
{
    static SocialPostManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[SocialPostManager alloc] init];
    });
    
    return _sharedManager;
}

- (NSString *)appName
{
//    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    return @"BeerRun";
}

- (NSString *)postMessage
{
    NSString *message = [NSString stringWithFormat:@"%@ App!!!\n", [self appName]];
    message = [message stringByAppendingString:@"\nCheck out "];
    message = [message stringByAppendingString:@"https://itunes.apple.com/app/humm/"];
    
    return message;
}

#pragma mark - Post To Social
- (void)postViaEmail:(UIViewController *)viewController toRecipients:(NSArray *)toRecipients subject:(NSString*)subject attachementData:(NSData *)attachementData MSG:(NSString*)msg
{
    if(![MFMailComposeViewController canSendMail]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Mail Accounts" message:@"You don't have a Mail account configured, please configure to send email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    // create an MFMailComposeViewController for sending an e-mail
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    if(isSet(subject)){
        [controller setSubject:subject];
    }else{
        [controller setSubject:[self appName]];
    }
    

    [controller setMessageBody:msg isHTML:YES];
    
    if (toRecipients) {
        [controller setToRecipients:toRecipients];
    }
    
    if (attachementData) {
        [controller addAttachmentData:attachementData mimeType:@"image/png" fileName:@"app.png"];
    } else {
//        UIImage *postImage = [UIImage imageNamed:@"app.png"];
//        [controller addAttachmentData:UIImagePNGRepresentation(postImage) mimeType:@"image/png" fileName:@"app.png"];
    }
    
    // show the MFMailComposeViewController
//    controller.modalPresentationStyle = UIModalPresentationCurrentContext;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [viewController presentViewController:controller animated:YES completion:^(void){
    
//        [[NSNotificationCenter defaultCenter] postNotificationName:SendEmailOrSMSDidEndNotification object:self ];

    }];
}


- (void)postViaMessage:(UIViewController *)viewController toRecipients:(NSArray *)toRecipients  andMsg:(NSString*)msg attachementData:(NSData *)attachementData
{
    if(![MFMessageComposeViewController canSendText]) {
        return;
    }
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    // set controller's delegate to this objects
    controller.messageComposeDelegate = self;
    [controller setSubject:[self appName]];

//    [controller setBody:[self postMessage]];
    [controller setBody:msg];

    if (toRecipients) {
        [controller setRecipients:toRecipients];
    }
    
    if (attachementData) {
        [controller addAttachmentData:attachementData typeIdentifier:@"public.data" filename:@"Humm.jpg"];
    } else {
        UIImage *postImage = [UIImage imageNamed:@"beer.png"];
        [controller addAttachmentData:UIImageJPEGRepresentation(postImage, 0.7f) typeIdentifier:@"public.data" filename:@"Humm.jpg"];
    }
    
    // show the MFMessageComposeViewController
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    [viewController presentViewController:controller animated:YES completion:^(void){
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:SendEmailOrSMSDidEndNotification object:self ];
        
    }];
}

- (void)inviteToFacebook
{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
    content.appLinkURL = [NSURL URLWithString:@"https://l.facebook.com/l.php?u=https%3A%2F%2Ffb.me%2F1298326973510807&h=XAQGQD5Uz"];
    //optionally set previewImageURL
    content.appInvitePreviewImageURL = [NSURL URLWithString:@"http://donkeez.com/invite_fb.jpg"];
    
    // Present the dialog. Assumes self is a view controller
    // which implements the protocol `FBSDKAppInviteDialogDelegate`.
    [FBSDKAppInviteDialog showFromViewController:viewController
                                     withContent:content
                                        delegate:nil];
}

- (void)inviteToFacebook:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg andURL:(NSURL*)url
{
    SLComposeViewController *socialSheet;
    socialSheet = [[SLComposeViewController alloc] init]; // initiate the Social Controller
    socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; // Tell him with what social platform to use it
    [socialSheet setInitialText:msg];
    [socialSheet addImage:postImage];
    [socialSheet addURL:url];
    [viewController presentViewController:socialSheet animated:YES completion:nil];
    
    [socialSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                break;
            case SLComposeViewControllerResultDone:
                break;
            default:
                break;
        }
    }];
    
//    
//    
//    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
////    content.appLinkURL = [NSURL URLWithString:@"https://www.mydomain.com/myapplink"];
//    content.appLinkURL=url;
//    //optionally set previewImageURL
////    content.appInvitePreviewImageURL = [NSURL URLWithString:@"https://www.mydomain.com/my_invite_image.jpg"];
//    
//    // present the dialog. Assumes self implements protocol `FBSDKAppInviteDialogDelegate`
//    [FBSDKAppInviteDialog showFromViewController:viewController withContent:content delegate:nil];
    
}
- (void)inviteToTwitter:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg andURL:(NSURL*)url
{
    
    SLComposeViewController *socialSheet;
    socialSheet = [[SLComposeViewController alloc] init]; // initiate the Social Controller
    socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; // Tell him with what social platform to use it
    [socialSheet setInitialText:msg];
    [socialSheet addImage:postImage];
    [socialSheet addURL:url];
    [viewController presentViewController:socialSheet animated:YES completion:nil];
    
    [socialSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                break;
            case SLComposeViewControllerResultDone:
                break;
            default:
                break;
        }
    }];
}
- (void)postToFacebook:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg
{
    SLComposeViewController *socialSheet;
    socialSheet = [[SLComposeViewController alloc] init]; // initiate the Social Controller
    socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; // Tell him with what social platform to use it
    [socialSheet setInitialText:msg];
    [socialSheet addImage:postImage];
    
    [viewController presentViewController:socialSheet animated:YES completion:nil];
    
    [socialSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                
                break;
            case SLComposeViewControllerResultDone:
                
                break;
            default:
                break;
        }
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:ShareDidEndIAdsWillShowNotification object:self ];
    }];
}
- (void)postToFacebook:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg URL:(NSURL*)url
{
    SLComposeViewController *socialSheet;
    socialSheet = [[SLComposeViewController alloc] init]; // initiate the Social Controller
    socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; // Tell him with what social platform to use it
    [socialSheet setInitialText:msg];
    [socialSheet addImage:postImage];
    [socialSheet addURL:url];
    [viewController presentViewController:socialSheet animated:YES completion:nil];
    
    [socialSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                
                break;
            case SLComposeViewControllerResultDone:
                
                break;
            default:
                break;
        }
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:ShareDidEndIAdsWillShowNotification object:self ];
    }];
}

- (void)postToTwitter:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg
{
    
    SLComposeViewController *socialSheet;
    socialSheet = [[SLComposeViewController alloc] init]; // initiate the Social Controller
    socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; // Tell him with what social platform to use it
    [socialSheet setInitialText:msg];
    [socialSheet addImage:postImage];

    [viewController presentViewController:socialSheet animated:YES completion:nil];
    
    [socialSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                break;
            case SLComposeViewControllerResultDone:
                break;
            default:
                break;
        }
    //    [[NSNotificationCenter defaultCenter] postNotificationName:ShareDidEndIAdsWillShowNotification object:self ];
    }];
}

#pragma mark - MFMailComposeViewControllerDelegate mothods
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if ((result == MFMailComposeResultFailed) && (error != NULL)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot send mail" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMessageComposeViewControllerDelegate mothods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultFailed) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot send message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)DefaultSharing:(NSString*)text image:(UIImage*)image viewController:(UIViewController*)VC{
    
    NSLog(@"shareButton pressed");
    NSString *texttoshare = text;
    UIImage *imagetoshare = image;
    NSArray *activityItems = @[texttoshare, imagetoshare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo];
    [VC presentViewController:activityVC animated:TRUE completion:nil];
    
}

-(void)GeneralShareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url viewController:(UIViewController*)vc imageUrl:(NSURL*)imgUrl
 {
     
         NSMutableArray *sharingItems = [NSMutableArray new];
     
         if (text) {
                 [sharingItems addObject:text];
         }else{
             text = @"";
         }
  
     
     
     if (url) {
         [sharingItems addObject:url];
     }else{
         url  = [NSURL URLWithString:kAppDelegate.appStoreUrl];
     }
     if (image) {
         [sharingItems addObject:image];
     }else{
         image = [UIImage imageNamed:@"logo1.png"];
     }
     
     if (imgUrl) {
         
         [sharingItems addObject:imgUrl];
     }else{
         imgUrl  = [NSURL URLWithString:kAppDelegate.appStoreUrl];
         [sharingItems addObject:imgUrl];
     }
         UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[text, url, image, imgUrl] applicationActivities:nil];
     
         [vc presentViewController:activityController animated:YES completion:nil];
     
     
     }


@end
