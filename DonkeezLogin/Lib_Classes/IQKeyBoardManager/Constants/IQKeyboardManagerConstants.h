

#ifndef IQKeyboardManagerConstants_h
#define IQKeyboardManagerConstants_h

#import <Foundation/NSObjCRuntime.h>

///----------------
/// @name Debugging
///----------------

/**
 Set IQKEYBOARDMANAGER_DEBUG=1 in preprocessor macros under build settings to enable debugging.
 */

///-----------------------------------
/// @name IQAutoToolbarManageBehaviour
///-----------------------------------

/**
 `IQAutoToolbarBySubviews`
 Creates Toolbar according to subview's hirarchy of Textfield's in view.
 
 `IQAutoToolbarByTag`
 Creates Toolbar according to tag property of TextField's.
 
 `IQAutoToolbarByPosition`
 Creates Toolbar according to the y,x position of textField in it's superview coordinate.
 */
#ifndef NS_ENUM
typedef enum IQAutoToolbarManageBehaviour {
    IQAutoToolbarBySubviews,
    IQAutoToolbarByTag,
    IQAutoToolbarByPosition,
}IQAutoToolbarManageBehaviour;
#else
typedef NS_ENUM(NSInteger, IQAutoToolbarManageBehaviour) {
    IQAutoToolbarBySubviews,
    IQAutoToolbarByTag,
    IQAutoToolbarByPosition,
};
#endif

///-------------------
/// @name Localization
///-------------------

#define IQLocalizedString(key, comment) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"IQKeyboardManager" ofType:@"bundle"]] localizedStringForKey:(key) value:@"" table:@"IQKeyboardManager"]


/* XCode 5.0 Compatibility for NS_DESIGNATED_INITIALIZER*/
#ifndef NS_DESIGNATED_INITIALIZER
    #if __has_attribute(objc_designated_initializer)
        #define NS_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
    #else
        #define NS_DESIGNATED_INITIALIZER
    #endif
#endif


#endif

/*
 
 /---------------------------------------------------------------------------------------------------\
 \---------------------------------------------------------------------------------------------------/
 |                                   iOS NSNotification Mechanism                                    |
 /---------------------------------------------------------------------------------------------------\
 \---------------------------------------------------------------------------------------------------/
 
 1) Begin Editing:-         When TextField begin editing.
 2) End Editing:-           When TextField end editing.
 3) Switch TextField:-      When Keyboard Switch from a TextField to another TextField.
 3) Orientation Change:-    When Device Orientation Change.
 
 
 ----------------------------------------------------------------------------------------------------------------------------------------------
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 ----------------------------------------------------------------------------------------------------------------------------------------------
 =============
 UITextField
 =============
 
 Begin Editing                                Begin Editing
 --------------------------------------------           ----------------------------------           ---------------------------------
 |UITextFieldTextDidBeginEditingNotification| --------> | UIKeyboardWillShowNotification | --------> | UIKeyboardDidShowNotification |
 --------------------------------------------           ----------------------------------           ---------------------------------
 ^                  Switch TextField             ^               Switch TextField
 |                                               |
 |                                               |
 | Switch TextField                              | Orientation Change
 |                                               |
 |                                               |
 |                                               |
 --------------------------------------------    |      ----------------------------------           ---------------------------------
 | UITextFieldTextDidEndEditingNotification | <-------- | UIKeyboardWillHideNotification | --------> | UIKeyboardDidHideNotification |
 --------------------------------------------           ----------------------------------           ---------------------------------
 |                    End Editing                                                             ^
 |                                                                                            |
 |--------------------End Editing-------------------------------------------------------------|
 
 
 ----------------------------------------------------------------------------------------------------------------------------------------------
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 ----------------------------------------------------------------------------------------------------------------------------------------------
 =============
 UITextView
 =============
 |-------------------Switch TextView--------------------------------------------------------------|
 | |------------------Begin Editing-------------------------------------------------------------| |
 | |                                                                                            | |
 v |                  Begin Editing                               Switch TextView               v |
 --------------------------------------------           ----------------------------------           ---------------------------------
 | UITextViewTextDidBeginEditingNotification| <-------- | UIKeyboardWillShowNotification | --------> | UIKeyboardDidShowNotification |
 --------------------------------------------           ----------------------------------           ---------------------------------
 ^
 |
 |------------------------Switch TextView--------|
 |                                               | Orientation Change
 |                                               |
 |                                               |
 |                                               |
 --------------------------------------------    |      ----------------------------------           ---------------------------------
 | UITextViewTextDidEndEditingNotification  | <-------- | UIKeyboardWillHideNotification |           | UIKeyboardDidHideNotification |
 --------------------------------------------           ----------------------------------           ---------------------------------
 |                    End Editing                                                             ^
 |                                                                                            |
 |--------------------End Editing-------------------------------------------------------------|
 
 
 ----------------------------------------------------------------------------------------------------------------------------------------------
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 ----------------------------------------------------------------------------------------------------------------------------------------------
 */
