
#import <UIKit/UIKit.h>

@interface UIButton (Actvity)
-(void) beginActivityModaly:(BOOL) modaly;
-(void) endActivityModaly:(BOOL) modaly;
-(void)setTitle:(NSString*)title
BackgroundColor:(UIColor *)backgroundColor
 BorderForColor:(UIColor *)color
          width:(float)width
         radius:(float)radius;

-(void)setNormalThemeWithTitle:(NSString*)title;
@end
