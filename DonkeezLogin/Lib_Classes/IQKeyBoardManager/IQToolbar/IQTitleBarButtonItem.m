

#import "IQTitleBarButtonItem.h"
#import "IQKeyboardManagerConstants.h"
#import "IQKeyboardManagerConstantsInternal.h"
#import <UIKit/UILabel.h>

#ifndef NSFoundationVersionNumber_iOS_5_1
    #define NSTextAlignmentCenter UITextAlignmentCenter
#endif

@implementation IQTitleBarButtonItem
{
    UIView *_titleView;
    UILabel *_titleLabel;
}
@synthesize font = _font;


-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super init];
    if (self)
    {
        _titleView = [[UIView alloc] initWithFrame:frame];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        _titleLabel = [[UILabel alloc] initWithFrame:_titleView.bounds];
        
        if (IQ_IS_IOS7_OR_GREATER)
        {
            [_titleLabel setTextColor:[UIColor lightGrayColor]];
        }
        else
        {
            [_titleLabel setTextColor:[UIColor whiteColor]];
        }
        
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self setTitle:title];
        [self setFont:[UIFont boldSystemFontOfSize:12.0]];
        [_titleView addSubview:_titleLabel];
        
        self.customView = _titleView;
        self.enabled = NO;
    }
    return self;
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    [_titleLabel setFont:font];
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    _titleLabel.text = title;
}

@end
