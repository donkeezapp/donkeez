

#import <UIKit/UIKit.h>

@interface UIImageView (MHNetworking)

- (void)setMHImageWithURL:(NSURL *)url
                success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;

- (void)setMHImageWithURL:(NSURL *)url withAnimationDuration:(float)animationDuration;
- (void)setMHImageWithURL:(NSURL *)url;
- (void)setMHImageWithURL:(NSURL *)url completion:(void(^)(NSError * error , NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))completion ;
@end
