

#import <UIKit/UIKit.h>
#import "Backendless.h"

typedef enum {
    IPSCamera = 0,
    IPSGallery
} ImagePickerSource ;

@interface BaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constTop;
@property(nonatomic, strong) UILabel * lblNoneData;
@property(nonatomic, strong)UIButton * backbutton;

@property(nonatomic)BOOL hideNavBar;

@property (copy) void (^ImagePickFinish) (UIImage * image);
@property (copy) void (^ImagePickCancel) ();

-(void)localize;
-(void)onBackButton;
-(void)goToProfileView;


-(void)ShowActionSheetForImagePickCompletion:(void(^)(UIImage * img))successBlock cancel:(void(^)())cancelBlock;
-(void)ShowActionSheetForImagePickCompletion:(void(^)(UIImage * img))successBlock cancel:(void(^)())cancelBlock source:(ImagePickerSource)ips;

@end
