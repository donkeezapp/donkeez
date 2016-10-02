//
//  VoteCell.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"
@interface VoteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgBack;

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet MarqueeLabel *lblTitleContest;

@property (weak, nonatomic) IBOutlet MarqueeLabel *tvDesc;

-(void)setVoteDetailImage:(NSString *)imagePath;
@end
