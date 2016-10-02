#import <UIKit/UIKit.h>

@interface RestorePasswordViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITextField *email;
@property (nonatomic, weak) IBOutlet UIView *resultView;
@property (nonatomic, weak) IBOutlet UILabel *resultText;
-(IBAction)done:(id)sender;
-(IBAction)restorePassword:(id)sender;
@end
