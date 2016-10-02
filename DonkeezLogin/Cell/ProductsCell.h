//
//  ProductsCell.h
//  Donkeez
//
//  Created by Zhang RenJun on 6/24/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitlte;

@property(nonatomic)CGFloat angle;
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;
@property(nonatomic)BOOL isVaild;

-(void)initPlusButton;
-(void)SetOpened:(BOOL)isSelected;
@end;
