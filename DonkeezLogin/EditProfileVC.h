//
//  EditProfileVC.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/15/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"

@interface EditProfileVC : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;


@property (weak, nonatomic) IBOutlet UILabel *lblAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblProfilePic;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblFname;
@property (weak, nonatomic) IBOutlet UILabel *lblLname;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblPwd;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthDate;
@property (weak, nonatomic) IBOutlet UILabel *lblSex;


@property (weak, nonatomic) IBOutlet UIButton *btnFirstName;

@property (weak, nonatomic) IBOutlet UIButton *btnLastName;
@property (weak, nonatomic) IBOutlet UIButton *btnEmaill;

@property (weak, nonatomic) IBOutlet UIButton *btnPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnBirthDate;
@property (weak, nonatomic) IBOutlet UIButton *btnSex;

@end
