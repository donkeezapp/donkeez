#import <Foundation/Foundation.h>

@class Products;
@class Post;

@interface Contest : NSObject
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSDate *end_date;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSDate *begin_date;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, strong) NSString *mark_image;
@property (nonatomic, strong) NSString *mark_post;
@property (nonatomic, strong) NSString *mark_vote;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSMutableArray *contest_posts;

@property (nonatomic, strong) NSDate *vote_begin_date;
@property (nonatomic, strong) NSDate *vote_end_date;

@property (nonatomic, strong) Post *post_win;

-(void)addToProducts:(Products *)products;
-(void)removeFromProducts:(Products *)products;
-(NSMutableArray *)loadProducts;
-(void)freeProducts;
-(void)addToContest_posts:(Post *)post;
-(void)removeFromContest_posts:(Post *)post;
-(NSMutableArray *)loadContest_posts;
-(void)freeContest_posts;

-(Post*)isContainUsersPost:(BackendlessUser*)user;
-(NSInteger)getTotallikes;
@end