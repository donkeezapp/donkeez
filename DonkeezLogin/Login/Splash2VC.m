//
//  Splash2VC.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/12/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "Splash2VC.h"

@interface Splash2VC ()

@end

@implementation Splash2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [_loadingInd startAnimating];
    
    NSString * userEmail = [GD ReadDefaultStoreforKey:@"useremail"];
    NSString * userPwd = [GD ReadDefaultStoreforKey:@"userpwd"];
    
    
    [backendless.userService
     login:userEmail
     password:userPwd
     response:^(BackendlessUser *user) {
         
         [GD onMain:^{
             
             kAppDelegate.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_main"];
             
         }];
         
         NSLog(@"%@", user);
     }
     error:^(Fault *fault) {
         NSLog(@"%@", fault.detail);
         [GD onMain:^{
//             [GD hideSV];
//             [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Failed to log in, Please try again.") VC:self Ok:nil];
             
          

             
             
             
         }];
     }];

    
}
-(void)viewDidAppear:(BOOL)animated{
//    [_loadingInd stopAnimating];
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
