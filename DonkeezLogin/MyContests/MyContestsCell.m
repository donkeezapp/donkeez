
//
//  MyContestsCell.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "MyContestsCell.h"

@implementation MyContestsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setPostData:(Post*)post  isPosting:(BOOL)isPosting{
    _isPostingCell = isPosting;
    
    _curPost = post;
    [_imgPhoto setMHImageWithURL:[NSURL URLWithString:_curPost.photo]];
    
    _lbltitle.text = _curPost.contest.tags;
    
//    NSDate * postingDate = [_curPost.contest.end_date dateByAddingTimeInterval:-7*24*3600];
//    NSTimeInterval postingtime = [postingDate timeIntervalSinceNow];
//    NSTimeInterval votingtime = [_curPost.contest.end_date timeIntervalSinceNow];
    
    if(_isPostingCell){
        _lblTime.text = [GD getDuringofDate:_curPost.contest.end_date ];
        
        
    }else{
        NSLog(@"_curPost.contest.vote_end_date : %@", _curPost.contest.vote_end_date);
        if([[NSDate date] compare:_curPost.contest.vote_end_date ] == NSOrderedDescending){
            
            _lblTime.text = @"";
            _lblPostingCaption.text = MCLocalString(@"Ended");
            
        }else{
            _lblTime.text = [GD getDuringofDate:_curPost.contest.vote_end_date];
            
//            NSDate * endLimit = [[NSDate date] dateByAddingTimeInterval:7 * 24 * 3600];
//            if([endLimit compare:_curPost.contest.end_date] == NSOrderedDescending){
            NSString *string = [NSString stringWithFormat:@"%@ - ",MCLocalString(@"Voting Time")];
                _lblPostingCaption.text =  string ;
//            }else{
//            _lblPostingCaption.text = MCLocalString(@"Posting Time");
            
//            }
            
            
        }
        
        
        
        
    }
}
@end
