//
//  ProfileView.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/15/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"
#import "MarqueeLabel.h"

@interface ProfileView : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;

@property (weak, nonatomic) IBOutlet MarqueeLabel *lblName;
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@property (weak, nonatomic) IBOutlet UIButton *btnLogout;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;


@property (weak, nonatomic) IBOutlet UILabel *lblConPa;
@property (weak, nonatomic) IBOutlet UIButton *btnFaq;
@property (weak, nonatomic) IBOutlet UIButton *btnCGU;

@end
