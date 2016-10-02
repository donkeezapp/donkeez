#import <Foundation/Foundation.h>

@interface Products : NSObject
@property (nonatomic, strong) NSString *item_desc;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *item_image;
@property (nonatomic, strong) NSString *currency_unit;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *item_name;
@property (nonatomic, strong) NSDate *created;
@end