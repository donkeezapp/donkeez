

#import <Foundation/NSObjCRuntime.h>
#import "IQKeyboardManagerConstants.h"
#import "IQBarButtonItem.h"

#if !(__has_feature(objc_instancetype))
    #define instancetype id
#endif


/**
 BarButtonItem with title text.
 */
@interface IQTitleBarButtonItem : IQBarButtonItem

/**
 Font to be used in bar button. Default is (system font 12.0 bold).
 */
@property(nullable, nonatomic, strong) UIFont *font;

/**
 Initialize with frame and title.
 
 @param frame Initial frame of barButtonItem
 @param title Title of barButtonItem.
 */
-(nonnull instancetype)initWithFrame:(CGRect)frame title:(nullable NSString *)title NS_DESIGNATED_INITIALIZER;

/**
 Unavailable. Please use initWithFrame:title: method
 */
-(nonnull instancetype)init NS_UNAVAILABLE;

/**
 Unavailable. Please use initWithFrame:title: method
 */
-(nonnull instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 Unavailable. Please use initWithFrame:title: method
 */
+ (nonnull instancetype)new NS_UNAVAILABLE;

@end
