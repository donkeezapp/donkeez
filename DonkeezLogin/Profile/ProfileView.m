
//
//  ProfileView.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/15/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "ProfileView.h"
#import "ProfileTimeCell.h"
#import "EditProfileVC.h"
#import "MyContestsVC.h"
#import "AddPhotoVC.h"
#import "MyContDetailVC.h"

@interface ProfileView ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger loadedCounter;
    BOOL isLoading;
    UserInfo * curUI;
}
@property(nonatomic, strong)BackendlessCollection * beCollection;
@property(nonatomic, strong)NSMutableArray <Contest*> * curData;
@property(nonatomic, strong)BackendlessCollection * beCollection_posting;
@property(nonatomic, strong)NSMutableArray <Contest*> * curData_posting;


@property(nonatomic, strong)NSMutableArray * posting_ContestList;
@property(nonatomic, strong)NSMutableArray * voting_ContestList;



@property(nonatomic, strong)UIRefreshControl * refreshControl;

@end

@implementation ProfileView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isLoading = NO;
    loadedCounter = 0;
    [_tblView registerNib:[UINib nibWithNibName:@"ProfileTimeCell" bundle:nil] forCellReuseIdentifier:@"cell_profile_time"];
    _tblView.delegate = self;
    
    _tblView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadAll)
                  forControlEvents:UIControlEventValueChanged];
    [_tblView addSubview:_refreshControl];
    _tblView.backgroundColor = [UIColor clearColor];
    [_btnLogout setTitle:MCLocalString(@"Logout") forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)localize{
    
    _lblConPa.text = MCLocalString(@"CONTEST PARTICIPATED");
    [_btnFaq setTitle:MCLocalString(@"FAQ") forState:UIControlStateNormal];
    [_btnCGU setTitle:MCLocalString(@"CGU") forState:UIControlStateNormal];
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    kAppDelegate.mVC.navigationController.navigationBarHidden = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        curUI = [kAppDelegate GetUserInfo:backendless.userService.currentUser];
        [GD onMain:^{
            NSString * avatar = [backendless.userService.currentUser getProperty:@"avatar"];
            
            if(!isSet(avatar)) avatar = curUI.avatar;
            
            if(isSet(avatar)){
                UIActivityIndicatorView * act = [GD activityViewToView:_imgAvatar];
                [_imgAvatar setMHImageWithURL:[NSURL URLWithString:avatar] completion:^(NSError *error, NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    [GD onMain:^{
                        [act stopAnimating];
                    }];
                }];
                
                
            }else{
                [_imgAvatar setImage:[UIImage imageNamed:@"dummy-avatar.png"]];                
            }
            UserInfo * ui = [kAppDelegate GetUserInfo:backendless.userService.currentUser];
            NSString *firstName = ui.first_name;
            NSString *lastName = ui.last_name;
            
            _lblName.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            
            [_imgAvatar setBorderForColor:[UIColor whiteColor] width:2. radius:_imgAvatar.bounds.size.height / 2.]; 
        }];
    });
    [self loadData:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
}

-(void)loadingCount{
    loadedCounter ++;
    if(loadedCounter == 2){
        
        isLoading = NO;
        loadedCounter= 0;
        [GD onMain:^{
            [GD hideSV];
            [_refreshControl endRefreshing];
            [_tblView reloadData];
        }];
        
    }
}

-(void)reloadAll{
    
    [self loadData:YES];
}

- (IBAction)onLogOut:(id)sender {
    
    [GD showSVHUDMask:YES];
    [backendless.userService logout:^(id obj) {
        [GD onMain:^{
            
            [GD hideSV];
            
            kAppDelegate.window.rootViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"nav_logo"];
            
        }];

    } error:^(Fault * fault) {
        [GD onMain:^{
            [GD hideSV];
            [GD ShowAlertViewTitle:@"" message:MCLocalString(@"Failed to logout.") VC:self Ok:nil];
            
        }];

    }];
    
    
}


- (IBAction)onBack:(id)sender {
    
//    [kAppDelegate.mVC.navigationController popViewControllerAnimated:YES];
    
    
    [CYAnimation PopAnimationLeft2Right:self nav:self.navigationController target:nil];
    
    
}

-(void)loadData:(BOOL)reload{
    [GD showSVHUD];
    if(isLoading)return;
    
    isLoading = YES;
    
    if(reload){
        loadedCounter = 0;
        NSDateFormatter * df = [NSDateFormatter new];
        [df setDateFormat:@"MM/dd/yyyy HH:mm:ss 'GMT'Z"];
        
        // voting data
 
        BackendlessDataQuery *query = [BackendlessDataQuery new];
 
//          query.whereClause = [NSString stringWithFormat:@"contest.vote_begin_date <= \'%@\' AND contest.vote_end_date > \'%@\' AND post_user.userId = \'%@\'", [df stringFromDate:[NSDate date]], [df stringFromDate:[NSDate date]], backendless.userService.currentUser.userId];
        
        
        query.whereClause = [NSString stringWithFormat:@"contest.vote_begin_date <= \'%@\' AND post_user.userId = \'%@\'", [df stringFromDate:[NSDate date]] , backendless.userService.currentUser.userId];
        
        //     query.whereClause = [NSString stringWithFormat:@" post_user.userId = \'%@\'",  backendless.userService.currentUser.userId];
        
        QueryOptions *queryOptions = [QueryOptions new];
        queryOptions.relationsDepth = @(4);
        queryOptions.sortBy = @[@"created DESC"];
        query.queryOptions = queryOptions;
        
        
        [backendless.persistenceService find:[Post class] dataQuery:query response:^(BackendlessCollection * beCollection) {
            _beCollection = beCollection;
            [_curData removeAllObjects];
            
            _curData = nil;
            _curData = [beCollection.data mutableCopy];
            
            _curData = [[_curData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                NSDate * date1 = ((Post*)obj1).contest.vote_end_date;
                NSDate * date2 = ((Post*)obj2).contest.vote_end_date;
              
                
                return [date1 compare:date2];
            }] mutableCopy];

            
            _voting_ContestList = [NSMutableArray new];
            id<IDataStore> ds = [backendless.persistenceService of:[Contest class]];
            for(int i = 0; i < _curData.count; i++){
                NSString * cont = [(Post*)[_curData objectAtIndex:i] contest].objectId;
                
                Contest * newCont = [ds findID:cont relationsDepth:2];
                [_voting_ContestList addObject:newCont];
                
            }
            
            
            [self loadingCount];
            
        } error:^(Fault * fault) {
            
            [self loadingCount];
        }];
        
        
        ///  Posting data
        
        BackendlessDataQuery *query_posting = [BackendlessDataQuery new];
        
        query_posting.whereClause = [NSString stringWithFormat:@"contest.begin_date <= \'%@\' AND contest.end_date > \'%@\' AND post_user.userId = \'%@\'  AND contest.vote_begin_date > \'%@\'",[df stringFromDate:[NSDate date]], [df stringFromDate:[NSDate date]] , backendless.userService.currentUser.userId, [df stringFromDate:[NSDate date]]];
        
        
        QueryOptions *queryOptions_posting = [QueryOptions new];
        queryOptions_posting.relationsDepth = @(4);
        queryOptions_posting.sortBy = @[@"created DESC"];
        query_posting.queryOptions = queryOptions_posting;
        
        
        [backendless.persistenceService find:[Post class] dataQuery:query_posting response:^(BackendlessCollection * beCollection) {
            _beCollection_posting = beCollection;
            [_curData_posting removeAllObjects];
            
            _curData_posting = nil;
            _curData_posting = [beCollection.data mutableCopy];
            
            
            _curData_posting = [[_curData_posting sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                NSDate * date1 = ((Post*)obj1).contest.end_date;
                NSDate * date2 = ((Post*)obj2).contest.end_date;
                
                
                return [date1 compare:date2];
            }] mutableCopy];
            
            
            _posting_ContestList = [NSMutableArray new];
            id<IDataStore> ds = [backendless.persistenceService of:[Contest class]];
            for(int i = 0; i < _curData_posting.count; i++){
                NSString * cont = [(Post*)[_curData_posting objectAtIndex:i] contest].objectId;
                
                Contest * newCont = [ds findID:cont relationsDepth:2];
                [_posting_ContestList addObject:newCont];
                
            }

            
            [self loadingCount];
        } error:^(Fault * fault) {
            
            [self loadingCount];
        }];
        
        
        
    }else{
        if(_beCollection){
            
            [_beCollection nextPageAsync:^(BackendlessCollection * becoll) {
                
                [_curData addObjectsFromArray:becoll.data];
                _beCollection = nil;
                _beCollection = becoll;
                
                
                _curData = [[_curData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    
                    NSDate * date1 = ((Post*)obj1).contest.vote_end_date;
                    NSDate * date2 = ((Post*)obj2).contest.vote_end_date;
                    
                    
                    return [date1 compare:date2];
                }] mutableCopy];
                
              
                _voting_ContestList = [NSMutableArray new];
                id<IDataStore> ds = [backendless.persistenceService of:[Contest class]];
                for(int i = 0; i < _curData.count; i++){
                    NSString * cont = [(Post*)[_curData objectAtIndex:i] contest].objectId;
                    
                    Contest * newCont = [ds findID:cont relationsDepth:2];
                    [_voting_ContestList addObject:newCont];
                    
                }
                
                [self loadingCount];
                
            } error:^(Fault *fault) {
                [self loadingCount];            }];
            
        }else{
            [self loadingCount];
        }
        
        if(_beCollection_posting){
            
            [_beCollection_posting nextPageAsync:^(BackendlessCollection * becoll) {
                
                [_curData_posting addObjectsFromArray:becoll.data];
                _beCollection_posting = nil;
                _beCollection_posting = becoll;
                
                _curData_posting = [[_curData_posting sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    
                    NSDate * date1 = ((Post*)obj1).contest.end_date;
                    NSDate * date2 = ((Post*)obj2).contest.end_date;
                    
                    
                    return [date1 compare:date2];
                }] mutableCopy];
                
                _posting_ContestList = [NSMutableArray new];
                id<IDataStore> ds = [backendless.persistenceService of:[Contest class]];
                for(int i = 0; i < _curData_posting.count; i++){
                    NSString * cont = [(Post*)[_curData_posting objectAtIndex:i] contest].objectId;
                    
                    Contest * newCont = [ds findID:cont relationsDepth:2];
                    [_posting_ContestList addObject:newCont];
                    
                }

                
                [self loadingCount];
                
            } error:^(Fault *fault) {
                [self loadingCount];
            }];
            
        }else{
            [self loadingCount];
        }
        
    }
    
    
}


#pragma mark tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0) {
        return _curData_posting.count;
    }else{
        return _curData.count;
    }
    return 0;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Post * post;
    ProfileTimeCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_profile_time"];
    
    if(indexPath.section == 0){
        post = (Post*)[_curData_posting objectAtIndex:indexPath.row];
        cell.curContest = [_posting_ContestList objectAtIndex:indexPath.row];
        [cell setCurPostData:post isVote:NO];
        
        if(indexPath.row != _curData_posting.count - 1){
            cell.imgSepLine.hidden = NO;
        }else{
             cell.imgSepLine.hidden = YES;
        }
        return  cell;
    }else{
        post = (Post*)[_curData objectAtIndex:indexPath.row];
        cell.curContest = [_voting_ContestList objectAtIndex:indexPath.row];
         [cell setCurPostData:post isVote:YES];
        
        if(indexPath.row != _curData.count - 1){
            cell.imgSepLine.hidden = NO;
            

            
        }else{
            cell.imgSepLine.hidden = YES;
        }
        
        return  cell;
        
    }
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    Post * post;
    
    if(indexPath.section == 0){
        
        
        post = (Post*)[_curData_posting objectAtIndex:indexPath.row];
        
        kAppDelegate.curUploadedContest = [_posting_ContestList objectAtIndex:indexPath.row];
       
        [GD onMain:^{
            [GD hideSV];
            
            AddPhotoVC * aVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"AddPhotoVC"];
            aVC.curContest = post.contest;
            aVC.curPost = post;
            
            [CYAnimation PushAnimationRight2left:self nav:self.navigationController target:aVC];
            
        }];

        
        
    }else{
        post = (Post*)[_curData objectAtIndex:indexPath.row];
         kAppDelegate.curUploadedContest =[_voting_ContestList objectAtIndex:indexPath.row];
        MyContDetailVC * mVC = [[MyContDetailVC alloc] initWithNibName:@"MyContDetailVC" bundle:nil];
        mVC.curPost = post;
        mVC.curContest = [_voting_ContestList objectAtIndex:indexPath.row];
        NSLog(@"ContestID : %@, count : %@", post.contest.objectId,[[ post.contest.contest_posts objectAtIndex:0] post_user].objectId);
        
        [CYAnimation PushAnimationRight2left:self nav:self.navigationController target:mVC];
        
        
        
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  45;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if(section == 0) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [GD GetScreenSize].width, 45)];
        [view setBackgroundColor:[Color_Grey colorWithAlphaComponent:0.1250]];
        
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, [GD GetScreenSize].width, 25)];
//        [title setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15.]];
        [title setFont:[UIFont fontWithName:@"Arial Hebrew" size:13.]];
        [title setTextColor:[UIColor whiteColor]];
        title.text = MCLocalString(@"POSTING TIME");
        title.textAlignment = NSTextAlignmentLeft;
        [view addSubview:title];
        
        
        return view;
    }else{
        
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [GD GetScreenSize].width, 45)];
        [view setBackgroundColor:[Color_Grey colorWithAlphaComponent:0.1250]];
        
         UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, [GD GetScreenSize].width, 25)];
//        [title setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15.]];
        [title setFont:[UIFont fontWithName:@"Arial Hebrew" size:13.]];
        [title setTextColor:[UIColor whiteColor]];
        title.text = MCLocalString(@"VOTING TIME");
        title.textAlignment = NSTextAlignmentLeft;
        [view addSubview:title];
        
        return view;
        
    }
    
}

- (IBAction)onSetting:(id)sender {
    
    
    EditProfileVC * eVC = [[EditProfileVC alloc ] initWithNibName:@"EditProfileVC" bundle:nil];
    
    
    [CYAnimation PushAnimationLeft2Right:self nav:self.navigationController target:eVC];
    
    
    
}

- (IBAction)onFaw:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://donkeez.com/faq/"];
    [[UIApplication sharedApplication] openURL:url];
    
}
- (IBAction)onCGU:(id)sender {
    

    NSURL *url = [NSURL URLWithString:@"http://donkeez.com/terms/"];
    [[UIApplication sharedApplication] openURL:url];

}

@end
