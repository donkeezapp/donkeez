

#import "ProfileTimeCell.h"

@implementation ProfileTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(NSDictionary * )GetRankOfPost:(NSArray <Post*>* )postList{
    
    NSMutableArray * sortedPostList =[[ postList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        Post* post1 = (Post*)obj1;
        Post* post2 = (Post*)obj2;
        
        return post1.likes > post2.likes ? NSOrderedAscending: NSOrderedDescending;
        
        
    }] mutableCopy];
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Post * _Nullable each, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [each.is_valid boolValue];
    }];
    
    [sortedPostList filterUsingPredicate:predicate];
    
    
    NSMutableDictionary * rankDict = [NSMutableDictionary new];
    
    NSInteger i = sortedPostList.count;
    Post * oldPost = nil;
    for (Post * eachPost in sortedPostList) {
        
        
        if(oldPost && oldPost.likes.integerValue == eachPost.likes.integerValue){
            
            NSInteger oldRank = [[rankDict objectForKey:oldPost.objectId] integerValue];
            [rankDict setObject:@(oldRank) forKey:eachPost.objectId];
        }else{
            [rankDict setObject:@(i) forKey:eachPost.objectId];
        }
        
        
        oldPost = eachPost;
        
        i--;
    }
    [rankDict setObject:@(sortedPostList.count) forKey:@"total"];
    NSLog(@"Rank : %@", rankDict);
    
    
    return  rankDict;
    
}

-(void)setCurPostData:(Post*)post isVote:(BOOL)isVote{
    
    _curPost = post;
    
    
    // FIXME - hotfix
    
    BOOL isThere = NO;
    
    for (Post *post in self.curContest.contest_posts) {
        if ([post.objectId isEqualToString:self.curPost.objectId]) {
            isThere = YES;
            break;
        }
    }
    
    if (isThere == NO) {
        [self.curContest.contest_posts addObject:self.curPost];
    }
    
    // END FIXME

        
        if(isVote){
                    // voting
            
//            NSInteger total = _curContest.contest_posts.count;
            NSDictionary * rankDict = [self GetRankOfPost:_curContest.contest_posts];
            NSInteger total = [[rankDict allKeys] count];
            NSInteger curRank = [[rankDict objectForKey:_curPost.objectId] integerValue];
            
            _lblTime.text =[NSString stringWithFormat:@"%@ - %ld/%ld rank - %@", isSet(_curContest.tags)?_curContest.tags:@"", (long)(total - curRank +1), (long)total,   [GD getDuringofDate:_curContest.vote_end_date]];

            
             if([[NSDate date] compare:_curPost.contest.vote_end_date ] == NSOrderedDescending){
                 _lblTime.text =[NSString stringWithFormat:@"%@ - %ld/%ld rank - Ended", isSet(_curContest.tags)?_curContest.tags:@"", (long)(total - curRank +1), (long)total];
             }
        }else{

            
            _lblTime.text =[NSString stringWithFormat:@"%@ - %@", isSet(_curContest.tags)?_curContest.tags:@"#",   [GD getDuringofDate:_curContest.end_date]];
        }
        
    
    
}

@end
