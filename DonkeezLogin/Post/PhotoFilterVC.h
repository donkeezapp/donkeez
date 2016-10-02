//
//  PhotoFilterVC.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/13/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotoFilterVC : BaseViewController


@property (weak, nonatomic) IBOutlet UIView *viewPhoto;

@property(nonatomic, strong)UIImage * capImage;
@property (weak, nonatomic) IBOutlet UICollectionView *collFilter;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;


@property (weak, nonatomic) IBOutlet UILabel *lblTItle;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblFilter;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property(nonatomic, strong)Contest * curContest;

@property(nonatomic)ImagePickerSource ips;
@end
