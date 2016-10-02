

#import "CLImageToolBase.h"

@interface CLFilterTool : CLImageToolBase

+(NSArray *)GetFilterClassNameArr;
+(void)GetFilteredImageArr:(UIImage*)originImage completion:(void(^)(NSArray *images))completion;

@end
