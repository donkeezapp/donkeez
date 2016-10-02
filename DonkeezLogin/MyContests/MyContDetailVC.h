//
//  MyContDetailVC.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"
#import "MarqueeLabel.h"
@interface MyContDetailVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;

@property (weak, nonatomic) IBOutlet UILabel *lblTagsCont;
@property (weak, nonatomic) IBOutlet MarqueeLabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblEye;
@property (weak, nonatomic) IBOutlet UILabel *lblLikes;

@property (weak, nonatomic) IBOutlet UIImageView *barBack;
@property (weak, nonatomic) IBOutlet UIView *barFront;

@property (weak, nonatomic) IBOutlet UIImageView *imgSlide;


@property (weak, nonatomic) IBOutlet UITableView *tblProd;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nlThumbLeft;

@property (weak, nonatomic) IBOutlet UILabel *lblTotalRank;
@property (weak, nonatomic) IBOutlet UILabel *lblMyRank;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nlSliderFrontWidth;


@property(nonatomic, strong)Contest * curContest;
@property(nonatomic,strong)Post * curPost;
@property (weak, nonatomic) IBOutlet UILabel *lblProgress;
@property (weak, nonatomic) IBOutlet UIImageView *seperateImgView;

@end
