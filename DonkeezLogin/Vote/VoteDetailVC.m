

#import "VoteDetailVC.h"
#import "ProfileCell.h"
#import "PostCell.h"
#import "VoteCell.h"
#import "NSMutableArray+Shuffling.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
@interface VoteDetailVC ()<UITableViewDelegate, UITableViewDataSource, PostCellDelegate, ProfileCellDelegate, FBSDKAppInviteDialogDelegate>


@property(nonatomic, strong)BackendlessCollection * beCollection;
@property(nonatomic, strong)NSMutableArray <Contest*> * curData;

@property(nonatomic, strong)UIRefreshControl * refreshControl;

@property(nonatomic, strong)NSMutableArray * userInfoList;

 @property(nonatomic)NSInteger tappedRow;

 @end

@implementation VoteDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tblView registerNib:[UINib nibWithNibName:@"VoteCell" bundle:nil] forCellReuseIdentifier:@"cell_vote_contest"];
    [_tblView registerNib:[UINib nibWithNibName:@"PostCell" bundle:nil] forCellReuseIdentifier:@"cell_post_vote"];
    [_tblView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:@"cell_profile_cell"];
    [_curContest.contest_posts shuffle];

    _tappedRow = -1;
    
    kAppDelegate.mVC.navigationController.navigationBarHidden = YES;
    
    [self loadDataUserInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    
}
-(void)localize{
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
}
-(void)loadDataUserInfo{
    

    
    [GD showSVHUD];
    _userInfoList = [NSMutableArray new];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        

        for(int i = 0; i< _curContest.contest_posts.count ; i++){
            
            BackendlessUser * user = [(Post*)[_curContest.contest_posts objectAtIndex:i] post_user];
            

            if(user){
                BackendlessDataQuery *query = [BackendlessDataQuery new];
                
                query.whereClause = [NSString stringWithFormat:@"user_id = \'%@\'", user.userId ];
                NSLog(@"whereClausre : %@", query.whereClause );
                QueryOptions *queryOptions = [QueryOptions new];
                
                query.queryOptions = queryOptions;
                id<IDataStore> dsUI = [backendless.persistenceService of:[UserInfo class]];
                
                
                BackendlessCollection * coll = [dsUI find:query];
                if(coll.data.count > 0)
                {
                    UserInfo * ui = [coll.data objectAtIndex:0];
                    NSLog(@"userinfo firstname %@", ui.first_name);
                    [_userInfoList addObject: ui];
                }else{
                    NSLog(@"userinfo firstname %@", user.name);
                    [_userInfoList addObject:user];
                }

            }else{
                [_userInfoList addObject:@""];
            }
            
            
            
            
        }

        
        [GD onMain:^{
            [GD hideSV];
            _tblView.delegate = self;
            
            _tblView.dataSource = self;
            [_tblView reloadData];
        }];
        
    });
    
    
    
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
    if ([self.tblView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tblView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tblView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tblView setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_tappedRow > -1){
       
        
        return 2 + _curContest.contest_posts.count;
    }
    NSInteger count = _curContest.contest_posts.count;
    NSLog(@"count : %ld", count);
    NSInteger tapped = _tappedRow == -1?0:1;
    return 1 + count + tapped;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if(indexPath.row == 0){
        
        VoteCell  * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_vote_contest"];
        
        
        [cell setVoteDetailImage:_curContest.mark_image];
        
        cell.lblTitleContest.text = _curContest.tags;
        cell.tvDesc.text = _curContest.title;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if(indexPath.row == _tappedRow + 1 && _tappedRow != -1){
       
        ProfileCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_profile_cell"];
        
        Post * post = [_curContest.contest_posts objectAtIndex:_tappedRow -1];
        
        NSLog(@"post User OIbjectID : %@",post.post_user.objectId);

        
        
        id ui = [_userInfoList objectAtIndex:_tappedRow -1];
        
        
        if([ui isKindOfClass: [UserInfo class]]){
            [cell setProfileUserInfo:ui];
        }else if([ui isKindOfClass: [BackendlessUser class]]){
            [cell setProfileUser:ui];
        }
        
        cell.delegate = self;
        return  cell;
    }else{
        
        NSInteger row = indexPath.row - 1;
        if(_tappedRow > -1 &&  _tappedRow < row){
            
            row --;
        }
        
        Post * post = [_curContest.contest_posts objectAtIndex:row ];
        
        PostCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_post_vote"];
        [cell setCellPost:post];
        cell.delegate = self;
        cell.parentVC = self;
        return  cell;
    }

    
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.row == 0){
        
         return  134;
    }else if(indexPath.row == _tappedRow + 1){
         return  80;
    }else{
         return  [GD GetScreenSize].width;
    }
    
    return  127;
    
    
}
-(void)onTappedLike:(PostCell *)cell post:(Post*)post{
    
    
    [post LikewithLikeableUser:backendless.userService.currentUser success:^{
        
       
        // post updating
        
        
        id<IDataStore> dataStorePost = [backendless.persistenceService of:[Post class]];

        
        post.contest = _curContest;
        for (Post *childPost in post.contest.contest_posts) {
            childPost.contest = post.contest;
        }
        post.likes = [NSNumber numberWithInteger: post.likes.integerValue + 1];
        NSLog(@"contest : %@, found post's contest id : %@", post.contest.objectId, @"");

        
        @try{
            [dataStorePost save:post];

        }@catch(Fault * fault){
            [GD onMain:^{
                [GD ShowAlertViewTitle:@"" message: MCLocalString(@"Failed to like , try again after a moment.") VC:self Ok:nil];
                                                                 
            }];
        }
        
        
    } failed:^(NSString *error, NSInteger errorCode) {
        [GD onMain:^{
            
            [GD onMain:^{
               cell.countOfLikes --;
                cell.lblLikes.text = [NSString stringWithFormat:@"%ld", (long)cell.countOfLikes];
            }];
            
            [GD ShowAlertViewTitle:@"" message:error VC:self Ok:nil];
         
        }];
        
    }];
    
    
}
-(void)onTappedPlus:(PostCell *)cell post:(Post*)post{
    
    NSInteger newTappedRow = [(NSIndexPath*)[_tblView indexPathForCell:cell] row];
    
    if(_tappedRow != -1){
        NSIndexPath * removeIdp = [NSIndexPath indexPathForRow:_tappedRow + 1  inSection:0];
        
        NSLog(@"_tappedRow %ld, newTappedRow : %ld", _tappedRow, newTappedRow);

        NSInteger oldTappedRow = _tappedRow;
        
        if(oldTappedRow!=newTappedRow){
            
            if(oldTappedRow < newTappedRow){
                PostCell * oldCell = [_tblView cellForRowAtIndexPath:[NSIndexPath  indexPathForRow:oldTappedRow inSection:0]];
                        [oldCell initPlusButton];
            }else{
                PostCell * oldCell = [_tblView cellForRowAtIndexPath:[NSIndexPath  indexPathForRow:oldTappedRow inSection:0]];
                [oldCell initPlusButton];            }
        }
        
        _tappedRow = -1;
        [_tblView beginUpdates];
        
        [_tblView deleteRowsAtIndexPaths:@[removeIdp] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [_tblView endUpdates];
        
        if(newTappedRow == oldTappedRow ) return;
        
        if(newTappedRow < oldTappedRow) _tappedRow = newTappedRow;
        if(newTappedRow > oldTappedRow) _tappedRow = newTappedRow-1;
    }
    
    
    
    if(_tappedRow == -1){
        _tappedRow = newTappedRow;
    }
    NSIndexPath * newIdp = [NSIndexPath indexPathForRow:_tappedRow + 1 inSection:0];
        [_tblView beginUpdates];
        [_tblView insertRowsAtIndexPaths:@[newIdp] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tblView endUpdates];

    
}

-(void)onTappedShare:(ProfileCell *)cell user:(BackendlessUser *)user{
    
//    NSIndexPath * idp = [_tblView indexPathForCell:cell];
//    NSIndexPath * postIdp = [NSIndexPath indexPathForRow:idp.row-1 inSection:0];
//    
//    
//    PostCell  * postCell = (PostCell*)[_tblView cellForRowAtIndexPath:postIdp];
//    NSURL * imgUrl = [NSURL URLWithString:postCell.post.photo];
//    
//    [[SocialPostManager sharedManager] GeneralShareText:_curContest.desc andImage:postCell.imgBack.image andUrl:[NSURL URLWithString:kAppDelegate.appStoreUrl] viewController:self imageUrl:imgUrl];
    
    
    
    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
    content.appLinkURL = [NSURL URLWithString:@"https://itunes.apple.com/fr/app/donkeez/id1148625354?l=en&mt=8"];
    //optionally set previewImageURL
    content.appInvitePreviewImageURL = [NSURL URLWithString:@"http://donkeez.com/wp-content/uploads/2016/06/logo-donkeez-catch-phraseEN.png"];
    
    // Present the dialog. Assumes self is a view controller
    // which implements the protocol `FBSDKAppInviteDialogDelegate`.
    [FBSDKAppInviteDialog showFromViewController:self
                                     withContent:content
                                        delegate:self];
}


- (IBAction)onShare:(id)sender {
    
//    VoteCell  * cell = (VoteCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    NSURL * imgUrl = [NSURL URLWithString:_curContest.mark_image];
//        [[SocialPostManager sharedManager] GeneralShareText:_curContest.desc andImage:cell.imgBack.image andUrl:[NSURL URLWithString:kAppDelegate.appStoreUrl] viewController:self imageUrl:imgUrl];
    
    
    
    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
    content.appLinkURL = [NSURL URLWithString:@"https://itunes.apple.com/fr/app/donkeez/id1148625354?l=en&mt=8"];
    //optionally set previewImageURL
    content.appInvitePreviewImageURL = [NSURL URLWithString:@"http://donkeez.com/wp-content/uploads/2016/06/logo-donkeez-catch-phraseEN.png"];
    
    // Present the dialog. Assumes self is a view controller
    // which implements the protocol `FBSDKAppInviteDialogDelegate`.
    [FBSDKAppInviteDialog showFromViewController:self
                                     withContent:content
                                        delegate:self];
    
    
}


- (IBAction)onBack:(id)sender {
    
    [kAppDelegate.mVC.navigationController popViewControllerAnimated:YES];
    
    
}





#pragma mark - FBSDKAppInviteDialogDelegate

- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results
{
    
}


- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error
{
    
}


@end
