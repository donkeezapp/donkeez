

#import "UIButton+Actvity.h"

@implementation UIButton (Actvity)
-(void) beginActivityModaly:(BOOL) modaly{
     if (modaly) [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    for (UIView* view in self.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]){
            [(UIActivityIndicatorView*)view startAnimating];
            return;
        }
    }
    
    UIActivityIndicatorView* view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    view.color = [UIColor blackColor];
    view.hidesWhenStopped=YES;
    [self addSubview:view];
    view.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*.5);

    [view startAnimating];
   
}
-(void) endActivityModaly:(BOOL) modaly{
    if (modaly) [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    for (UIView* view in self.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]){
            [(UIActivityIndicatorView*)view stopAnimating];
            return;
        }
    }
}

-(void)setTitle:(NSString*)title
BackgroundColor:(UIColor *)backgroundColor
 BorderForColor:(UIColor *)color
          width:(float)width
         radius:(float)radius{
    [self setTitle:title forState:UIControlStateNormal];
    [self setBackgroundColor:backgroundColor BorderForColor:color width:width radius:radius];
    
}

-(void)setNormalThemeWithTitle:(NSString*)title{
    [self setTitle:title BackgroundColor:Color_bar BorderForColor:Color_MainFore width:1 radius:SB_VIEW_CORNER_RADIUS];
    [self setTitleColor:BD_HILIGHTED_BAR_COLOR forState:UIControlStateNormal];
}

@end
