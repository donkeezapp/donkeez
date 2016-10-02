

#ifndef IQKeyboardManagerConstantsInternal_h
#define IQKeyboardManagerConstantsInternal_h


///-----------------------------------
/// @name IQLayoutGuidePosition
///-----------------------------------

/**
 `IQLayoutGuidePositionNone`
 If there are no IQLayoutGuideConstraint associated with viewController
 
 `IQLayoutGuidePositionTop`
 If provided IQLayoutGuideConstraint is associated with with viewController topLayoutGuide
 
 `IQLayoutGuidePositionBottom`
 If provided IQLayoutGuideConstraint is associated with with viewController bottomLayoutGuide
 */
#ifndef NS_ENUM
typedef enum IQLayoutGuidePosition {
    IQLayoutGuidePositionNone,
    IQLayoutGuidePositionTop,
    IQLayoutGuidePositionBottom,
}IQLayoutGuidePosition;
#else
typedef NS_ENUM(NSInteger, IQLayoutGuidePosition) {
    IQLayoutGuidePositionNone,
    IQLayoutGuidePositionTop,
    IQLayoutGuidePositionBottom,
};
#endif

//Xcode 5 compatibility check
#ifdef NSFoundationVersionNumber_iOS_6_1
    #define IQ_IS_IOS7_OR_GREATER (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
#else
    #define IQ_IS_IOS7_OR_GREATER NO
#endif

//Xcode 6 compatibility check
#ifdef NSFoundationVersionNumber_iOS_7_1
    #define IQ_IS_IOS8_OR_GREATER (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)
#else
    #define IQ_IS_IOS8_OR_GREATER NO
#endif

#endif
