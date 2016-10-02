//
//  Likes.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Likes : NSObject

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, strong) NSDate *last_time;
@property (nonatomic, strong) NSString *postid;

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSNumber *likes;



@end
