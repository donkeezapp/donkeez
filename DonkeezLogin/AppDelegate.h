#import <UIKit/UIKit.h>
#import "MainVC.h"
#import "Contest.h"
#import <OneSignal/OneSignal.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, strong)NSArray * genderList;
+ (AppDelegate *)appDelegate ;

@property(nonatomic, strong)UINavigationController * mainNav;
@property(nonatomic, strong)MainVC * mVC;


@property(nonatomic, strong)Contest * curUploadedContest;
@property(nonatomic, strong)NSString * deviceRegistrationID;
@property(nonatomic, strong)NSString * appStoreUrl;
@property(nonatomic, strong)OneSignal *signal;

-(void)GetUserInfo:(BackendlessUser * )user completion:(void(^)(UserInfo * userInfo))completion;
-(UserInfo *)GetUserInfo:(BackendlessUser * )user;
-(void)userDeviceTokenUpdate;
-(void)UpdateUserInfo:(BackendlessUser * )user;
@end
