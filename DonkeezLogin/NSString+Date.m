#import "NSString+Date.h"

@implementation NSString (Date)
+(NSString *)stringWithDateFormat:(NSString *)dateFormat date:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *resultString = [formatter stringFromDate:date];
    return resultString;
}
@end
