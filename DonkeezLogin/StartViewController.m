#import "StartViewController.h"
#import "Backendless.h"

#import "RegisterViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation StartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _rememberMeSwitch.on = backendless.userService.isStayLoggedIn;
    if (backendless.userService.currentUser) {
        [_logoutView setHidden:NO];
    }
    @try {
        [backendless initAppFault];
    }
    @catch (Fault *fault) {
        [self showAlert:fault.message];
    }
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.readPermissions = @[@"email",@"public_profile",@"read_stream",@"user_hometown", @"user_birthday",@"user_about_me"];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Private Methods
-(void)showAlert:(NSString *)message {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Fault:" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
}

#pragma mark -
#pragma mark Public Methods

-(void)showSuccessView
{
    _logoutView.hidden = NO;
}

#pragma mark -
#pragma mark IBAction

-(IBAction)rememberMe:(UISwitch *)sender
{
    [backendless.userService setStayLoggedIn:sender.on];
}

-(IBAction)loginWithFacebook:(id)sender
{
//    NSDictionary * fields = @{
//                              @"email":@"email",
//                              @"first_name":@"firstname",
//                              @"last_name":@"lastname",
//                              @"name":@"name",
//                              @"gender":@"gender"
//                              
//                              };
//    [backendless.userService
//     easyLoginWithFacebookFieldsMapping:fields
//     permissions:@[@"email"]
//     response:^(id response) {
//         NSLog(@"%@", response);
//     }
//     error:^(Fault *fault) {
//         NSLog(@"%@", fault.detail);
//     }];
//
//
//    
}


-(IBAction)login:(id)sender
{
    [backendless.userService
     login:self.loginInput.text
     password:self.passwordInput.text
     response:^(BackendlessUser *user) {
         _logoutView.hidden = NO;
         NSLog(@"%@", user);
     }
     error:^(Fault *fault) {
         NSLog(@"%@", fault.detail);
     }];
}

#pragma mark -
#pragma mark - IBAction for Unwind Seque

-(IBAction)cancel:(UIStoryboardSegue *)segue {
    if ([[segue identifier] isEqualToString:@"Cancel.RegisterViewController"]) {

        [backendless.userService logout:nil];
        return;
    }
}

-(void)registration:(UIStoryboardSegue *)segue
{
    _loginInput.text = @"";
    _passwordInput.text = @"";
}

#pragma mark -


-(IBAction)logout:(id)sender
{
    [backendless.userService
     logout:^(id response) {
         _logoutView.hidden = YES;
         NSLog(@"%@", response);
     }
     error:^(Fault *fault) {
         NSLog(@"%@", fault);
     }];
}

#pragma mark Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"RegisterViewController"]) {
        return;
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end