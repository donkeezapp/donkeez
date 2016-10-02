//
//  PPSendOptionViewController.m
//  SnapStream
//
//  Created by Admin on 11/9/15.
//  Copyright © 2015 Cyrusdev. All rights reserved.
//

#import "PPSendOptionViewController.h"

@interface PPSendOptionViewController ()

@end

@implementation PPSendOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *gr=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackTap)];
    [gr setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:gr];
    
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.5]];
    

    
    // Do any additional setup after loading the view from its nib.
}
-(void)onBackTap
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_viewOption.layer setCornerRadius:5];
    [_viewOption setClipsToBounds:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onDownPrivateBtn:(id)sender {
    
    [_lblPrivate setHighlighted:YES];
    [_lblPublic setHighlighted:NO];
    [_imgPrivate setHighlighted:YES];
    [_imgPublic setHighlighted:NO];
    
    
    
}
- (IBAction)onDownPublicBtn:(id)sender {
    [_lblPrivate setHighlighted:NO];
    [_lblPublic setHighlighted:YES];
    [_imgPrivate setHighlighted:NO];
    [_imgPublic setHighlighted:YES];
    
}
- (IBAction)onPublic:(id)sender {
    
//    if([self.delegate respondsToSelector:@selector(didSelectedSendOption:andOptionString:)]){
    
//        [self.delegate didSelectedSendOption:self andOptionString:@"public" ];
       [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOptionPublicOrPrivate object:nil userInfo:@{@"opt":@"public"}];
        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    
//    [self onBackTap];
    
}
- (IBAction)onPrivate:(id)sender {
 
    
//    if([self.delegate respondsToSelector:@selector(didSelectedSendOption:andOptionString:)]){
    
//        [self.delegate didSelectedSendOption:self andOptionString:@"private" ];
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOptionPublicOrPrivate object:nil userInfo:@{@"opt":@"private"}];
    
        [self dismissViewControllerAnimated:YES completion:nil];
    
//    }
//    [self onBackTap];
}

@end
