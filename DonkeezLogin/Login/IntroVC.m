//
//  IntroVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/17/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "IntroVC.h"

@interface IntroVC ()<UIScrollViewDelegate>
{
    NSInteger curPage;
    
}
@end

@implementation IntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    curPage = 0;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    
    [_btnLogin setHidden:YES];
    [_btnLogin setBorderForColor:Color_Slider width:1. radius:10.];
    
    
//    [_scrollView setScrollEnabled:NO];
    _scrollView.delegate = self;
//    UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapScrollView)];
//    gr.numberOfTapsRequired = 1;
//    gr.numberOfTouchesRequired = 1;
//    UISwipeGestureRecognizer * sgr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onTapScrollView)];
//    [_scrollView addGestureRecognizer:gr];
    
}
-(void)localize{
    _txtPost.text = MCLocalString(@"Select your photo contest, and post a picture");
    _txtVote.text = MCLocalString(@"Vote for the best pictures");
    _txtWin.text = MCLocalString(@"Get the most votes to win rewards, and reach the wall of fame!");
    
    [_txtPost setFont:[UIFont fontWithName:@"Avenir Medium" size:13]];
    [_txtPost setTextAlignment:NSTextAlignmentCenter];
    
    [_txtVote setFont:[UIFont fontWithName:@"Avenir Medium" size:13]];
    [_txtVote setTextAlignment:NSTextAlignmentCenter];
    [_txtWin setFont:[UIFont fontWithName:@"Avenir Medium" size:13]];
    [_txtWin setTextAlignment:NSTextAlignmentCenter];
    
    [_btnLogin setTitle:MCLocalString(@"Login") forState:UIControlStateNormal];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView.contentOffset.x >= 2 * [GD GetScreenSize].width - 10){
        
        _pgCont.hidden = YES;
          _btnLogin.hidden  = NO;
        _pgCont.currentPage = 2;
    }else{
        _pgCont.hidden = NO;
        _btnLogin.hidden  = YES;
        if(scrollView.contentOffset.x >=  [GD GetScreenSize].width - 10){
            
             _pgCont.currentPage = 1;
        }else{
              _pgCont.currentPage = 0;
        }
    }
    
    
}
-(void)onTapScrollView{
    
    curPage ++;
    if(curPage >= 2){
        curPage = 2;
        _btnLogin.hidden  = NO;
        _pgCont.hidden = YES;
        
    }else{
        
    }
    
    
    CGRect rect = CGRectMake(curPage * [GD GetScreenSize].width, 0, [GD GetScreenSize].width, [GD GetScreenSize].height);
    
    [_scrollView scrollRectToVisible:rect animated:YES];
    
    _pgCont.currentPage = curPage;
    [GD WriteDefaultStore:@(1) forKey:@"isPassedIntro"];
    
    
}
- (IBAction)onPageChanged:(id)sender {
    
        
}

- (IBAction)onLog:(id)sender {
    
    
    [UIView transitionWithView:kAppDelegate.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{kAppDelegate.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_logo"]; }
                    completion:nil];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
