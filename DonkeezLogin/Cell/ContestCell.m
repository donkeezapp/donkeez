//
//  ContestCell.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "ContestCell.h"

@implementation ContestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataCell:(Contest*)cont isSel:(BOOL)isSel{
    
    _contData = cont;
    _angle = M_PI * 0.25;
    [_imgContestLogo setMHImageWithURL:[NSURL URLWithString:_contData.mark_image]];
    _imgContestLogo.hidden = YES;
    _lblContTags.text = _contData.tags;
    
    NSDate * today = [NSDate date];
    if([today compare:_contData.vote_begin_date]== NSOrderedDescending && [today compare:_contData.vote_end_date]== NSOrderedAscending){
        _lblTimes.text = [GD getDuringofDate:_contData.vote_end_date];
        
    }else  if([today compare:_contData.begin_date]== NSOrderedDescending && [today compare:_contData.end_date]== NSOrderedAscending){
        _lblTimes.text = [GD getDuringofDate:_contData.end_date];
    }
    

        NSLog(@"URL : %@", _contData.mark_image);

        if(isSet(_contData.mark_post)){
            UIActivityIndicatorView * actLoader = [GD activityViewToView:_imgBack];
            
            [_imgBack setMHImageWithURL:[NSURL URLWithString:_contData.mark_post] completion:^(NSError *error, NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [GD onMain:^{
                    [actLoader stopAnimating];
                }];
                
            }];
        }
    
    [self initPlusButton];

    if(isSel){
        [CYAnimation RotateClockWise:_btnAdd andTime:0.3 angle:M_PI * 0.25];
        _angle = 0;
    }else{
        [CYAnimation RotateClockWise:_btnAdd andTime:0.3 angle: 0];
        _angle = M_PI * 0.25;
    }
}


- (IBAction)onSharing:(id)sender {
    
    if([_delegate respondsToSelector:@selector(onTappedSharing:contest:)]){
        
        
        [_delegate onTappedSharing:self contest:_contData];
        
    }
}
-(void)initPlusButton{
    [CYAnimation RotateClockWise:_btnAdd andTime:0.3 angle:0];
    _angle = M_PI * 0.25;
    
}
- (IBAction)onPlusBtn:(id)sender {
    
    if([_delegate respondsToSelector:@selector(onTappedPlus:contest:)]){
        
        [CYAnimation RotateClockWise:_btnAdd andTime:0.3 angle:_angle];
        _angle = _angle > 0 ? 0:M_PI * 0.25;
        __weak typeof(_angle) wa = _angle;
        if(![_delegate onTappedPlus:self contest:_contData]){
            
            [CYAnimation RotateClockWise:_btnAdd andTime:0.3 angle:0];
            wa = wa > 0 ? 0:M_PI * 0.25;
        }
        
    }
    
}

- (IBAction)onTappedView:(id)sender {
    if([_delegate respondsToSelector:@selector(onTappedView:contest:)]){
        
        [_delegate onTappedView:self contest:_contData];
        
    }
    
}


@end
