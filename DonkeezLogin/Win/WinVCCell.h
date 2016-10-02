//
//  WinVCCell.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WinVCCell;

@protocol WinVCCellDelegate <NSObject>
@optional
-(void)onTappedShare:(Contest*)contest cell:(WinVCCell*)cell image:(UIImage *)winImage;

-(BOOL)onTappedPlus:(Contest*)contest cell:(WinVCCell*)cell image:(UIImage *)winImage;


@end

@interface WinVCCell : UITableViewCell


@property(weak, nonatomic)id<WinVCCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblTags;

@property (weak, nonatomic) IBOutlet UIImageView *imgLogoContest;

@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;

@property(nonatomic, strong)Post * winPost;
@property(nonatomic, strong)Contest * curContest;
@property(nonatomic)CGFloat angle;

-(void)initPlusButton;
-(void)setContestForCell:(Contest*)contest  isSel:(BOOL)isSel;
@end
