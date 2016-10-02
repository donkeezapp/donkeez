

#import <UIKit/UIKit.h>
@protocol ZMUITextFieldSideViewDelegate;

@interface ZMUITextField :UITextField


@property(nonatomic,strong)UIColor *colorPlaceholder;

@property (weak,nonatomic)id<ZMUITextFieldSideViewDelegate> sidedelegate;

@end

@protocol ZMUITextFieldSideViewDelegate <NSObject>

-(void)onRightViewTap:(ZMUITextField *)textfield RightView:(UIView*)rightView;
-(void)onLeftViewTap:(ZMUITextField *)textfield RightView:(UIView*)leftView;

@end