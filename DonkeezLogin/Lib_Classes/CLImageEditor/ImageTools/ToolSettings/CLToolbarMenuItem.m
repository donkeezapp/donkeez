

#import "CLToolbarMenuItem.h"

#import "CLImageEditorTheme+Private.h"
#import "UIView+Frame.h"

@implementation CLToolbarMenuItem
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat W = frame.size.width;
        CGFloat H=frame.size.height;
        CGFloat widthOfIconview=W>H?H-25:W-25;
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake((W-widthOfIconview)/2, 8, widthOfIconview, widthOfIconview)];
        _iconView.clipsToBounds = YES;

        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _iconView.bottom , W, 15)];
        _titleLabel.backgroundColor = [UIColor clearColor];

        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.font = [CLImageEditorTheme toolbarTextFont];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action toolInfo:(CLImageToolInfo*)toolInfo
{
    self = [self initWithFrame:frame];
    if(self){
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:gesture];
        
        self.toolInfo = toolInfo;
    }
    return self;
}

- (NSString*)title
{
    return _titleLabel.text;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (UIImageView*)iconView
{
    return _iconView;
}

- (UIImage*)iconImage
{
    return _iconView.image;
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconView.image = iconImage;
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    self.alpha = (userInteractionEnabled) ? 1 : 0.3;
}

- (void)setToolInfo:(CLImageToolInfo *)toolInfo
{
    [super setToolInfo:toolInfo];
    
    self.title = self.toolInfo.title;
    if(self.toolInfo.iconImagePath){
        self.iconImage = self.toolInfo.iconImage;
    }
    else{
        self.iconImage = nil;
    }
}

- (void)setSelected:(BOOL)selected
{
    if(selected != _selected){
        _selected = selected;
        if(selected){
            self.backgroundColor = [CLImageEditorTheme toolbarSelectedButtonColor];
        }
        else{
            self.backgroundColor = [UIColor clearColor];
        }
    }
}

@end

