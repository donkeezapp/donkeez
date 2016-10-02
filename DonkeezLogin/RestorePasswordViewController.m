#import "RestorePasswordViewController.h"
#import "Backendless.h"

@interface RestorePasswordViewController ()<UITextFieldDelegate>

@end

@implementation RestorePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}
-(void)restorePassword:(id)sender
{
    [_email resignFirstResponder];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [backendless.userService restorePassword:_email.text response:^(id res) {
        _resultText.text = MCLocalString(@"Check your email");
        _resultView.hidden = NO;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } error:^(Fault *error) {
        _resultText.text = [NSString stringWithFormat:@"Error: %@", error.detail];
        _resultView.hidden = NO;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}
-(void)done:(id)sender
{
    [_email resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
