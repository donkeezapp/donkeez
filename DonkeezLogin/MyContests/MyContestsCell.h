//
//  MyContestsCell.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MarqueeLabel.h"

@interface MyContestsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;

@property (weak, nonatomic) IBOutlet MarqueeLabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property(nonatomic)BOOL isPostingCell;

@property(nonatomic, strong)Post * curPost;

@property (weak, nonatomic) IBOutlet UILabel *lblPostingCaption;


-(void)setPostData:(Post*)post  isPosting:(BOOL)isPosting;
@end
