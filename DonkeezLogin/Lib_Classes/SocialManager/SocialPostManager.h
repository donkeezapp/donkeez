

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>

@interface SocialPostManager : NSObject <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

+ (SocialPostManager *)sharedManager;

- (void)postViaEmail:(UIViewController *)viewController toRecipients:(NSArray *)toRecipients  subject:(NSString*)subject  attachementData:(NSData *)attachementData MSG:(NSString*)msg;
- (void)postViaMessage:(UIViewController *)viewController toRecipients:(NSArray *)toRecipients andMsg:(NSString*)msg attachementData:(NSData *)attachementData;
- (void)postToFacebook:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg;
- (void)postToTwitter:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg;
- (void)inviteToFacebook:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg andURL:(NSURL*)url;
- (void)inviteToTwitter:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg andURL:(NSURL*)url;
- (void)DefaultSharing:(NSString*)text image:(UIImage*)image viewController:(UIViewController*)VC;

-(void)GeneralShareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url viewController:(UIViewController*)vc  imageUrl:(NSURL*)imgUrl;
- (void)postToFacebook:(UIViewController *)viewController IMAGE:(UIImage*)postImage MSG:(NSString*)msg URL:(NSURL*)url;

- (void)inviteToFacebook;

@end
