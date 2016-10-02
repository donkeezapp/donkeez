//
//  ContestCell.h
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContestCell;

@protocol ContestCellDelegate <NSObject>

@optional

-(BOOL)onTappedPlus:(ContestCell*)cell contest:(Contest*)contData;
-(void)onTappedSharing:(ContestCell*)cell contest:(Contest*)contData;

-(void)onTappedView:(ContestCell*)cell contest:(Contest*)contData;
@end


@interface ContestCell : UITableViewCell

{
    
    
}
@property(weak, nonatomic)id<ContestCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imgContestLogo;
@property (weak, nonatomic) IBOutlet UIImageView *imgBack;
@property (weak, nonatomic) IBOutlet UILabel *lblContTags;
@property (weak, nonatomic) IBOutlet UILabel *lblTimes;

@property (weak, nonatomic) IBOutlet UIButton *btnSharing;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@property(nonatomic, strong) Contest * contData;
@property(nonatomic)CGFloat angle;

-(void)initPlusButton;
-(void)setDataCell:(Contest*)cont  isSel:(BOOL)isSel;
@end
