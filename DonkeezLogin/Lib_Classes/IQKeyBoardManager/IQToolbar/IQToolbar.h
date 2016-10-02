

#import <UIKit/UIToolbar.h>

/**
 IQToolbar for IQKeyboardManager.
 */
@interface IQToolbar : UIToolbar <UIInputViewAudioFeedback>

/**
 Title font for toolbar.
 */
@property(nullable, nonatomic, strong) UIFont *titleFont;

/**
 Toolbar title
 */
@property(nullable, nonatomic, strong) NSString *title;

@end

