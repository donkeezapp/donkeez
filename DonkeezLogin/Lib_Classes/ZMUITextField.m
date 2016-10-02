
#import "ZMUITextField.h"
#import "objc/runtime.h"



@implementation ZMUITextField



- (void)drawPlaceholderInRect:(CGRect)rect {
    //    UIColor *colour = [UIColor lightGrayColor];
    UIColor *colour = self.colorPlaceholder;
    if(!colour){
        colour = [UIColor lightGrayColor];
    }
    if ([self.placeholder respondsToSelector:@selector(drawInRect:withAttributes:)])
    { // iOS7 and later
        NSDictionary *attributes = @{NSForegroundColorAttributeName: colour, NSFontAttributeName: self.font};
        CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
        [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes]; }
    else { // iOS 6
        [colour setFill];
        
        
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        textStyle.alignment = self.textAlignment;
        UIFont *textFont = self.font;
        //
        //        NSString *text = @"Lorem ipsum";
        
        // iOS 7 way
        [self.placeholder drawInRect:rect withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle}];
        
        //        [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByTruncatingTail alignment:self.textAlignment];
        
        
        
    }
}

-(CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGRect rect = [super rightViewRectForBounds:bounds];
    rect.origin.x -= 5;
    
    if([self rightView]){
        UITapGestureRecognizer *rt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onRightView)];
        rt.numberOfTapsRequired = 1;
        [self.rightView addGestureRecognizer:rt];
    }
    
    return  rect;
}
-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect rect = [super rightViewRectForBounds:bounds];
    rect.origin.x += 5;
    if([self leftView]){
        UITapGestureRecognizer *lt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onLeftView)];
        lt.numberOfTapsRequired = 1;
        [self.rightView addGestureRecognizer:lt];
    }
    return  rect;
    
}
-(void)onRightView{
    if([self sidedelegate]){
        [_sidedelegate onRightViewTap:self RightView:[self rightView]];
    }
}
-(void)onLeftView{
    if([self sidedelegate]){
        [_sidedelegate onLeftViewTap:self RightView:self.rightView];
    }
}
//-(void)drawPlaceholderInRect:(CGRect)rect
//{
//    if ([self.attributedPlaceholder length])
//    {
//        // Extract attributes
//        NSDictionary * attributes = (NSMutableDictionary *)[ (NSAttributedString *)self.attributedPlaceholder attributesAtIndex:0 effectiveRange:NULL];
//
//        NSMutableDictionary * newAttributes = [[NSMutableDictionary alloc] initWithDictionary:attributes];
//
//        if(!self.colorPlaceholder)
//            self.colorPlaceholder=[UIColor lightGrayColor];
//        [newAttributes setObject:self.colorPlaceholder forKey:NSForegroundColorAttributeName];
//
//        // Set new text with extracted attributes
//        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.attributedPlaceholder string] attributes:newAttributes];
//        
//    }
//}
@end