//
//  UIActivity+CCAFacebookAppActivity.m
//  CCAFacebookAppActivity
//
//  Created by Jean-Luc Dagon on 28/02/15.
//  Copyright (c) 2015 Cocoapps. All rights reserved.
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIActivity+CCAFacebookAppActivity.h"
#import <objc/runtime.h>
//#import <FacebookSDK/FacebookSDK.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
const void *CCAFacebookAppActivityDialogParamsKey;

@implementation UIActivity (CCAFacebookAppActivity)

//////////////////////////////////////////////////////////////////////////////////////////

+ (void)load
{
    // Swizzling done as described on NSHipster
    // http://nshipster.com/method-swizzling/
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class klass = NSClassFromString([NSString stringWithFormat:@"UISoc%@", @"ialActivity"]);
        CCASwizzleInstanceMethod(klass,
                                 @selector(prepareWithActivityItems:),
                                 @selector(cca_prepareWithActivityItems:));
        CCASwizzleInstanceMethod(klass,
                                 @selector(canPerformWithActivityItems:),
                                 @selector(cca_canPerformWithActivityItems:));
        CCASwizzleInstanceMethod(klass,
                                 @selector(performActivity),
                                 @selector(cca_performActivity));
        
        
    });
}

+ (NSString *)cca_defaultFacebookActivityType
{
    static NSString *_activityType = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _activityType = [@[@"com", @"apple", @"UIKit", @"activity", @"PostToFacebook"]
                         componentsJoinedByString:@"."];
    });
    return _activityType;
}

+ (BOOL)cca_canUseFacebookAppForSharing
{
//    return [FBSDKShareDialog cans];
    return  YES;
}

- (BOOL)cca_canUseFacebookActivityOverride
{
    return ([[self activityType] isEqualToString:[self.class cca_defaultFacebookActivityType]]
            && [self.class cca_canUseFacebookAppForSharing]);
}

- (BOOL)cca_canPerformWithActivityItems:(NSArray *)activityItems
{
    if ([self cca_canUseFacebookActivityOverride]) {
        return YES;
    }
    return [self cca_canPerformWithActivityItems:activityItems];
}

- (void)cca_prepareWithActivityItems:(NSArray *)activityItems
{
    if (![self cca_canUseFacebookActivityOverride]) {
        [self cca_prepareWithActivityItems:activityItems];
        return;
    }
    
    BOOL containsImage = NO;
    BOOL containsURL = NO;
    
    NSURL *sharedURL = nil;
    NSString *sharedText = nil;
    NSMutableArray *sharedImages = [NSMutableArray array];
    NSMutableArray *sharedURLs = [NSMutableArray array];
    
    
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSURL class]]) {
            if(sharedURL == nil){
                sharedURL = (NSURL *)item;
            }
            
            [sharedURLs addObject:(NSURL *)item];
            containsURL = YES;
        } else if ([item isKindOfClass:[NSString class]]) {
            sharedText = (NSString *)item;
        } else if ([item isKindOfClass:[UIImage class]]) {
            [sharedImages addObject:item];
            containsImage = YES;
        }
    }
    
    if (!containsURL && !containsImage) {
        [self activityDidFinish:NO];
        return;
    }
    NSMutableDictionary * params = [NSMutableDictionary new];
    if (containsURL && containsImage) {
        if (sharedText) {
            sharedText = [sharedText stringByAppendingFormat:@" %@", [sharedURL absoluteString]];
        } else {
            sharedText = [sharedURL absoluteString];
        }
        
        [params setObject:sharedText forKey:@"text"];
        [params setObject:[sharedImages objectAtIndex:0] forKey:@"image"];
        [params setObject:sharedURL forKey:@"url"];
        
        if(sharedURLs.count > 1){
            [params setObject:[sharedURLs objectAtIndex:1] forKey:@"imgurl"];
        }
        
        objc_setAssociatedObject(self, &CCAFacebookAppActivityDialogParamsKey, params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
   
    if (containsImage) {
//        FBPhotoParams *photoParams = [[FBPhotoParams alloc] initWithPhotos:[sharedImages copy]];
//        objc_setAssociatedObject(self, &CCAFacebookAppActivityDialogParamsKey, [sharedImages objectAtIndex:0], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    } else {
        
//        FBLinkShareParams *linkParams = [[FBLinkShareParams alloc] initWithLink:sharedURL
//                                                                           name:sharedText
//                                                                        caption:nil
//                                                                    description:nil
//                                                                        picture:nil];
//        objc_setAssociatedObject(self, &CCAFacebookAppActivityDialogParamsKey, linkParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)cca_performActivity
{
    if (![self cca_canUseFacebookActivityOverride]) {
        [self cca_performActivity];
        return;
    }
    
    __typeof__(self) __weak weakSelf = self;
    void (^completionHandler)(NSDictionary *, NSError *) = ^(NSDictionary *results, NSError *error){
        [weakSelf activityDidFinish:(error == nil && ![results[@"completionGesture"] isEqualToString:@"cancel"])];
    };
    
    NSDictionary * param = objc_getAssociatedObject(self, &CCAFacebookAppActivityDialogParamsKey);
    
    NSString * text = [param objectForKey:@"text"];
    NSURL * url = [param objectForKey:@"url"];
    UIImage * img = [param objectForKey:@"image"];
    UIViewController * vc  = kAppDelegate.mVC;
    if (img != nil) {
        FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
        photo.image = [UIImage imageNamed:@"like_white.png"];
        photo.userGenerated = YES;
        FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
        content.photos = @[photo];
        [content setContentURL:url];
        FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
        dialog.fromViewController = vc;
        [dialog setShareContent:content];
        dialog.mode = FBSDKShareDialogModeShareSheet;
        [dialog show];
    } else {
    
        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];

        [content setContentURL:url];
        [content setContentDescription:text];
        [content setQuote:text];
        NSURL * imgUrl = [param objectForKey:@"imgurl"];
        [content setImageURL:imgUrl];
        
        FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
        dialog.fromViewController = vc;
        [dialog setShareContent:content];
        dialog.mode = FBSDKShareDialogModeShareSheet;
        [dialog show];
    }
//    [[SocialPostManager sharedManager] postToFacebook:vc IMAGE:img MSG:text URL:url];
    
}


static void CCASwizzleInstanceMethod(Class klass, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(klass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(klass, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(klass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(klass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
