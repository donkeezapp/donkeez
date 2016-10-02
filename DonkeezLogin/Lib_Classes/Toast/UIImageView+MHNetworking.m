

#import "UIImageView+MHNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation UIImageView (MHNetworking)

- (void)setMHImageWithURL:(NSURL *)url success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, UIImage *))success failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *))failure {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    [self setImageWithURLRequest:request placeholderImage:nil success:success failure:failure];
    
}

- (void)setMHImageWithURL:(NSURL *)url  {
//    __weak UIImageView *weakImageView = self;
    [self setMHImageWithURL:url withAnimationDuration:0.0];
   }

- (void)setMHImageWithURL:(NSURL *)url withAnimationDuration:(float)animationDuration {
    __weak UIImageView *weakImageView = self;
    
    [self setMHImageWithURL:url success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            UIImageView *strongImageView = weakImageView;
            if (animationDuration) {
                strongImageView.alpha = 0.0;
            }
            
            strongImageView.image = image;
            if (animationDuration) {
                [UIView animateWithDuration:0.5 animations:^{
                    strongImageView.alpha = 1.0;
                }];
            }
        });

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
  }

- (void)setMHImageWithURL:(NSURL *)url completion:(void(^)(NSError * error , NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))completion {
    __weak UIImageView *weakImageView = self;
    
    [self setMHImageWithURL:url success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            UIImageView *strongImageView = weakImageView;

            strongImageView.image = image;

            completion(nil, request, response, image);
            
        });
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        if(!error){
            error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
        }
        completion(error, request, response, nil);
    }];
}

@end
