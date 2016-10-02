//
//  ProductsCell.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/24/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "ProductsCell.h"

@implementation ProductsCell

- (void)awakeFromNib {
    [super awakeFromNib];
     _angle = M_PI * 0.25;
    // Initialization code
    [self initPlusButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
    // Configure the view for the selected state
}
-(void)SetOpened:(BOOL)isSelected{
    if(isSelected){
        [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle:M_PI * 0.25];
        _angle =0;
        
    }else{
        [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle:0];
        _angle =  M_PI * 0.25;
    }
}
-(void)initPlusButton{
    [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle:0];
    _angle = M_PI * 0.25;
    
}
- (IBAction)onPlus:(id)sender {
    if(_isVaild){
        [CYAnimation RotateClockWise:_btnPlus andTime:0.3 angle:_angle];
        _angle = _angle > 0 ? 0:M_PI * 0.25;
    }
 

    
}

@end
