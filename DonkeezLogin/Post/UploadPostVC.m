//
//  UploadPostVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/13/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "UploadPostVC.h"
#import "AddPhotoVC.h"
@interface UploadPostVC ()

@end

@implementation UploadPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_imgPost setImage:_imgPosted];
    
    _lblTag.text = _curContest.tags;
    [_imgLogo setMHImageWithURL:[NSURL URLWithString:_curContest.mark_image]];
    
    _lblDesc.text = _curContest.desc;
    
    [_btnPost setBorderForColor:Color_Slider width:1. radius:10.];
    
}
-(void)localize{
    
    _lblTitle.text = MCLocalString(@"Upload");
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
    [_btnPost setTitle:MCLocalString(@"Post") forState:UIControlStateNormal];
    
}
- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)fileUpload:(Post*)newPost {
    
    NSData * data = UIImageJPEGRepresentation(_imgPosted, 1.0);
    
    [GD showSVHUDMask:YES];
    
    NSString * filePath = [NSString stringWithFormat:@"post/%0.0f.jpeg", [[NSDate date] timeIntervalSince1970] ];
    [backendless.fileService upload:filePath content:data overwrite:YES response:^(BackendlessFile * file) {
        [GD onMain:^{
            Post * updatePost = newPost;
            
            BOOL isNewPost = YES;
            if(!newPost){
                
                updatePost = [Post new];
                updatePost.is_valid = @(NO);
                updatePost.is_win = @(NO);
                
                updatePost.post_user = backendless.userService.currentUser;
                updatePost.likes = @0;
                updatePost.posting_time = [NSDate date];
            }else{
                updatePost.objectId = newPost.objectId;
                isNewPost = NO;
                updatePost.posting_time = [NSDate date];
                
            }
            updatePost.contest = kAppDelegate.curUploadedContest?kAppDelegate.curUploadedContest: _curContest;
            updatePost.photo = file.fileURL;
           
            NSLog(@"contest objectId : %@", updatePost.contest.objectId);
            
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isChangingPhoto"]) {
                id<IDataStore> dataStore = [backendless.persistenceService of:[Post class]];
                for (Post *post in updatePost.contest.contest_posts) {
                    post.contest = kAppDelegate.curUploadedContest?kAppDelegate.curUploadedContest: _curContest;
                }
                [dataStore save:updatePost response:^(id savedPost) {
                    [GD hideSV];
                    NSArray *array = [self.navigationController viewControllers];
                    
                    AddPhotoVC * apVC = (AddPhotoVC*)[array objectAtIndex:1];
                    
                    if(![apVC isKindOfClass:[AddPhotoVC class]]){
                        
                        apVC = (AddPhotoVC*)[array objectAtIndex:2];
                    }
                    apVC.imgCurPost.image = _imgPost.image;
                    apVC.curPost = savedPost;
                    
                    [CYAnimation PopAnimationFlip:self nav:self.navigationController target:apVC];
                    
                    [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Successfully uploaded") VC:apVC Ok:nil];
                
                    
                } error:^(Fault *fault) {
                    
                    [GD hideSV];
                    
                    [GD ShowAlertViewTitle:@"" message:@"Failed to upload. try again after a breast." VC:self Ok:nil];
                    
                }];
            } else {
                id<IDataStore> dataStore1 = [backendless.persistenceService of:[Contest class]];
                Fault * fault1;
                
                if(![kAppDelegate.curUploadedContest isContainUsersPost:backendless.userService.currentUser]){
                    [kAppDelegate.curUploadedContest addToContest_posts:updatePost];
                    for (Post *post in kAppDelegate.curUploadedContest.contest_posts) {
                        post.contest = kAppDelegate.curUploadedContest;
                    }
                    NSLog(@"test phonex %@",kAppDelegate.curUploadedContest);
                    [dataStore1 save:kAppDelegate.curUploadedContest fault:&fault1];
                    if(fault1){
                        
                        
                        [GD ShowAlertViewTitle:@"" message:@"Failed to update contest. try again after a breast." VC:self Ok:nil];
                    }
                    
                }
                
                [GD hideSV];
                NSArray *array = [self.navigationController viewControllers];
                
                AddPhotoVC * apVC = (AddPhotoVC*)[array objectAtIndex:1];
                
                if(![apVC isKindOfClass:[AddPhotoVC class]]){
                    
                    apVC = (AddPhotoVC*)[array objectAtIndex:2];
                }
                apVC.imgCurPost.image = _imgPost.image;
                apVC.curPost = updatePost;
                
                [CYAnimation PopAnimationFlip:self nav:self.navigationController target:apVC];
                
                [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Successfully uploaded") VC:apVC Ok:nil];
            }
            
        }];
    } error:^(Fault * fault) {
        [GD onMain:^{
            [GD hideSV];
            [GD ShowAlertViewTitle:@"" message:@"Failed to upload. try again after a breast." VC:self Ok:nil];
            
        }];
    }];
    

}
- (IBAction)onPost:(id)sender {
//
    
    
    Post * newPost = [kAppDelegate.curUploadedContest isContainUsersPost:backendless.userService.currentUser];
    
    NSArray * subStrList = [newPost.photo componentsSeparatedByString:@"/"];
    NSString * fileName = [subStrList objectAtIndex:subStrList.count -1];
    
    NSString * filePath = [NSString stringWithFormat:@"post/%@", fileName];
    
    if(newPost!= nil){
        
        [backendless.fileService remove:filePath response:^(id res) {
            [self fileUpload:newPost];
        } error:^(Fault * fault) {
             NSLog(@"error remove : %@", filePath);
            [self fileUpload:newPost];
        }];
        

        
    }else{
        [self fileUpload:nil];
    }
    //    [backendless.fileService saveFile:filePath content:data overwriteIfExist:YES response:^(BackendlessFile * file) {
//        
//    } error:^(Fault *fault) {
//       
//
//    }];
//    

    
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
