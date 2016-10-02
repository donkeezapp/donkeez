
//
//  WinVCCell.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "WinVCCell.h"

@implementation WinVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setContestForCell:(Contest*)contest  isSel:(BOOL)isSel{
    _angle = M_PI * 0.25;
    
    _curContest = contest;
    [_imgLogoContest setMHImageWithURL:[NSURL URLWithString:_curContest.mark_image]];
    _winPost = _curContest.post_win;
    [_imgPhoto setMHImageWithURL:[NSURL URLWithString:_winPost.photo]];
    _lblTags.text = _curContest.tags;
    
//    [self initPlusButton];
    if(isSel){
        [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle: M_PI * 0.25];
        _angle = 0;
    }else{
        [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle: 0];
        _angle = M_PI * 0.25;
    }
    
}
-(void)initPlusButton{
    
    [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle:0];
    _angle = M_PI * 0.25;
    
}

- (IBAction)onPlus:(id)sender {
    
    if([_delegate respondsToSelector:@selector(onTappedPlus:cell:image:)]){
        [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle:_angle];
        _angle = _angle > 0 ? 0:M_PI * 0.25;
//        __weak typeof(_angle) wa = _angle;
        [_delegate onTappedPlus:_curContest cell:self image:_imgPhoto.image];
            
        
    }
    
    
}


- (IBAction)onShare:(id)sender {
    
    if([_delegate respondsToSelector:@selector(onTappedShare:cell:image:)]){
        
        [_delegate onTappedShare:_curContest cell:self image:_imgPhoto.image];
        
    }
    
}


@end
