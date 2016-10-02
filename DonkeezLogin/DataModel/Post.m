#import "Backendless.h"
#import "Post.h"
#import "Likes.h"
@implementation Post

-(void)LikesOfUser:(BackendlessUser *)user success:(void(^ _Nullable)(NSInteger count, NSString * msg))success failed:(void(^)(NSString * error, NSInteger errorCode))failed{
    
    BackendlessDataQuery *query = [BackendlessDataQuery query];
    query.whereClause = [NSString stringWithFormat:@"userid = \'%@\' AND postid = \'%@\'", user.userId, _objectId];
//    BackendlessCollection *collection = [backendless.persistenceService find:[Likes class] dataQuery:query];
    
    
    [backendless.persistenceService find:[Likes class] dataQuery:query response:^(BackendlessCollection * beCollection) {
        
        if(beCollection.data.count > 0){
            
            Likes * likes = (Likes*)[beCollection.data objectAtIndex:0];
            
            NSTimeInterval  interval = [likes.last_time timeIntervalSinceNow];
            NSTimeInterval oneDay = 24*3600;
//                        NSTimeInterval oneDay = 5;
            if(-interval >= oneDay){
                success(likes.likes.integerValue, @"");

            }else{
                NSTimeInterval remain = oneDay + interval;
                NSDate * nextVotetime = [NSDate dateWithTimeIntervalSinceNow:remain];
                NSString * msg = [NSString stringWithFormat:@"%@ %@",MCLocalString(@"You can vote again after") ,[GD getDuringofDate:nextVotetime]  ];
               

                success( likes.likes.integerValue, msg);

            }
            
          }else{
            success( 0, @"");
        }
        
    } error:^(Fault * fault) {
        failed(@"" , 401);
    }];
    
}

-(void)LikewithLikeableUser:(BackendlessUser *)user success:(void(^ _Nullable)())success failed:(void(^)(NSString * error, NSInteger errorCode))failed{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @try {
            BackendlessDataQuery *query = [BackendlessDataQuery query];
            query.whereClause = [NSString stringWithFormat:@"userid = \'%@\' AND postid = \'%@\'", user.userId, _objectId];
            BackendlessCollection *collection = [backendless.persistenceService find:[Likes class] dataQuery:query];
            
            if( collection.data.count == 1){
                
                Likes * likes =  (Likes*)[collection.data objectAtIndex:0];
                NSTimeInterval  interval = [likes.last_time timeIntervalSinceNow];
                NSTimeInterval oneDay = 24*3600;
                if(-interval >= oneDay){
                    NSInteger inc = likes.likes.integerValue + 1;
                    
                    likes.likes = @(inc);
                    
                    likes.last_time  = [NSDate date];
                    id<IDataStore> dataStore = [backendless.persistenceService of:[Likes class]];
//                    Fault * likesfault;
                    
                    [dataStore save:likes];
                    
                                        
                    success();

                    
                    
                }else{
                    NSTimeInterval remain = oneDay + interval;
                    NSDate * nextVotetime = [NSDate dateWithTimeIntervalSinceNow:remain];
                    NSString * msg = [NSString stringWithFormat:@"%@ %@",MCLocalString(@"You can vote again after") ,[GD getDuringofDate:nextVotetime]  ];
                    failed(msg, 200);
                }
                
                
            }else if( collection.data.count == 0){
                
                Likes * newLikes = [Likes new];
                newLikes.userid = user.userId;
                newLikes.postid = self.objectId;
                newLikes.likes = @(1);
                newLikes.last_time = [NSDate date];
                id<IDataStore> dataStore = [backendless.persistenceService of:[Likes class]];
                [dataStore save:newLikes];
             
                
                // post updating
                
                
                success();
            }else{
                
                failed(MCLocalString(@"Failed to like , try again after a moment."), 401);
                NSLog(@"Post / isLikeableUser Likes table error  ");
             
            }
            
    
       }
    
        @catch (Fault *fault) {
            failed(MCLocalString(@"Failed to like , try again after a moment."), 401);
            NSLog(@"Post / isLikeableUser search  FAULT = %@ ", fault);
            
            
        }

    });
    
    
    
}
@end