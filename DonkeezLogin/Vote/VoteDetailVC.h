//
//  VoteDetailVC.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"

@interface VoteDetailVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tblView;

@property(nonatomic, strong)Contest * curContest;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@end
