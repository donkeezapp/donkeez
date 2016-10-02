

#import "IQKeyboardManagerConstants.h"

#import <Foundation/NSObjCRuntime.h>

#import <UIKit/UISegmentedControl.h>

#if !(__has_feature(objc_instancetype))
    #define instancetype id
#endif


/**
 Custom SegmentedControl for Previous/Next button.
 
 @deprecated Deprecated in iOS 7
 */
@interface IQSegmentedNextPrevious : UISegmentedControl

/**
 Initialization function for IQSegmentedNextPrevious.
 
 @param target Target object for selector. Usually 'self'.
 @param previousAction Previous button action name. Usually 'previousAction:(IQSegmentedNextPrevious*)segmentedControl'.
 @param nextAction Next button action name. Usually 'nextAction:(IQSegmentedNextPrevious*)segmentedControl'.
 */
- (nonnull instancetype)initWithTarget:(nullable id)target previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction NS_DESIGNATED_INITIALIZER;

/**
 Unavailable. Please use initWithTarget:previousAction:nextAction: method
 */
-(nonnull instancetype)init NS_UNAVAILABLE;

/**
 Unavailable. Please use initWithTarget:previousAction:nextAction: method
 */
-(nonnull instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 Unavailable. Please use initWithTarget:previousAction:nextAction: method
 */
+ (nonnull instancetype)new NS_UNAVAILABLE;


@end

