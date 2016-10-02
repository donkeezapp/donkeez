//
//  AddPhotoVC.h
//  Donkeez
//
//  Created by Zhang RenJun on 6/24/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"
#import "MarqueeLabel.h"
@interface AddPhotoVC : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgLogoContest;

@property (weak, nonatomic) IBOutlet UILabel *lblContestTags;
@property (weak, nonatomic) IBOutlet UIImageView *imgCurPost;
@property (weak, nonatomic) IBOutlet UIButton *btnNewPic;

@property (weak, nonatomic) IBOutlet UILabel *lblTimes;

@property (weak, nonatomic) IBOutlet UITextView *tvDescContest;
@property (weak, nonatomic) IBOutlet UITableView *tblProducts;

@property(nonatomic, strong)Contest * curContest;

@property(nonatomic, strong)Post * curPost;

@property (weak, nonatomic) IBOutlet MarqueeLabel *lblGreyDescription;
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;


@property (weak, nonatomic) IBOutlet UIButton *btnDlePost;
@property (weak, nonatomic) IBOutlet UIButton *btnChangePic;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@end
