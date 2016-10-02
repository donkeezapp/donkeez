#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (nonatomic, weak) IBOutlet UIView *logoutView;
@property (nonatomic, weak) IBOutlet UISwitch *rememberMeSwitch;

-(void)showSuccessView;

-(IBAction)rememberMe:(UISwitch *)sender;
-(IBAction)loginWithFacebook:(id)sender;
-(IBAction)login:(id)sender;
-(IBAction)registration:(UIStoryboardSegue *)segue;
-(IBAction)cancel:(UIStoryboardSegue *)segue;
-(IBAction)logout:(id)sender;
@end