#import "Backendless.h"
#import "Contest.h"
#import "Products.h"
#import "Post.h"

@implementation Contest

-(void)addToProducts:(Products *)products {

    if (!self.products)
        self.products = [NSMutableArray array];

    [self.products addObject:products];
}

-(void)removeFromProducts:(Products *)products {

    [self.products removeObject:products];

    if (!self.products.count) {
        self.products = nil;
    }
}

-(NSMutableArray *)loadProducts {

    if (!self.products)
        [backendless.persistenceService load:self relations:@[@"products"]];

    return self.products;
}

-(void)freeProducts {

    if (!self.products)
        return;

    [self.products removeAllObjects];
    self.products = nil;
}

-(void)addToContest_posts:(Post *)post {

    if (!self.contest_posts)
        self.contest_posts = [NSMutableArray array];

    [self.contest_posts addObject:post];
}

-(void)removeFromContest_posts:(Post *)post {

    [self.contest_posts removeObject:post];

    if (!self.contest_posts.count) {
        self.contest_posts = nil;
    }
}

-(Post*)isContainUsersPost:(BackendlessUser*)user{
    
    if(self.contest_posts.count > 0){
        NSMutableArray * myPosts = [NSMutableArray new];
        for (Post * each in self.contest_posts) {
            NSLog(@"userID : each > %@, user>  %@,  contest : %@",each.post_user.userId,  user.userId, self.objectId);
            if([each.post_user.userId isEqualToString:user.userId]){
                [myPosts addObject:each];
            }
            
        }
       
        if(myPosts.count > 0){
            return [myPosts objectAtIndex:0];
            
        }
        
    }
    return nil;

    
}

-(NSInteger)getTotallikes{
    
    
    if(_contest_posts.count > 0){
        
        NSInteger total = 0;
        for (Post * post in _contest_posts) {
            total += post.likes.integerValue;
            
        }
        return  total;
        
        
    }else{
        return 0;
    }
    
}

-(NSMutableArray *)loadContest_posts {

    if (!self.contest_posts)
        [backendless.persistenceService load:self relations:@[@"contest_posts"]];

    return self.contest_posts;
}

-(void)freeContest_posts {

    if (!self.contest_posts)
        return;

    [self.contest_posts removeAllObjects];
    self.contest_posts = nil;
}
@end