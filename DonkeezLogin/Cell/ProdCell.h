//
//  ProdCell.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProdCell : UITableViewCell

@property(nonatomic, strong)Contest * contest;

@property (weak, nonatomic) IBOutlet UIImageView *imgProd;
@property (weak, nonatomic) IBOutlet UILabel *lblProd;

@end
