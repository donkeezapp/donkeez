//
//  PostCell.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostCell;
@protocol PostCellDelegate <NSObject>

@optional
-(void)onTappedLike:(PostCell *)cell post:(Post*)post;
-(void)onTappedPlus:(PostCell *)cell post:(Post*)post;

@end

@interface PostCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lblLikes;
@property(weak, nonatomic)id<PostCellDelegate> delegate;
@property(nonatomic, strong)Post * post;

@property(nonatomic, strong)UIViewController * parentVC;

@property (weak, nonatomic) IBOutlet UIImageView *imgBack;


@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;

@property (weak, nonatomic) IBOutlet UIView *viewLik;
@property(nonatomic)NSInteger countOfLikes;
@property(nonatomic)BOOL isLikable;
@property(nonatomic, strong)NSString *  msgLikeInValid;

@property(nonatomic)CGFloat  angle;
-(void)setCellPost:(Post*)post;
-(void)initPlusButton;

@end
