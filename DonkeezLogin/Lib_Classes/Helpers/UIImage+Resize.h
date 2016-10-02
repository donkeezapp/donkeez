#import <Foundation/Foundation.h>


@interface UIImage(ResizeCategory)
-(UIImage*)resizedImageToSize:(CGSize)dstSize;
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;
- (UIImage *)cropedToRect:(CGRect)rect;
- (UIImage *)resizeImageToNewSize:(CGSize)newSize;
@end
