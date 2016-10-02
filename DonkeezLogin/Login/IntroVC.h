//
//  IntroVC.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/17/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "BaseViewController.h"

@interface IntroVC : BaseViewController

@property (weak, nonatomic) IBOutlet UIPageControl *pgCont;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextView *txtPost;
@property (weak, nonatomic) IBOutlet UITextView *txtVote;
@property (weak, nonatomic) IBOutlet UITextView *txtWin;

@end
