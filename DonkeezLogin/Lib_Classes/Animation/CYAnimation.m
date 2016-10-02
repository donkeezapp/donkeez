
#import "CYAnimation.h"

@implementation CYAnimation

+ (void)slideRighttoCenter:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    
    View.transform=CGAffineTransformMakeTranslation(1000, 0);
    View.alpha = 0;
    
    [UIView animateWithDuration:time animations:^{
        
        View.alpha = 1;
        View.transform=CGAffineTransformMakeTranslation(0, 0);
        
    }];
    

    
}
+ (void)slideCentertoLeft:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    View.transform=CGAffineTransformMakeTranslation(0, 0);
    View.alpha = 1;
    
    [UIView animateWithDuration:time animations:^{
        
        View.alpha = 0;
        View.transform=CGAffineTransformMakeTranslation(-1000, 0);
        
    }];
    
    
    
}
+ (void)slideBottomtoCenter:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    
    View.transform=CGAffineTransformMakeTranslation(0, 1000);
    View.alpha = 0;
    
    [UIView animateWithDuration:time animations:^{
        
        View.alpha = 1;
        View.transform=CGAffineTransformMakeTranslation(0, 0);
        
    }];
    
    
    
}
+ (void)slideCentertoBottom:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    
    View.transform=CGAffineTransformMakeTranslation(0, 0);
    View.alpha = 1;
    
    [UIView animateWithDuration:time animations:^{
        
        View.alpha = 0;
        View.transform=CGAffineTransformMakeTranslation(0, 1000);
        
    }];
    
    
    
}
+ (void)slideCentertoUp:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    View.transform=CGAffineTransformMakeTranslation(0, 0);
    View.alpha = 1;
    
    [UIView animateWithDuration:time animations:^{
        
        View.alpha = 0;
        View.transform=CGAffineTransformMakeTranslation(0, -1000);
        
    }];
    
    
    
}
+ (void)slideAndRotateRighttoCenter:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    View.transform=CGAffineTransformMakeTranslation(1000, 0);
    View.alpha = 0;
    
    [UIView animateWithDuration:time animations:^{
        
        View.alpha = 1;
        View.transform=CGAffineTransformMakeTranslation(0, 0);
        
    }];
    
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.duration = 1;
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    spinAnimation.toValue = [NSNumber numberWithFloat: 2.0 * M_PI * 5];
    
    [View.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
    
    
}
+(void)RotateClockWise:(UIView*)View andTime:(CGFloat)time angle:(CGFloat)angle{
    
    //    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //    spinAnimation.duration = time;
    //    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    //    spinAnimation.toValue = [NSNumber numberWithFloat:  M_PI * 0.25];
    //
    //    [View.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
    //
    
    View.hidden=NO;
    
    //    View.transform=CGAffineTransformMakeRotation(0, 0);
    View.alpha = 1;
    
    [UIView animateWithDuration:time animations:^{
        
        //        View.alpha = 0;
        View.transform=CGAffineTransformMakeRotation(angle);
        
    }];
    
    
}
+(void)RotateClockWise:(UIView*)View andTime:(CGFloat)time{
    
//    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    spinAnimation.duration = time;
//    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
//    spinAnimation.toValue = [NSNumber numberWithFloat:  M_PI * 0.25];
//    
//    [View.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
//    
    
    View.hidden=NO;
    
//    View.transform=CGAffineTransformMakeRotation(0, 0);
    View.alpha = 1;
    
    [UIView animateWithDuration:time animations:^{
        
//        View.alpha = 0;
        View.transform=CGAffineTransformMakeRotation(M_PI * 0.25);
        
    }];
    

}
+ (void)slideAndRotateCentertoLeft:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    View.transform=CGAffineTransformMakeTranslation(0, 0);
    View.alpha = 1;
    
    [UIView animateWithDuration:time animations:^{
        
        View.alpha = 0;
        View.transform=CGAffineTransformMakeTranslation(-1000, 0);
        
    }];
    
    
    
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.duration = 1;
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    spinAnimation.toValue = [NSNumber numberWithFloat: 2.0 * M_PI * 5];
    
    [View.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
    
    
}
+ (void)fadeIn:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    View.alpha = 0;
    View.transform=CGAffineTransformMakeScale(1.5, 1.5);
    
    [UIView animateWithDuration:time animations:^{
    View.transform=CGAffineTransformMakeScale(1, 1);
        View.alpha = 1;
        
    }];
    
    
    
}
+ (void)fadeIn:(UIView*)View andTime:(CGFloat)time completion:(void(^)(BOOL finished))completion
{
    View.hidden=NO;
    
    View.alpha = 0;
    View.transform=CGAffineTransformMakeScale(1.5, 1.5);
    
    [UIView animateWithDuration:time animations:^{
        View.transform=CGAffineTransformMakeScale(1, 1);
        View.alpha = 1;
        
    } completion:^(BOOL finished) {
        completion(finished);
    }];
    
    
    
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+ (void)alphIn:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    View.alpha = 0;
//    View.transform=CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration:time animations:^{
//        View.transform=CGAffineTransformMakeScale(1.5, 1.5);
        View.alpha = 1;
        
    }];
    [UIView animateWithDuration:time animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

+ (void)alphOut:(UIView*)View andTime:(CGFloat)time
{
//    View.hidden=NO;
    
    View.alpha = 1;
    //    View.transform=CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration:time animations:^{
        //        View.transform=CGAffineTransformMakeScale(1.5, 1.5);
        View.alpha = 0;
        
    }];
    
    
    
}

+ (void)fadeOut:(UIView*)View andTime:(CGFloat)time
{
    View.hidden=NO;
    
    View.alpha = 1;
    View.transform=CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration:time animations:^{
        View.transform=CGAffineTransformMakeScale(1.5, 1.5);
        View.alpha = 0;
        
    }];
    
    
    
}

+ (void)fadeOut:(UIView*)View andTime:(CGFloat)time andCompletion:(void(^)())completion
{
    View.hidden=NO;
    
    View.alpha = 1;
    View.transform=CGAffineTransformMakeScale(1, 1);
    
    
    [UIView animateWithDuration:time animations:^{
        View.transform=CGAffineTransformMakeScale(1.5, 1.5);
        View.alpha = 0;
        

    } completion:^(BOOL finished) {
        if(completion){
            completion();
        }
    }];
    
    
    
}

+(void)makeShadow:(UIView*)view radius:(CGFloat)rad
{
    
    CALayer *layer = view.layer;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowRadius = rad;
    layer.shadowOpacity = 0.80f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    
}

+(void)makeShadowFancy:(UIView*)view  radius:(CGFloat)rad
{
    
    CALayer *layer = view.layer;
    
    //changed to zero for the new fancy shadow
    layer.shadowOffset = CGSizeZero;
    
    layer.shadowColor = [[UIColor blackColor] CGColor];
    
    //changed for the fancy shadow
    layer.shadowRadius = rad;
    
    layer.shadowOpacity = 0.80f;
    
    //call our new fancy shadow method
    layer.shadowPath = [self fancyShadowForRect:layer.bounds];

}


+(CGPathRef)fancyShadowForRect:(CGRect)rect
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


+(void)ChangeRootViewAnimation:(UIViewController*)newRootVC{
    
    [UIView transitionWithView:kAppDelegate.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{kAppDelegate.window.rootViewController =  newRootVC; }
                    completion:nil];
}

+(void)PushAnimationRight2left:(UIViewController *)vc nav:(UINavigationController*)navC target:(UIViewController *)targetVC{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.45;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFromRight;
    [animation setType:kCATransitionPush];
    animation.subtype = kCATransitionFromRight;
    animation.delegate = vc;
    [navC.view.layer addAnimation:animation forKey:nil];
    
    [navC pushViewController:targetVC animated:YES];
    
}
+(void)PushAnimationLeft2Right:(UIViewController *)vc nav:(UINavigationController*)navC target:(UIViewController *)targetVC{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.45;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    [navC.view.layer addAnimation:transition forKey:kCATransition];
    
    
    [navC pushViewController:targetVC animated:YES];
    
}
+(void)PopAnimationFlip:(UIViewController *)vc nav:(UINavigationController*)navC target:(UIViewController *)targetVC{
    
//    CATransition *animation = [CATransition animation];
//    
//    animation.duration = 0.45;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    animation.type = kCATransitionMoveIn;
//    [animation setType:kCATransitionPush];
//    animation.subtype = kCATransitionMoveIn;
//    animation.delegate = vc;
//    [navC.view.layer addAnimation:animation forKey:nil];
    
//    [navC popToViewController:targetVC animated:YES];
    
    [UIView transitionWithView:navC.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                         [navC popToViewController:targetVC animated:NO];
                    }
                    completion:nil];
    
    
}
+(void)PopAnimationLeft2Right:(UIViewController *)vc nav:(UINavigationController*)navC target:(UIViewController *)targetVC{
    

    CATransition *animation = [CATransition animation];
    animation.duration = 0.45;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFromRight;
    [animation setType:kCATransitionPush];
    animation.subtype = kCATransitionFromRight;
    animation.delegate =self;
    [navC.view.layer addAnimation:animation forKey:nil];
//    self.navigationController.navigationBarHidden = YES;
    [navC popViewControllerAnimated:YES];
    
//    [UIView transitionWithView:navC.view
//                      duration:0.75
//                       options:UIViewAnimationOptionCurveEaseIn
//                    animations:^{
//                        if(!targetVC){
//                           [navC popViewControllerAnimated:YES];
//                        }else{
//                         [navC popToViewController:targetVC animated:NO];
//                        }
//                        
//                    }
//                    completion:nil];
    
    
}


+(NSArray*)GetFilterNaemArray{
    
    
    return [[NSMutableArray alloc] initWithObjects:
                   @"OriginImage",
                   @"CIPhotoEffectMono",
                   @"CIPhotoEffectChrome",
                   @"CIPhotoEffectFade",
                   @"CIPhotoEffectInstant",
                   @"CIPhotoEffectNoir",
                   @"CIPhotoEffectProcess",
                   @"CIPhotoEffectTonal",
                   @"CIPhotoEffectTransfer",
                   @"CISRGBToneCurveToLinear",
                   @"CISepiaTone",
                   @"CIVignetteEffect",
                   nil];

}

+(UIImage *)filterImage:(UIImage*)origin FileterName:(NSString*)filterName{
      @autoreleasepool {
    
    if ([filterName isEqualToString:@"OriginImage"]) {
        return  origin;
        
    }else{
      
            CIImage *ciImage = [CIImage imageWithCGImage:origin.CGImage options:nil];
            
            CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
            
            [filter setDefaults];
            
            CIContext *context = [CIContext contextWithOptions:nil];
            
            CIImage *outputImage = [filter outputImage];
            
            CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
            
//            CIImage *editedInputImage = [[CIImage alloc] initWithCGImage:cgImage];
        
            UIImage *image = [UIImage imageWithCGImage:cgImage];
            
            CGImageRelease(cgImage);
            
            return image;

      
//        CIImage *ciImage = [[CIImage alloc] initWithImage:origin];
  }
      }
    
}

@end
