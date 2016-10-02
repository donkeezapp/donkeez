

#import "IQToolbar.h"
#import "IQKeyboardManagerConstantsInternal.h"
#import "IQTitleBarButtonItem.h"
#import "IQUIView+Hierarchy.h"

#import <UIKit/UIViewController.h>

#if !(__has_feature(objc_instancetype))
    #define instancetype id
#endif


@implementation IQToolbar
@synthesize titleFont = _titleFont;
@synthesize title = _title;

+(void)initialize
{
    [super initialize];
    
    //Tint Color
    [[self appearance] setTintColor:nil];

#ifdef NSFoundationVersionNumber_iOS_6_1
    if ([[self appearance] respondsToSelector:@selector(setBarTintColor:)])
    {
        [[self appearance] setBarTintColor:nil];
    }
#endif
    
    //Background image
    [[self appearance] setBackgroundImage:nil forToolbarPosition:UIBarPositionAny           barMetrics:UIBarMetricsDefault];
    [[self appearance] setBackgroundImage:nil forToolbarPosition:UIBarPositionBottom        barMetrics:UIBarMetricsDefault];
    [[self appearance] setBackgroundImage:nil forToolbarPosition:UIBarPositionTop           barMetrics:UIBarMetricsDefault];
    [[self appearance] setBackgroundImage:nil forToolbarPosition:UIBarPositionTopAttached   barMetrics:UIBarMetricsDefault];
    
    //Shadow image
    [[self appearance] setShadowImage:nil forToolbarPosition:UIBarPositionAny];
    [[self appearance] setShadowImage:nil forToolbarPosition:UIBarPositionBottom];
    [[self appearance] setShadowImage:nil forToolbarPosition:UIBarPositionTop];
    [[self appearance] setShadowImage:nil forToolbarPosition:UIBarPositionTopAttached];
    
    //Background color
    [[self appearance] setBackgroundColor:nil];
}

-(void)initialize
{
    [self sizeToFit];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight;
    self.translucent = YES;
    
    if (IQ_IS_IOS7_OR_GREATER)
    {
        [self setTintColor:[UIColor blackColor]];
    }
    else
    {
        [self setBarStyle:UIBarStyleBlackTranslucent];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFit = [super sizeThatFits:size];

    sizeThatFit.height = 44;
    
    return sizeThatFit;
}

-(void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];

    for (UIBarButtonItem *item in self.items)
    {
        [item setTintColor:tintColor];
    }
}

-(void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    for (UIBarButtonItem *item in self.items)
    {
        if ([item isKindOfClass:[IQTitleBarButtonItem class]])
        {
            [(IQTitleBarButtonItem*)item setFont:titleFont];
        }
    }
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    for (UIBarButtonItem *item in self.items)
    {
        if ([item isKindOfClass:[IQTitleBarButtonItem class]])
        {
            [(IQTitleBarButtonItem*)item setTitle:title];
        }
    }
}

#pragma mark - UIInputViewAudioFeedback delegate
- (BOOL) enableInputClicksWhenVisible
{
	return YES;
}

@end
