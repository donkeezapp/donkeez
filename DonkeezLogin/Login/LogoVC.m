//
//  LogoVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "LogoVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginVC.h"
#import "Signup1VC.h"
@interface LogoVC ()

@end

@implementation LogoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)localize{
    
    [_btnLogin setTitle:MCLocalString(@"Login") forState:UIControlStateNormal];
    [_btnSignup setTitle:MCLocalString(@"Signup") forState:UIControlStateNormal];
    
    
    _lblWelcome.text = MCLocalString(@"Welcome");
    [_btnSignup setBorderForColor:Color_btn_white width:1. radius:15.];
    [_btnLogin setBorderForColor:Color_btn_white width:1. radius:15.];
    [_btnSignup setTitleColor:Color_btn_white forState:UIControlStateNormal];
    [_btnLogin setTitleColor:Color_btn_white forState:UIControlStateNormal];
    
    [_viewFBBtn setBackgroundColor:myRGBA(45, 68, 134, 255) BorderForColor:myRGBA(59, 89, 152, 255) width:0. radius:15.];

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.view layoutIfNeeded];
    [self.view layoutSubviews];

    self.navigationController.navigationBarHidden = YES;
    
    UIView * backImg = [self.view viewWithTag:100];
    [self.view sendSubviewToBack:backImg];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    [loginButton setFrame:CGRectMake(0, 0, _viewFBBtn.bounds.size.width, _viewFBBtn.bounds.size.height)];
    
    loginButton.readPermissions = @[@"email",@"public_profile",@"user_hometown", @"user_birthday",@"user_about_me"];
    [loginButton makeRounded:15.];
    
    
//    [loginButton setImage:[UIImage imageNamed:@"fb_btn.png"] forState:UIControlStateNormal];
    
    UIImageView * imgFB = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, loginButton.bounds.size.width, loginButton.bounds.size.height)];
    [imgFB setContentMode:UIViewContentModeScaleAspectFill];
    UIImage * img = [[UIImage imageNamed:@"fb_btn.png"] resizeImageToNewSize:CGSizeMake(loginButton.bounds.size.width, loginButton.bounds.size.height)];
    
    [imgFB setImage:img];

//    UIColor * color = [imgFB colorOfPoint:CGPointMake(10, 10)];
//    
//    [_viewFBBtn setBackgroundColor:myRGBA(59, 89, 152, 255)];
//    [loginButton setBackgroundColor:myRGBA(45, 68, 134, 255)];
//    [loginButton.layer addSublayer:imgFB.layer];
    UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake( 52, 15, loginButton.bounds.size.width - 50, loginButton.bounds.size.height-23)];
    lbl.text = MCLocalString(@"Connect with Facebook");
    UIFont * font = _btnLogin.titleLabel.font;
    font = [font fontWithSize:20.];
    
    
    [lbl setFont:font];
    [lbl setTextColor:[UIColor whiteColor]];
    
    [_viewFBBtn addSubview:loginButton];
    [_viewFBBtn addSubview:imgFB];
    [_viewFBBtn addSubview:lbl];
    
    
   
}

- (IBAction)onSignup:(id)sender {
    Signup1VC *sVC = (Signup1VC *)[self.storyboard instantiateViewControllerWithIdentifier:@"Signup1VC"];
    
    [CYAnimation PushAnimationRight2left:self nav:self.navigationController target:sVC];
    
}
- (IBAction)onLogin:(id)sender {
    
    LoginVC *loginVC = (LoginVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    
    [CYAnimation PushAnimationRight2left:self nav:self.navigationController target:loginVC];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    
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
