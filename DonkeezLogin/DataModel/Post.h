#import <Foundation/Foundation.h>

@class BackendlessUser;
@class Contest;

@interface Post : NSObject
@property (nonatomic, strong) NSString * ownerId;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, strong) NSNumber *is_win;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSDate *voting_time;
@property (nonatomic, strong) NSDate *posting_time;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSNumber *likes;
@property (nonatomic, strong) NSNumber *views;
@property (nonatomic, strong) NSNumber *is_valid;
@property (nonatomic, strong) BackendlessUser *post_user;
@property (nonatomic, strong) Contest *contest;

-(void)LikewithLikeableUser:(BackendlessUser *)user success:(void(^ _Nullable)())success failed:(void(^ _Nonnull)(NSString* _Nonnull error , NSInteger errorCode))failed;
-(void)LikesOfUser:(BackendlessUser * _Nonnull)user success:(void(^ _Nullable)(NSInteger count, NSString * _Nonnull msg))success failed:(void(^_Nullable)(NSString * _Nullable error, NSInteger errorCode))failed;
@end