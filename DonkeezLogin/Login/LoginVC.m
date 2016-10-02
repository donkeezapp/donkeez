//
//  LoginVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "LoginVC.h"


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [backendless.userService setStayLoggedIn:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)localize{
    
    _lblTitle.text = MCLocalString(@"Login");
    _lblSubTitle.text = MCLocalString(@"Great to see you!");
    [_btnForgot setTitle:MCLocalString(@"I forgot my password") forState:UIControlStateNormal];
    
    _lblEmail.text = MCLocalString(@"EMAIL");
    _lblPwd.text = MCLocalString(@"PASSWORD");
    _tfEmail.placeholder = MCLocalString(@"email");
    _tfPwd.placeholder = MCLocalString(@"password");
    [_btnValidate setTitle:MCLocalString(@"VALIDATE") forState:UIControlStateNormal];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_btnValidate setBackgroundColor:Color_Slider];
    [_btnValidate makeRounded:_btnValidate.bounds.size.height / 2.];
    
}
- (IBAction)onBack:(id)sender {
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onForgot:(id)sender {
    
    [_tfEmail resignFirstResponder];
    
    if(!isSet(_tfEmail.text)){
        
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Please input Email.") VC:self Ok:nil];
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [backendless.userService restorePassword:_tfEmail.text response:^(id res) {
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Check your email") VC:self Ok:^{
            
        }];
//        _resultText.text = @"Check your email";
//        _resultView.hidden = NO;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } error:^(Fault *error) {
//        _resultText.text = [NSString stringWithFormat:@"Error: %@", error.detail];
//        _resultView.hidden = NO;
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Failed to reset password.") VC:self Ok:^{
            
        }];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
}

- (IBAction)onValidate:(id)sender {
    
    if(!isSet(_tfEmail.text)){
        
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Enter the email.") VC:self Ok:nil];
        return;
    }
    if(!isSet(_tfPwd.text)){
        
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Enter the password.") VC:self Ok:nil];
        return;
    }
    
    [GD showSVHUD];
    [backendless.userService
     login:_tfEmail.text
     password:_tfPwd.text
     response:^(BackendlessUser *user) {
//         _logoutView.hidden = NO;
         
         [GD onMain:^{
             [GD hideSV];
             UIImageView * imgSuccess = [[UIImageView alloc] initWithFrame:self.view.frame];
             [imgSuccess setImage:[UIImage imageNamed:@"welcome.png"]];
             imgSuccess.contentMode = UIViewContentModeScaleAspectFill;
             
             [self.view addSubview:imgSuccess];
             imgSuccess.alpha = 0;
             imgSuccess.transform=CGAffineTransformMakeScale(1.5, 1.5);
             
             [UIView animateWithDuration:0.4 animations:^{
                 imgSuccess.transform=CGAffineTransformMakeScale(1, 1);
                 imgSuccess.alpha = 1;
                 
             } completion:^(BOOL finished) {
                 
             }];
             
             dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
             dispatch_after(delayTime, dispatch_get_main_queue(),^{
                 [GD onMain:^{
            
                     [backendless.userService setStayLoggedIn:YES];
                     //
                     //                         kAppDelegate.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_main"];
                     //
                     [GD WriteDefaultStore:_tfEmail.text forKey:@"useremail"];
                     [GD WriteDefaultStore:_tfPwd.text forKey:@"userpwd"];
                     
                     [backendless.userService setStayLoggedIn:YES];
                     
                     [kAppDelegate userDeviceTokenUpdate];
                     [GD hideSV];
                     
                     [UIView transitionWithView:kAppDelegate.window
                                       duration:0.5
                                        options:UIViewAnimationOptionTransitionCrossDissolve
                                     animations:^{kAppDelegate.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_main"]; }
                                     completion:nil];
//                     kAppDelegate.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_main"];
                     imgSuccess.hidden = YES;
                     //[CYAnimation fadeOut:imgSuccess andTime:0.3 andCompletion:^{
                     //
                     //}];
                     
                     
                 }];
                 
             });
             
             
         }];
      

         NSLog(@"%@", user);
     }
     error:^(Fault *fault) {
         NSLog(@"%@", fault.detail);
         [GD onMain:^{
             [GD hideSV];
             [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Failed to log in, Please try again.") VC:self Ok:nil];
         }];
     }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
