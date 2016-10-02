

#import "PPPhotoAnnotationView.h"
#import "UIView+BorderSet.h"
@interface PPPhotoAnnotationView ()
@property (nonatomic,assign) UILabel* countLabel;
@end
@implementation PPPhotoAnnotationView
-(void) setImage:(UIImage *)image{
    [super setImage:image];
    [self updateLabel];
}
-(void) setCount:(NSInteger)count{
    _count = count;
    [self updateLabel];
}
-(void) updateLabel{
    if (_countLabel){
        [_countLabel removeFromSuperview];
        _countLabel=nil;
    }
    if (_count>1){
        UILabel* countLabel = [[UILabel alloc] init];
        countLabel.font = [UIFont systemFontOfSize:10];
        countLabel.textAlignment= NSTextAlignmentCenter;
        countLabel.textColor = [UIColor whiteColor];
        countLabel.backgroundColor = [UIColor redColor];
        countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long) _count];
        
        self.countLabel = countLabel;
        [self addSubview:countLabel];
        
        [countLabel sizeToFit];
        CGRect frame = countLabel.frame;
        frame.size.width+=5;
        frame.size.height+=2;
        countLabel.frame = frame;
        if (frame.size.width<frame.size.height) frame.size.width = frame.size.height;
        countLabel.frame = frame;
        [countLabel setBorderForColor:[UIColor clearColor] width:0 radius:CGRectGetHeight(countLabel.frame)*.5];
        countLabel.center = CGPointMake(CGRectGetWidth(self.frame)*1., CGRectGetHeight(self.frame)*.0);
    }
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
}
@end
