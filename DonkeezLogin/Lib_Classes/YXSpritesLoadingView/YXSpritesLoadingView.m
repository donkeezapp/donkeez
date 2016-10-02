//
//  YXSpritesLoadingView.h
//  Gogobot-iOS
//
//  Created by Yin Xu on 05/14/14.
//  Copyright (c) 2014 Yin Xu. All rights reserved.
//

#import "YXSpritesLoadingView.h"
#import "UIImageView+Rotate.h"

#define LOADVIEW_WIDTH 100
#define LOADVIEW_HEIGHT 100
#define DEFAULT_PADDING 10
#define   WHITE_COLOR  [UIColor whiteColor]
#define LOADVIEW_CORNER_RADIOUS 10
#define BACKGROUND_LOADVIEW_COLOR myRGBA(243, 242, 95,180)
#define  DEFAULT_FONT   [UIFont systemFontOfSize:10]
#define SMALL_PADDING 10

@implementation YXSpritesLoadingView
{
    UIView *loaderView;
    UIView *backView;
    UIImageView *loadingImageView;
    UILabel *loadingLabel;
    UIWindow *window;
    int adjustHeightForLoader; //when we set shouldBlockCurrentViewUserIntercation to YES
                               //we leave 64 pixel on the top of the screen for the nav bar
                               //so we need adjust the center point of loader
    
}

#pragma mark - Class Methods
+ (YXSpritesLoadingView *)sharedInstance
{
	static dispatch_once_t once = 0;
	static YXSpritesLoadingView *sharedInstance;
	dispatch_once(&once, ^{
        sharedInstance = [[YXSpritesLoadingView alloc] init];
    });
	return sharedInstance;
}

+ (void)show
{
	[[self sharedInstance] loadingViewSetup];
}
+ (void)dismiss
{
    [[self sharedInstance] loadingViewHide];
}


#pragma mark - Initialization Methods
- (id)init
{
    self = [super initWithFrame: [UIScreen mainScreen].bounds];
    self.backgroundColor = [UIColor clearColor];
	id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    window = [delegate respondsToSelector:@selector(window)] ? [delegate performSelector:@selector(window)] : [[UIApplication sharedApplication] keyWindow];
	self.alpha = 0;
	return self;
}

#pragma mark - Helper Methods
- (void)loadingViewSetup
{
    if (!loadingImageView)
    {
        loaderView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - LOADVIEW_WIDTH) / 2,
                                                              (self.frame.size.height - LOADVIEW_HEIGHT) / 2,
                                                              LOADVIEW_WIDTH,
                                                              LOADVIEW_HEIGHT)];

//        loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(DEFAULT_PADDING, (LOADVIEW_HEIGHT - 20) / 2, LOADVIEW_WIDTH - 2 * DEFAULT_PADDING, 20)];
//        [loaderView addSubview:loadingLabel];
//        loadingLabel.font = DEFAULT_FONT;
//        loadingLabel.textAlignment = NSTextAlignmentCenter;
//        loadingLabel.text = @"Mix&Match";
//        loadingLabel.textColor = WHITE_COLOR;
//        loadingLabel.numberOfLines = 0;
        UIImageView * markImg = [[UIImageView alloc] initWithFrame:CGRectMake(LOADVIEW_WIDTH  / 4, LOADVIEW_HEIGHT  / 4, LOADVIEW_WIDTH /2, LOADVIEW_HEIGHT/2)];
//        UIImageView * markImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, LOADVIEW_WIDTH , LOADVIEW_HEIGHT)];
        
        [markImg setContentMode:UIViewContentModeScaleAspectFit];
        [loaderView addSubview:markImg];
        [markImg setImage:[UIImage imageNamed:@"mark.png"]];
        
        
        loaderView.layer.cornerRadius = LOADVIEW_CORNER_RADIOUS;
        loaderView.backgroundColor = BACKGROUND_LOADVIEW_COLOR;
        
        loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(DEFAULT_PADDING + SMALL_PADDING, DEFAULT_PADDING + SMALL_PADDING, LOADVIEW_WIDTH - 2 * (DEFAULT_PADDING + SMALL_PADDING), LOADVIEW_HEIGHT - 2 * (DEFAULT_PADDING + SMALL_PADDING))];
        loadingImageView.contentMode = UIViewContentModeScaleAspectFit;
        loadingImageView.image = [UIImage imageNamed:@"loading.png"];
        [loaderView addSubview:loadingImageView];
        [loadingImageView rotate360WithDuration:1 repeatCount:1000];
        
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [backView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.43]];
        
    }
    

    if (loaderView.superview == nil)
    {
        
        [window addSubview:backView];
        [window addSubview:loaderView];
    }
  
    loaderView.alpha = 0;
    backView.alpha = 0;
    loaderView.transform = CGAffineTransformScale(loaderView.transform, 1.5, 1.5);
    
    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        loaderView.alpha = 1;
        backView.alpha = 1;
        loaderView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished)
     {
         self.alpha = 1;
     }];
}

- (void)loadingViewHide
{
   // if (self.alpha == 1)
	{
		[UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^{
            loaderView.transform = CGAffineTransformScale(loaderView.transform, 1.5, 1.5);
			loaderView.alpha = 0;
            backView.alpha = 0;
		} completion:^(BOOL finished) {
             self.alpha = 0;
            [loadingImageView removeFromSuperview];
            [loadingImageView stopAnimating];
            loadingImageView = nil;
            
            [loadingLabel removeFromSuperview];
            loadingLabel = nil;
        
            [loaderView removeFromSuperview];
            loaderView = nil;
            
            [backView removeFromSuperview];
            backView = nil;
            
            self.alpha = 0;
        }];
	}
}



@end
