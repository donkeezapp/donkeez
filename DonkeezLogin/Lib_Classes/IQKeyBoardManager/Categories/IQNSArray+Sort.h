

#import <Foundation/NSArray.h>

/**
 UIView.subviews sorting category.
 */
@interface NSArray (IQ_NSArray_Sort)

///--------------
/// @name Sorting
///--------------

/**
 Returns the array by sorting the UIView's by their tag property.
 */
- (nonnull NSArray*)sortedArrayByTag;

/**
 Returns the array by sorting the UIView's by their tag property.
 */
- (nonnull NSArray*)sortedArrayByPosition;

@end
