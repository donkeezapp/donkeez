#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *last_name;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, strong) NSString *device_id;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *first_name;
@end