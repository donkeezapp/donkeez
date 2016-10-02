//
//  Signup1VC.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "Signup1VC.h"
#import "Backendless.h"

#import "RegisterViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ActionSheetDatePicker.h"
#import  "ActionSheetStringPicker.h"

@interface Signup1VC ()

{
    NSArray *_data;
    NSInteger curPage;
    NSArray * subTitleArr;
    NSArray * imgNamdArr;
     NSDate * curSelDate;
    NSDateFormatter * df;
     BackendlessUser *_user;
    
    NSInteger curSelGenderIdx;
}
@end

@implementation Signup1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    df = [NSDateFormatter new];
 
    curSelGenderIdx = 0;
//    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    [df setDateFormat:@"dd/MM/yyyy"];
   

    
    _user = [BackendlessUser new];
    _data = @[@{@"type":@"DATETIME", @"name":@"birthday"}, @{@"type":@"STRING", @"name":@"email"}, @{@"type":@"STRING", @"name":@"firstname"}, @{@"type":@"STRING", @"name":@"gender"}, @{@"type":@"STRING", @"name":@"lastname"}, @{@"type":@"STRING", @"name":@"name"}, @{@"type":@"STRING", @"name":@"password"}];
    
    curPage = 0;
    subTitleArr = @[@"Come get some!", @"Protect yourself!", @"Last step :D"];
    
    imgNamdArr = @[@"lblsignupstep1.png", @"lblsignupstep2.png", @"lblsignupstep3.png"];
    _tfBD.userInteractionEnabled = NO;
   
    curSelDate = [NSDate date];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view layoutIfNeeded];
    [self.view layoutSubviews];
    
    [GD SetDropButton:_btnNext imgName:@"right.png"];
//    [GD SetDropButton:_btnBack imgName:@"right.png"];
//    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 25, 25)];
//    imgView.image = [[UIImage imageNamed:@"left_back.png"] resizedImageToSize:CGSizeMake(21, 21)];
//    [_btnBack addSubview:imgView];
//    [_btnBack setTitle:@"" forState:UIControlStateNormal];
    
    
     [_btnValidate setTitle:MCLocalString(@"VALIDATE") forState:UIControlStateNormal];
    [_btnValidate setBackgroundColor:Color_Slider];
    [_btnValidate makeRounded:_btnValidate.bounds.size.height / 2.];
    
    
    UIButton * btnBD = [[UIButton alloc] initWithFrame:_tfBD.frame];
    [btnBD setTitle:@"" forState:UIControlStateNormal];
    [btnBD addTarget:self action:@selector(onBirthDay) forControlEvents:UIControlEventTouchUpInside];
    [GD SetDropButton:btnBD imgName:@"downArrow.png"];
    
    [_tfBD.superview addSubview:btnBD];
    
    UIButton * btnSex = [[UIButton alloc] initWithFrame:_tfSex.frame];
    [btnSex setTitle:@"" forState:UIControlStateNormal];
    [btnSex addTarget:self action:@selector(onSex) forControlEvents:UIControlEventTouchUpInside];
    [GD SetDropButton:btnSex imgName:@"downArrow.png"];
    [_tfBD.superview addSubview:btnSex];
    
    _tfSex.text = MCLocalString(kAppDelegate.genderList[curSelGenderIdx]);
    
}

-(void)localize{
    
    _lblTitle.text = MCLocalString(@"Sign up");
    _lblFirstName.text = MCLocalString(@"FIRST NAME");
    _lblLastName.text = MCLocalString(@"LAST NAME");
    
    _tfFirstName.placeholder = MCLocalString(@"first name");
    _tfEmail.placeholder =MCLocalString(@"email");
    _tfPwd.placeholder =MCLocalString(@"password");
    _tfRePwd.placeholder =MCLocalString(@"confirm password");
    [_btnNext setTitle:MCLocalString(@"Next") forState:UIControlStateNormal];
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
    
    _lblEmail.text = MCLocalString(@"EMAIL");
    _lblPwd.text = MCLocalString(@"PASSWORD");
    _lblRePwd.text = MCLocalString(@"CONFIRM PASSWORD");
    
    _lblBirthDay.text = MCLocalString(@"BIRTHDAY");
    _lblSex.text = MCLocalString(@"SEX");
    
    _lblsubTitle.text = MCLocalString(@"Welcome");
    [_btnValidate setTitle:MCLocalString(@"VALIDATE") forState:UIControlStateNormal];
    
    _lblTerms.text = MCLocalString(@"I AGREE TERMS");
    
        
}
-(void)onBirthDay{
    
    [ActionSheetDatePicker showPickerWithTitle:MCLocalString(@"Select Date") datePickerMode:UIDatePickerModeDate selectedDate:curSelDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        curSelDate = selectedDate;
        
        [GD onMain:^{
            _tfBD.text = [df stringFromDate:curSelDate];
        }];
        
        
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:_tfBD];

    
}
-(void)onSex{
    
    [ActionSheetStringPicker showPickerWithTitle:MCLocalString(@"Select Gender") rows:kAppDelegate.genderList initialSelection:curSelGenderIdx doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        curSelGenderIdx = selectedIndex;
        [GD onMain:^{
            _tfSex.text = kAppDelegate.genderList[curSelGenderIdx];
        }];
        
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:_tfSex];
    
    
}
-(BOOL)isValidate{
    
    if(![GD StringIsValidEmail:_tfEmail.text]){
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Enter the email correctly.") VC:self Ok:nil];
        return NO;
    }
    if(!isSet(_tfEmail.text)){
        
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Enter the email.") VC:self Ok:nil];
        return NO;
    }
    if(!isSet(_tfPwd.text)){
        
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Enter the password.") VC:self Ok:nil];
        return NO;
    }
    if(![_tfPwd.text isEqualToString:_tfRePwd.text]){
        
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Enter the correct password.") VC:self Ok:nil];
        return NO;
    }
    if(!_chkTerm.on){
        [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Please read the terams and check.") VC:self Ok:nil];
        return NO;
    }
    return  YES;
}

- (IBAction)onValidate:(id)sender {
    
    
    if(![self isValidate]){
        return;
    }
    
    NSString * fname =  isSet(_tfFirstName.text)? _tfFirstName.text:@"";
    NSString * lname =  isSet(_tfLastName.text)? _tfLastName.text:@"";
    _user.name = [NSString stringWithFormat:@"%@  %@", fname, lname ];
    [_user setProperty:@"firstname" object:fname];
    _user.email= _tfEmail.text;
    _user.password = _tfPwd.text;
    
    [_user setProperty:@"firstname" object:isSet(fname)?fname:@""];

    
    if(![curSelDate isEqual:[NSDate date]]){
        
        
    }

    
    [GD showSVHUD];
    [backendless.userService registering:_user response:^(BackendlessUser *user) {
        
        
        UserInfo * ui = [[UserInfo alloc] init];
        ui.first_name = [user getProperty:@"firstname"];
        ui.last_name = [user getProperty:@"lastname"];
        ui.gender =  [user getProperty:@"gender"];
        ui.avatar =  [user getProperty:@"avatar"];
        ui.user_id = user.userId;
        ui.device_id = [user getProperty:@"deviceid"];
        ui.birthday = [user getProperty:@"birthday"];
        
        id<IDataStore> ds = [backendless.persistenceService of:[UserInfo class]];
        
        [ds save:ui];
        
        [backendless.userService
         login:user.email
         password:user.password
         response:^(BackendlessUser *user) {
         
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
                         [UIView transitionWithView:kAppDelegate.window
                                           duration:0.5
                                            options:UIViewAnimationOptionTransitionCrossDissolve
                                         animations:^{kAppDelegate.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_main"]; }
                                         completion:nil];
                         
                     }];
                     
                 });
                 
                 
             }];
         }         error:^(Fault *fault) {

             
             [GD onMain:^{
                 [GD hideSV];
                 
                 [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Unable to register user, please try again.")   VC:self Ok:nil];
             }];
         }];

        
        
    } error:^(Fault *error) {
        [GD onMain:^{
            [GD hideSV];
  
            [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Unable to register user, User already exists.")   VC:self Ok:nil];
        }];
        
    }];
    

    
    
}



- (IBAction)onNext:(id)sender {
    
    curPage ++;
    if(curPage == 3){
        curPage = 2;
        // signup
        
        if(![self isValidate]){
            return;
        }
        
        NSString * fname =  isSet(_tfFirstName.text)? _tfFirstName.text:@"";
        NSString * lname =  isSet(_tfLastName.text)? _tfLastName.text:@"";
        _user.name = [NSString stringWithFormat:@"%@  %@", fname, lname ];
        _user.email= _tfEmail.text;
        _user.password = _tfPwd.text;
        
        [_user setProperty:@"firstname" object:isSet(fname)?fname:@""];
        [_user setProperty:@"lastname" object:isSet(lname)?lname:@""];
        [_user setProperty:@"avatar" object:@""];
        if(![curSelDate isEqual:[NSDate date]]){
            
            [_user setProperty:@"birthday" object:curSelDate];
        }
        [_user setProperty:@"gender" object:kAppDelegate.genderList[curSelGenderIdx]];
        
        [GD showSVHUD];
        [backendless.userService registering:_user response:^(BackendlessUser *user) {

            
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
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC);
                dispatch_after(delayTime, dispatch_get_main_queue(),^{
                    [GD onMain:^{
                        [CYAnimation fadeOut:imgSuccess andTime:0.3];
                        [self dismissViewControllerAnimated:YES completion:nil];
                        
                    }];

                });
                
                
            }];
        } error:^(Fault *error) {
            [GD onMain:^{
                [GD hideSV];
                [[[UIAlertView alloc] initWithTitle:@"Error" message:error.detail delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil] show];
            }];
            
        }];

        
    }
    if(curPage >= 2){
        curPage = 2;
        
        
    }else{
        _btnNext.hidden = NO;
        
    }
    _btnBack.hidden =NO;
    [_scrView scrollRectToVisible:CGRectMake(curPage*self.view.frame.size.width, 0, _scrView.frame.size.width, _scrView.frame.size.height) animated:YES];
    
    NSInteger num = curPage +1;
    _lblPage.text = [NSString stringWithFormat:@"%ld/3", (long)num];
    _lblsubTitle.text = MCLocalString(subTitleArr[curPage]);
    
    _imgBanner.image = [UIImage imageNamed:imgNamdArr[curPage]];
}
- (IBAction)onBack:(id)sender {
    curPage --;
    
    if(curPage < 0){
        
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if(curPage <= 0){
        curPage = 0;
//        _btnBack.hidden = YES;
    }else{
//        _btnBack.hidden = NO;
    }
    _btnNext.hidden =NO;
    [_scrView scrollRectToVisible:CGRectMake(curPage*self.view.frame.size.width, 0, _scrView.frame.size.width, _scrView.frame.size.height) animated:YES];
    _lblsubTitle.text = MCLocalString(subTitleArr[curPage]);
    _imgBanner.image = [UIImage imageNamed:imgNamdArr[curPage]];
    
    NSInteger num = curPage +1;
    _lblPage.text = [NSString stringWithFormat:@"%ld/3", (long)num];
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
