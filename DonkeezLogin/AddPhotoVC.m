//
//  AddPhotoVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/24/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "AddPhotoVC.h"
#import "ProductsCell.h"
#import "ProdCell.h"
#import "PhotoTakeVC.h"
@interface AddPhotoVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * myPosts;
    NSInteger selRow;
    BOOL isChange;
}
@property(nonatomic, strong)NSMutableArray * curProducts;
@property(nonatomic, strong)UIRefreshControl * refreshControl;
@end

@implementation AddPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tblProducts.delegate = self;
    selRow  = -1;
    _tblProducts.dataSource = self;
    _curProducts = [NSMutableArray new];
    [_tblProducts registerNib:[UINib nibWithNibName:@"ProductsCell" bundle:nil] forCellReuseIdentifier:@"cell_prod"];
//
    [_tblProducts registerNib:[UINib nibWithNibName:@"ProdCell" bundle:nil] forCellReuseIdentifier:@"cell_prod_tapped"];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadCurContest)
                  forControlEvents:UIControlEventValueChanged];
    [_scrView addSubview:_refreshControl];

    
   
}
-(void)increasePostViews:(Post*)post{
    
    if(![post.post_user.userId isEqualToString:backendless.userService.currentUser.userId]){
        post.views = @(post.views.integerValue + 1);
        
        id<IDataStore> ds = [backendless.persistenceService of:[Post class]];
        NSLog(@"increase post views!!! post objectId : %@", post.objectId);
        [ds save:post response:^(id saved) {
            NSLog(@"succefully increased: %@", [((Post*)saved) views]);
        } error:^(Fault *fault) {
            
        }];

    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = NO;
    [super viewDidDisappear:animated];
}
-(void)localize{
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
}
-(void)initData{
     selRow  = -1;
       [_imgLogoContest setMHImageWithURL:[NSURL URLWithString:kAppDelegate.curUploadedContest.mark_image] withAnimationDuration:0.3];
    _lblContestTags.text = kAppDelegate.curUploadedContest.tags;
    
    _lblTimes.text = [GD getDuringofDate:kAppDelegate.curUploadedContest.end_date];
    
    myPosts = [NSMutableArray new];
    
    
    isChange = NO;
    
    if(_curPost){
        [self increasePostViews:_curPost];
        [_imgCurPost setMHImageWithURL:[NSURL URLWithString:[_curPost photo]]];
        [_btnNewPic setImage:[UIImage imageNamed:@"new_post_btn_1.png"] forState:UIControlStateNormal];
        isChange = YES;
         [myPosts addObject:_curPost];
        _btnDlePost.hidden = NO;
    }else{
        if(kAppDelegate.curUploadedContest.contest_posts.count > 0){
            
            for (Post * each in kAppDelegate.curUploadedContest.contest_posts) {
                
                if([each.post_user.userId isEqualToString:backendless.userService.currentUser.userId]){
                    [myPosts addObject:each];
                }
                
            }
            if(myPosts.count > 0){
                
                [self increasePostViews:[myPosts objectAtIndex:0]];
                [_imgCurPost setMHImageWithURL:[NSURL URLWithString:[[myPosts objectAtIndex:0] photo]]];
                [_btnNewPic setImage:[UIImage imageNamed:@"new_post_btn_1.png"] forState:UIControlStateNormal];
                isChange = YES;
                _btnDlePost.hidden = NO;
                
                
                
            }else{
                _btnDlePost.hidden = YES;
                
                [_imgCurPost setImage:[UIImage imageNamed:@"splash_1x1.png"]];

                
                
                [_btnNewPic setImage:[UIImage imageNamed:@"new_post_btn.png"] forState:UIControlStateNormal];
                
            }
            
            
        }else{
            _btnDlePost.hidden  = YES;
             [_imgCurPost setImage:[UIImage imageNamed:@"splash_1x1.png"]];

            
            [_btnNewPic setImage:[UIImage imageNamed:@"new_post_btn.png"] forState:UIControlStateNormal];
        }
        
        
    }
    
    
    if(isChange){
        _lblGreyDescription.text = kAppDelegate.curUploadedContest.desc;
        _lblGreyDescription.hidden = NO;
        _tvDescContest.text = MCLocalString(@"Change my pic");
        _tvDescContest.text = @"";
        _btnChangePic.hidden = NO;
        _tvDescContest.hidden = YES;
        [_btnChangePic setTitle:MCLocalString(@"Change my pic") forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isChangingPhoto"];
        
    }else{
        _btnChangePic.hidden = YES;
        _lblGreyDescription.hidden = YES;
        _tvDescContest.text = kAppDelegate.curUploadedContest.desc;
        _tvDescContest.hidden  = NO;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isChangingPhoto"];
    }
    [_tvDescContest setTextAlignment:NSTextAlignmentCenter];
    [_tvDescContest setFont:_btnChangePic.titleLabel.font];
    
    kAppDelegate.mVC.navigationController.navigationBarHidden = NO;
    //    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBarHidden = YES;
    
    [_btnNewPic makeCircled];
    [self.view bringSubviewToFront:_btnNewPic];
    

}
-(void)reloadCurContest{
    
    BackendlessDataQuery *query = [BackendlessDataQuery new];

    
    query.whereClause = [NSString stringWithFormat:@"objectId = \'%@\'",kAppDelegate.curUploadedContest.objectId ];
    
    QueryOptions *queryOptions = [QueryOptions new];
    queryOptions.relationsDepth = @(2);
    query.queryOptions = queryOptions;
    [backendless.persistenceService find:[Contest class] dataQuery:query response:^(BackendlessCollection * collection) {
        
        if(collection.data.count == 1){
            kAppDelegate.curUploadedContest = (Contest*)[collection.data objectAtIndex:0];
            [GD onMain:^{
                [self initData];
            }];
        }else if(collection.data.count > 1){
            [GD onMain:^{
                [GD ShowAlertViewTitle:@"Error_1" message:MCLocalString(@"Data is invalid, please try again.") VC:self Ok:nil];
            }];
        }else{
            [GD onMain:^{
                [GD ShowAlertViewTitle:@"Error_2" message:MCLocalString(@"Data is invalid, please try again.") VC:self Ok:nil];
            }];
        }
        
        [GD onMain:^{
           [_refreshControl endRefreshing]; 
        }];
    } error:^(Fault *fault) {
        [GD onMain:^{
            [GD ShowAlertViewTitle:@"Error_Network" message:MCLocalString(@"Data is invalid, please try again.") VC:self Ok:nil];
        }];
    }];
//    [backendless.persistenceService find:[Contest class] dataQuery:query response:^(BackendlessCollection * beCollection) {

    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [CYAnimation RotateClockWise:_btnDlePost andTime:0];
    [self initData];
    [self reloadCurContest];
}

- (IBAction)onChangePic:(id)sender {
    
    [self onNewPic:sender];
}


- (IBAction)onNewPic:(id)sender {
    PhotoTakeVC * pVC = [[PhotoTakeVC alloc] initWithNibName:@"PhotoTakeVC" bundle:nil];
    pVC.curContest =  kAppDelegate.curUploadedContest;
    
    [CYAnimation PushAnimationRight2left:self nav:self.navigationController target:pVC];
    
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)onShareNext:(id)sender {
    
    [[SocialPostManager sharedManager] inviteToFacebook];
    
//    NSURL * imgUrl =  [NSURL URLWithString:_curPost.photo];
//    if(!isSet(_curPost.photo)){
//        imgUrl = [NSURL URLWithString:_curContest.mark_image];
//    }
//      [[SocialPostManager sharedManager] GeneralShareText:kAppDelegate.curUploadedContest.desc andImage:_imgCurPost.image andUrl:[NSURL URLWithString:kAppDelegate.appStoreUrl] viewController:self imageUrl:imgUrl];
    
}


- (IBAction)onDeletePicture:(id)sender {
    
    if(myPosts.count >0 ){
        
        [GD ShowAlertYesNoTitle:@"" message:MCLocalString(@"Will you remove this post?") VC:self YESBlock:^{
            
            id<IDataStore> dataStore = [backendless.persistenceService of:[Post class]];
            NSLog(@"My Posts count : %ld", (unsigned long)myPosts.count);
            
            Post * myPost = [myPosts objectAtIndex:0];
            myPost.contest = kAppDelegate.curUploadedContest;
            NSArray * subStrList = [myPost.photo componentsSeparatedByString:@"/"];
            NSString * fileName = [subStrList objectAtIndex:subStrList.count -1];
            
            NSString * filePath = [NSString stringWithFormat:@"post/%@", fileName];

            [dataStore remove:myPost response:^(NSNumber * count) {
                
                [kAppDelegate.curUploadedContest removeFromContest_posts:myPost];
                
                if(subStrList.count > 1){
                    
                    [backendless.fileService remove:filePath response:^(id res) {
                    
                    } error:^(Fault * fault) {
                        NSLog(@"error remove : %@", filePath);
                    }];
                    
                }
                
                [GD onMain:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_RELOAD object:nil];
                    
                    [_btnNewPic setImage:[UIImage imageNamed:@"new_post_btn.png"] forState:UIControlStateNormal];
                    _btnChangePic.hidden = YES;
                    _tvDescContest.hidden  = NO;
                    _btnDlePost.hidden = YES;
                    [myPosts removeAllObjects];
                    _lblGreyDescription.hidden = YES;

                    [_imgCurPost setImage:[UIImage imageNamed:@"splash_1x1.png"]];
                    
                    _tvDescContest.text = kAppDelegate.curUploadedContest.desc;
                    [_tvDescContest setTextAlignment:NSTextAlignmentCenter];
                    [_tvDescContest setFont:_btnChangePic.titleLabel.font];

                  }];
                } error:^(Fault *error) {
                    [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Failed to remove, please try again.") VC:self Ok:nil];
                }];
            

        } cancelBlock:^{
            
        }];
        
    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.tblProducts respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tblProducts setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tblProducts respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tblProducts setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger cnt = selRow!=-1?1:0;
    NSInteger count =kAppDelegate.curUploadedContest.products.count + cnt;
    return count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(selRow != -1 && indexPath.row == selRow + 1){
        // prod image cell
        Products * prod= (Products*)[kAppDelegate.curUploadedContest.products objectAtIndex:selRow];
        ProdCell * cell = [_tblProducts dequeueReusableCellWithIdentifier:@"cell_prod_tapped"];
        cell.lblProd.hidden = YES;
        [cell.imgProd setMHImageWithURL:[NSURL URLWithString:prod.item_image]];
        
        return  cell;
    }else{
        
        // prod cell
        NSInteger idx = 0;
        if(selRow >= indexPath.row){
            idx = indexPath.row;
        }else if (selRow == -1){
            idx = indexPath.row;
        }
        else{
            idx = indexPath.row - 1;
        }
        
        Products * prod= (Products*)[kAppDelegate.curUploadedContest.products objectAtIndex:idx];
        
        ProductsCell * cell = [_tblProducts dequeueReusableCellWithIdentifier:@"cell_prod"];
        
        cell.lblTitlte.text = prod.item_name;
        [cell.btnPlus setTag:indexPath.row];
        
        [cell.btnPlus addTarget:self action:@selector(onTapPlus:) forControlEvents:UIControlEventTouchUpInside];
        cell.isVaild = YES;
        
        if(indexPath.row == selRow ){
            [cell SetOpened:YES];
        }else{
            [cell SetOpened:NO];
        }
        
        
        
        return  cell;

    }
    
    return  nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selRow != -1 && indexPath.row == selRow + 1){
        NSLog(@"cellHeight prod : row : %ld, 127", (long)indexPath.row);
        // prod image cell
         return 127;
    }
    else{
        NSLog(@"cellHeight gen : row : %ld, 45", (long)indexPath.row);
         return 45;
    }
//    return 45;
    
    
}


-(void)onTapPlus:(id)sender{
    
    UIView * view = (UIView*)sender;
    NSInteger tag = view.tag;
      NSInteger oldSelRow = selRow;
    if(selRow != -1){
        NSIndexPath * idp = [NSIndexPath indexPathForRow:selRow+1 inSection:0];
        
        selRow = -1;
      
        [_tblProducts beginUpdates];
        [_tblProducts deleteRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tblProducts endUpdates];
        
        if(oldSelRow == tag) return;
        
    }
    
    
    selRow = oldSelRow < tag && oldSelRow !=-1? tag - 1: tag;
     
    
    [_tblProducts beginUpdates];
    NSIndexPath * idp = [NSIndexPath indexPathForRow:selRow+1 inSection:0];
     [_tblProducts insertRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [_tblProducts reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tblProducts endUpdates];
    
    
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
