//
//  LoginVC.h
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginVC : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet UILabel *lblPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnValidate;

@property (weak, nonatomic) IBOutlet UIButton *btnForgot;


@end
