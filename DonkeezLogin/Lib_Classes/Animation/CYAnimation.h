

#import <Foundation/Foundation.h>

@interface CYAnimation : NSObject

+ (void)slideRighttoCenter:(UIView*)View andTime:(CGFloat)time;
+ (void)slideCentertoLeft:(UIView*)View andTime:(CGFloat)time;
+ (void)slideBottomtoCenter:(UIView*)View andTime:(CGFloat)time;
+ (void)slideCentertoUp:(UIView*)View andTime:(CGFloat)time;
+ (void)slideAndRotateRighttoCenter:(UIView*)View andTime:(CGFloat)time;
+ (void)slideAndRotateCentertoLeft:(UIView*)View andTime:(CGFloat)time;

+ (void)fadeIn:(UIView*)View andTime:(CGFloat)time;
+ (void)fadeOut:(UIView*)View andTime:(CGFloat)time;

+ (void)fadeOut:(UIView*)View andTime:(CGFloat)time andCompletion:(void(^)())completion;

+ (void)slideCentertoBottom:(UIView*)View andTime:(CGFloat)time;

+ (void)alphIn:(UIView*)View andTime:(CGFloat)time;

+ (void)alphOut:(UIView*)View andTime:(CGFloat)time;

+(void)makeShadow:(UIView*)view radius:(CGFloat)rad;

+(void)makeShadowFancy:(UIView*)view  radius:(CGFloat)rad;
+ (UIImage *)imageWithColor:(UIColor *)color;


+(void)PushAnimationRight2left:(UIViewController *)vc nav:(UINavigationController*)navC target:(UIViewController *)targetVC;
+(void)PushAnimationLeft2Right:(UIViewController *)vc nav:(UINavigationController*)navC target:(UIViewController *)targetVC;
+ (void)fadeIn:(UIView*)View andTime:(CGFloat)time completion:(void(^)(BOOL finished))completion;
+(void)ChangeRootViewAnimation:(UIViewController*)newRootVC;
+(void)RotateClockWise:(UIView*)View andTime:(CGFloat)time;
+(void)PopAnimationFlip:(UIViewController *)vc nav:(UINavigationController*)navC target:(UIViewController *)targetVC;
+(void)PopAnimationLeft2Right:(UIViewController *)vc nav:(UINavigationController*)navC target:(UIViewController *)targetVC;
+(NSArray*)GetFilterNaemArray;
+(UIImage *)filterImage:(UIImage*)origin FileterName:(NSString*)filterName;
+(void)RotateClockWise:(UIView*)View andTime:(CGFloat)time angle:(CGFloat)angle;
@end
