//
//  EditProfileVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/15/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "EditProfileVC.h"
#import "ActionSheetDatePicker.h"
#import  "ActionSheetStringPicker.h"
@interface EditProfileVC ()
{
    
    NSDate * curSelDate;
    NSInteger curSelGenderIdx;
    UserInfo * ui;
}
@end

@implementation EditProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    curSelGenderIdx = 0;
    curSelDate = [NSDate date];
    
    ui = [kAppDelegate GetUserInfo:backendless.userService.currentUser];
    
    
    NSString * fname = isSet([backendless.userService.currentUser getProperty:@"firstname"])?[backendless.userService.currentUser getProperty:@"firstname"]:@"first name";
    NSString * lname = isSet([backendless.userService.currentUser getProperty:@"lastname"])?[backendless.userService.currentUser getProperty:@"lastname"]:@"last name";
    
    fname = ui.first_name;
    lname = ui.last_name;
    
    [_btnFirstName setTitle:fname forState:UIControlStateNormal];
    [_btnLastName setTitle:lname forState:UIControlStateNormal];
    NSString * pwd = isSet([backendless.userService.currentUser getPassword])?[backendless.userService.currentUser getPassword]:@"";
    [_btnPwd setTitle:pwd forState:UIControlStateNormal];
    
    [_btnEmaill setTitle:backendless.userService.currentUser.email forState:UIControlStateNormal];
    
    
    NSDate * birth = [backendless.userService.currentUser getProperty:@"birthday"];
    birth = ui.birthday;
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM/dd/yyyy"];
    if(birth){
        [_btnBirthDate setTitle:[df stringFromDate:birth]  forState:UIControlStateNormal];
    }else{
        
    }
    
    NSString * gender = isSet([backendless.userService.currentUser getProperty:@"gender"])?[backendless.userService.currentUser getProperty:@"gender"]:@"";
    
    gender = ui.gender;
    [_btnSex setTitle:gender forState:UIControlStateNormal];
    

    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NSString * avatar = [backendless.userService.currentUser getProperty:@"avatar"];
    if(isSet(avatar)){
        [_imgAvatar setMHImageWithURL:[NSURL URLWithString:avatar]];
    }else{
        [_imgAvatar setImage:[UIImage imageNamed:@"dummy-avatar.png"]];
        
        
    }

//    
//    [_imgAvatar setMHImageWithURL:[NSURL URLWithString:avatar]];
    [_imgAvatar setBorderForColor:[UIColor whiteColor] width:2. radius:_imgAvatar.bounds.size.height / 2.];
    
    
    kAppDelegate.mVC.navigationController.navigationBarHidden = YES;
    
    
    
    
    
    
}

-(void)localize{
    
    _lblTitle.text = MCLocalString(@"Edit Profile");
    
    _lblProfilePic.text = MCLocalString(@"Profile Pic");
    _lblFname.text = MCLocalString(@"First Name");
    _lblLname.text = MCLocalString(@"Last Name");
    _lblEmail.text = MCLocalString(@"Email");
    _lblPwd.text = MCLocalString(@"Change my Password");
    _lblBirthDate.text = MCLocalString(@"Birthdate");
    _lblSex.text = MCLocalString(@"Sex");
    
    _lblAccount.text = MCLocalString(@"My Account");
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
    
    
    
}

- (IBAction)onFirstName:(id)sender {
    
    [GD ShowAlertTextTitle:@"" message:MCLocalString(@"Input the first name.") placeholder:MCLocalString(@"First name") VC:self Ok:^(NSString * _Nonnull text) {
        
        [_btnFirstName setTitle:text forState:UIControlStateNormal];
        
        
        [backendless.userService.currentUser setProperty:@"firstname" object:text];
        
        [GD showSVHUDMask:YES];
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           @try {
               
               [backendless.userService.currentUser updateProperties:@{@"firstname" : text}];
               BackendlessUser *updatedUser = [backendless.userService update:backendless.userService.currentUser];
               
               [kAppDelegate UpdateUserInfo:updatedUser];
               
               [GD onMain:^{
                   [GD hideSV];
               }];
               NSLog(@"User has been updated (SYNC): %@", updatedUser);
           }
           @catch (Fault *fault) {
               NSLog(@"FAULT: %@", fault);
               [GD onMain:^{
                   [GD hideSV];
               }];
           }

       });
        
        
    }  cancelBlock:^{
        
        
        
    }];
    
}

- (IBAction)onLastName:(id)sender {
    [GD ShowAlertTextTitle:@"" message:MCLocalString(@"Input the last name.") placeholder:MCLocalString(@"Last name") VC:self Ok:^(NSString * _Nonnull text) {
        
        [_btnLastName setTitle:text forState:UIControlStateNormal];
        
        [backendless.userService.currentUser setProperty:@"lastname" object:text];
        
        [GD showSVHUDMask:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @try {
                
                [backendless.userService.currentUser updateProperties:@{@"lastname" : text}];
                BackendlessUser *updatedUser = [backendless.userService update:backendless.userService.currentUser];
                [kAppDelegate UpdateUserInfo:updatedUser];
                [GD onMain:^{
                    [GD hideSV];
                }];
                NSLog(@"User has been updated (SYNC): %@", updatedUser);
            }
            @catch (Fault *fault) {
                NSLog(@"FAULT: %@", fault);
                [GD onMain:^{
                    [GD hideSV];
                }];
            }
            
        });

        
    } cancelBlock:^{
        
        
        
    }];
    
    
}
- (IBAction)onEmail:(id)sender {
    
    
    
    [GD ShowAlertTextTitle:@"" message:MCLocalString(@"Input the email.") placeholder:MCLocalString(@"Email") VC:self Ok:^(NSString * _Nonnull text) {
        
        
        if(![GD StringIsValidEmail:text]){
            [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Enter the email correctly.") VC:self Ok:nil];
            
        }else{
            [_btnEmaill setTitle:text forState:UIControlStateNormal];
            
            [backendless.userService.currentUser setProperty:@"email" object:text];
            [GD showSVHUDMask:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                @try {
                    
                    [backendless.userService.currentUser updateProperties:@{@"email" : text}];
                    BackendlessUser *updatedUser = [backendless.userService update:backendless.userService.currentUser];
                    [kAppDelegate UpdateUserInfo:updatedUser];
                    [GD onMain:^{
                        [GD hideSV];
                    }];
                    NSLog(@"User has been updated (SYNC): %@", updatedUser);
                }
                @catch (Fault *fault) {
                    NSLog(@"FAULT: %@", fault);
                    [GD onMain:^{
                        [GD hideSV];
                    }];
                }
                
            });
        }
        
       

        
    } cancelBlock:^{
        
        
        
    }];
}
- (IBAction)onPwd:(id)sender {
    [GD ShowAlertTextTitle:@"" message:MCLocalString(@"Input the password.") placeholder:MCLocalString(@"Password") VC:self Ok:^(NSString * _Nonnull text) {
        
        [_btnPwd setTitle:text forState:UIControlStateNormal];
        
        [backendless.userService.currentUser setProperty:@"password" object:text];
        [GD showSVHUDMask:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @try {
                
                [backendless.userService.currentUser updateProperties:@{@"password" : text}];
                BackendlessUser *updatedUser = [backendless.userService update:backendless.userService.currentUser];
                
                [GD onMain:^{
                    [GD hideSV];
                }];
                NSLog(@"User has been updated (SYNC): %@", updatedUser);
            }
            @catch (Fault *fault) {
                NSLog(@"FAULT: %@", fault);
                [GD onMain:^{
                    [GD hideSV];
                }];
            }
            
        });

        
    } cancelBlock:^{
        
    }];
    
}

- (IBAction)onBirthdate:(id)sender {
    
    NSDateFormatter * df = [NSDateFormatter new];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    [ActionSheetDatePicker showPickerWithTitle:MCLocalString(@"Select Date") datePickerMode:UIDatePickerModeDate selectedDate:curSelDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        curSelDate = selectedDate;
        
        [GD onMain:^{
            [_btnBirthDate setTitle:[df stringFromDate:curSelDate] forState:UIControlStateNormal] ;
        }];
        
        [backendless.userService.currentUser setProperty:@"birthday" object:curSelDate];
        [GD showSVHUDMask:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @try {
                
                [backendless.userService.currentUser updateProperties:@{@"birthday" : curSelDate}];
                BackendlessUser *updatedUser = [backendless.userService update:backendless.userService.currentUser];
                [kAppDelegate UpdateUserInfo:updatedUser];
                [GD onMain:^{
                    [GD hideSV];
                }];
                NSLog(@"User has been updated (SYNC): %@", updatedUser);
            }
            @catch (Fault *fault) {
                NSLog(@"FAULT: %@", fault);
                [GD onMain:^{
                    [GD hideSV];
                }];
            }
            
        });
        
        
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:sender];

    
    
}

- (IBAction)onSex:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:MCLocalString(@"Select Gender") rows:kAppDelegate.genderList initialSelection:curSelGenderIdx doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        curSelGenderIdx = selectedIndex;
        [GD onMain:^{
            
            [_btnSex setTitle:kAppDelegate.genderList[curSelGenderIdx] forState:UIControlStateNormal] ;
            
        }];
        
        
        [backendless.userService.currentUser setProperty:@"gender" object:kAppDelegate.genderList[curSelGenderIdx]];
        [GD showSVHUDMask:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @try {
                
                [backendless.userService.currentUser updateProperties:@{@"gender" : kAppDelegate.genderList[curSelGenderIdx]}];
                BackendlessUser *updatedUser = [backendless.userService update:backendless.userService.currentUser];
                [kAppDelegate UpdateUserInfo:updatedUser];
                [GD onMain:^{
                    [GD hideSV];
                }];
                NSLog(@"User has been updated (SYNC): %@", updatedUser);
            }
            @catch (Fault *fault) {
                NSLog(@"FAULT: %@", fault);
                [GD onMain:^{
                    [GD hideSV];
                }];
            }
            
        });

        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:sender];
}

- (IBAction)onBack:(id)sender {
    
    
    [CYAnimation PopAnimationLeft2Right:self nav:self.navigationController target:nil];
    
    
}

- (IBAction)onAvatar:(id)sender {
    
    [self ShowActionSheetForImagePickCompletion:^(UIImage *img) {
       
        [GD onMain:^{
            NSString * filePath = [NSString stringWithFormat:@"avatar/%0.0f.jpeg", [[NSDate date] timeIntervalSince1970] ];
            
            NSData * data = UIImageJPEGRepresentation(img, 1.0);
            
            [GD showSVHUDMask:YES];
            
            [backendless.fileService upload:filePath content:data overwrite:YES response:^(BackendlessFile * file) {
                
                [backendless.userService.currentUser setProperty:@"avatar" object:file.fileURL];
                id<IDataStore> dataStore = [backendless.persistenceService of:[BackendlessUser class]];
             
                
                [dataStore save:backendless.userService.currentUser];
                
                [kAppDelegate UpdateUserInfo:backendless.userService.currentUser];
                [GD onMain:^{
                    [_imgAvatar setImage:img];
                    [GD hideSV];
                }];
            } error:^(Fault * fault) {
                [GD onMain:^{
                    [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Failed to upload the avatar, try again after a moment.") VC:self Ok:nil];
                    [GD hideSV];
                }];
                
                
            }];
            
            
        }];
        
        
    } cancel:^{
        
    }];
    
}


@end
