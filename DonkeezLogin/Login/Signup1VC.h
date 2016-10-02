//
//  Signup1VC.h
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"

@interface Signup1VC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;


@property (weak, nonatomic) IBOutlet UILabel *lblFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblsubTitle;


@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblPwd;
@property (weak, nonatomic) IBOutlet UILabel *lblRePwd;

@property (weak, nonatomic) IBOutlet UITextField *tfEmail
;
@property (weak, nonatomic) IBOutlet UITextField *tfPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfRePwd;



@property (weak, nonatomic) IBOutlet UILabel *lblBirthDay;
@property (weak, nonatomic) IBOutlet UILabel *lblSex;

@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;

@property (weak, nonatomic) IBOutlet UITextField *tfBD;
@property (weak, nonatomic) IBOutlet UITextField *tfSex;
@property (weak, nonatomic) IBOutlet BEMCheckBox *chkTerm;
@property (weak, nonatomic) IBOutlet UILabel *lblTerms;



@property (weak, nonatomic) IBOutlet UILabel *lblPage;


@property (weak, nonatomic) IBOutlet UIScrollView *scrView;


@property (weak, nonatomic) IBOutlet UIButton *btnValidate;

@end
