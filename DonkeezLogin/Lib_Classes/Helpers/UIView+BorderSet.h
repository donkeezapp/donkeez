

#import <UIKit/UIKit.h>

@interface UIView (BorderSet)

//@property(nonatomic, strong)UIActivityIndicatorView * avLoader;

- (void)setBorderForColor:(UIColor *)color
                    width:(float)width
                   radius:(float)radius;
-(void)setBackgroundColor:(UIColor *)backgroundColor
           BorderForColor:(UIColor *)color
                    width:(float)width
                   radius:(float)radius;
-(void)makeShadowWithRadius:(CGFloat)rad;
-(void)makeShadowFancywithRadius:(CGFloat)rad;
-(CGPathRef)fancyShadowForRect:(CGRect)rect;

-(void)makeCircled;
-(void)makeRounded:(CGFloat)rad;

-(UIColor *) colorOfPoint:(CGPoint)point;
//-(void)startLoader;
//-(void)stopLoader;
@end
