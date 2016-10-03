//
//  PostCell.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "PostCell.h"
#import "UIImageView+AFNetworking.h"


@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCellPost:(Post*)post{
    _angle = M_PI * 0.25;
    _isLikable =  NO;
    _post = post;
    [_imgBack setMHImageWithURL:[NSURL URLWithString:_post.photo]];
    _lblLikes.hidden = YES;
    [_lblLikes setTextColor:Color_Slider];
    
    [_btnLike setUserInteractionEnabled:NO];
   [_post LikesOfUser:backendless.userService.currentUser success:^(NSInteger count, NSString * msg, Post *post) {
       if (post != self.post) {
           return;
       }
       
    if(count > 0){
        [GD onMain:^{
            _countOfLikes = count;
            _lblLikes.text = [NSString stringWithFormat:@"%ld", (long)count];
            
            if(isSet(msg)){
                _isLikable = NO;
                _msgLikeInValid = msg;
                [_btnLike setImage:[UIImage imageNamed:@"like_fill.png"] forState:UIControlStateNormal];
            }else{
                _isLikable = YES;
            }
        }];
        
    }else{
        _isLikable = YES;
    }
       [GD onMain:^{
          [_btnLike setUserInteractionEnabled:YES];
       }];
    } failed:^(NSString *error, NSInteger errorCode) {
        NSLog(@"%@", error);
    }];
    
    [self initPlusButton];
    
}


-(void)onTimerHide{
    
    
    [CYAnimation fadeOut:_viewLik andTime:0.2];
    
    
    
}
-(void)hideViewLike{
    if (_viewLik.hidden == NO) {
        [GD onMain:^{
         [CYAnimation fadeOut:_viewLik andTime:0.2];
        }];
    }
}
- (IBAction)onLike:(id)sender {
    
//    [GD showSVHUDMask:YES];
    if (!_isLikable) {
        
        if(isSet(_msgLikeInValid)){
            [GD ShowAlertViewTitle:@"" message:_msgLikeInValid VC:_parentVC Ok:nil];
        }else{
            [GD ShowAlertViewTitle:@"" message:MCLocalString(@"You can not like this post now.") VC:_parentVC Ok:nil];
        }
        
        return;
    }
    [GD onMain:^{
        _viewLik.hidden = NO;
        
        [CYAnimation fadeIn:_viewLik andTime:0.2 completion:^(BOOL finished) {
   
                [NSTimer  scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(hideViewLike) userInfo:nil repeats:NO];

         
        }];
    }];
    
    
    
    [_btnLike setImage:[UIImage imageNamed:@"like_fill.png"] forState:UIControlStateNormal];
    //            [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(onTimerHide) userInfo:nil repeats:NO];
    _countOfLikes ++;
    _lblLikes.text = [NSString stringWithFormat:@"%ld", (long)_countOfLikes];
//    _lblLikes.hidden = NO;
    
    if([_delegate respondsToSelector:@selector(onTappedLike:post:)]){
        
        [_delegate onTappedLike:self post:_post];
        
    }
    
    
 
}

-(void)initPlusButton{
    [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle:0];
    _angle = M_PI * 0.25;
    
}
- (IBAction)onPlus:(id)sender {
    
    if([_delegate respondsToSelector:@selector(onTappedPlus:post:)]){
        
        [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle:_angle];
        _angle = _angle > 0 ? 0:M_PI * 0.25;
        [_delegate onTappedPlus:self post:_post];
       
        
        
    }
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _imgBack.image = nil;
    [_imgBack cancelImageDownloadTask];
    _viewLik.hidden = YES;
    
    [_btnLike setImage:[UIImage imageNamed:@"like_white.png"] forState:UIControlStateNormal];
}


@end
