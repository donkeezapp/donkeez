//
//  UploadPostVC.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/13/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"
#import "MarqueeLabel.h"
@interface UploadPostVC : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblTag;
@property (weak, nonatomic) IBOutlet MarqueeLabel *lblDesc;

@property (weak, nonatomic) IBOutlet UIImageView *imgPost;

@property (weak, nonatomic) IBOutlet UIButton *btnPost;


@property(nonatomic, strong)UIImage * imgPosted;
@property(nonatomic, strong)Contest * curContest;


@end
