
#import <UIKit/UIKit.h>

@interface ProfileTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgSepLine;
@property(nonatomic, strong)Post * curPost;
@property(nonatomic, strong)Contest * curContest;
@property(nonatomic)BOOL isVote;



-(void)setCurPostData:(Post*)post isVote:(BOOL)isVote;
@end
