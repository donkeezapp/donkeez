//
//  WinCell.h
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"

@class WinCell;

@protocol WinCellDelegate <NSObject>

@required
-(void)onTapWin:(NSInteger)winNumber contest:(Contest*)contest;

@end


@interface WinCell : UITableViewCell

@property(weak, nonatomic)id<WinCellDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;


@property (weak, nonatomic) IBOutlet UIImageView *imgWinnerPost;
@property (weak, nonatomic) IBOutlet UIImageView *imgContMark;
@property (weak, nonatomic) IBOutlet UILabel *postUserName;
@property (weak, nonatomic) IBOutlet MarqueeLabel *lblContTags;


@property (weak, nonatomic) IBOutlet UIImageView *imgWinnerPost1;
@property (weak, nonatomic) IBOutlet UIImageView *imgContMark1;
@property (weak, nonatomic) IBOutlet UILabel *postUserName1;
@property (weak, nonatomic) IBOutlet MarqueeLabel *lblContTags1;


@property (weak, nonatomic) IBOutlet UIImageView *imgWinnerPost2;
@property (weak, nonatomic) IBOutlet UIImageView *imgContMark2;
@property (weak, nonatomic) IBOutlet UILabel *postUserName2;
@property (weak, nonatomic) IBOutlet MarqueeLabel *lblContTags2;



@property (weak, nonatomic) IBOutlet UIPageControl *pgControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property(nonatomic, strong)Contest * cont;
@property(nonatomic, strong)Contest * cont1;
@property(nonatomic, strong)Contest * cont2;
@property(nonatomic, strong)Post * post;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nlcWidthMultiplier;

-(void)setContData:(Contest*)cont cont1:(Contest*)cont1 cont2:(Contest*)cont2;

@end
