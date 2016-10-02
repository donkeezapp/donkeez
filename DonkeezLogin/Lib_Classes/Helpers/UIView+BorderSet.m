
#import "UIView+BorderSet.h"

@implementation UIView (BorderSet)
- (void)setBorderForColor:(UIColor *)color
                    width:(float)width
                   radius:(float)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = width;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor
           BorderForColor:(UIColor *)color
                    width:(float)width
                   radius:(float)radius{
    [self setBorderForColor:color width:width radius:radius];
    
    self.backgroundColor = backgroundColor;
}

-(void)makeCircled
{
    self.layer.cornerRadius = MIN(self.bounds.size.height, self.bounds.size.width) / 2.;
    self.layer.masksToBounds = YES;
}
-(void)makeRounded:(CGFloat)rad
{
    self.layer.cornerRadius = rad;
    self.layer.masksToBounds = YES;
}

-(void)makeShadowWithRadius:(CGFloat)rad
{
    
    //    CALayer *layer = self.layer;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowRadius = rad;
    self.layer.shadowOpacity = 0.80f;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.layer.bounds] CGPath];
    
}

-(void)makeShadowFancywithRadius:(CGFloat)rad
{
    
    //    CALayer *layer = self.layer;
    
    //changed to zero for the new fancy shadow
    self.layer.shadowOffset = CGSizeZero;
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    
    //changed for the fancy shadow
    self.layer.shadowRadius = rad;
    
    self.layer.shadowOpacity = 0.80f;
    
    //call our new fancy shadow method
    self.layer.shadowPath = [self fancyShadowForRect:self.layer.bounds];
    
}


-(UIColor *) colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel,
                                                 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0
                                     green:pixel[1]/255.0 blue:pixel[2]/255.0
                                     alpha:pixel[3]/255.0];
    return color;
}

//
//-(void)startLoader
//{
////    if(self.avLoader == nil){
//        self.avLoader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
////    }
//    self.avLoader.color = [UIColor grayColor];
//    self.avLoader.hidesWhenStopped=YES;
//    [self addSubview:self.avLoader];
//    self.avLoader.center = CGPointMake(self.frame.size.width*.5, self.frame.size.height*.5);
//    [self.avLoader startAnimating];
//
//}
//-(void)stopLoader{
//    [self.avLoader stopAnimating];
//}


-(CGPathRef)fancyShadowForRect:(CGRect)rect
{
    CGSize size = rect.size;
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    //right
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(size.width, 0.0f)];
    [path addLineToPoint:CGPointMake(size.width, size.height + 15.0f)];
    
    //curved bottom
    [path addCurveToPoint:CGPointMake(0.0, size.height + 15.0f)
            controlPoint1:CGPointMake(size.width - 15.0f, size.height)
            controlPoint2:CGPointMake(15.0f, size.height)];
    
    [path closePath];
    
    return path.CGPath;
}


@end
