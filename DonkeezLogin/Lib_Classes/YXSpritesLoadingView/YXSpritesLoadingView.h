//
//  YXSpritesLoadingView.h
//  Gogobot-iOS
//
//  Created by Yin Xu on 05/14/14.
//  Copyright (c) 2014 Yin Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

/***************************************************************
 
General Information Here:
 
 - set shouldShimmering to YES will using the FBShimmering effect on loader text label, default to YES. FBShimmering library is included in YXSpritesActivityLoader. Information for FBShimmering library: https://github.com/facebook/Shimmer

***************************************************************/


/***************************************************************
 
 Define Loading Background Attributes Here:
 
 - 85% alpha white is the default color
 - 5 is default Loader Corner Radius
 - set loaderBlurViewShow to YES will have the blur effect on loader background, the background color will be ignored
 
***************************************************************/



@interface YXSpritesLoadingView : UIView

+ (YXSpritesLoadingView *)sharedInstance;
+ (void)show;

+ (void)dismiss;

@end
