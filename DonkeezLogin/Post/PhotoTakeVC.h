//
//  PhotoTakeVC.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/13/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotoTakeVC : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnSwitch;
@property (weak, nonatomic) IBOutlet UIButton *btnFlash;

@property (weak, nonatomic) IBOutlet UIView *viewCap;
@property (weak, nonatomic) IBOutlet UIButton *btnPeli;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto;

@property(nonatomic, strong)Contest * curContest;
@end
