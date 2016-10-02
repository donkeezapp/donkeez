
//
//  MyContestsVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "MyContestsVC.h"
#import "MyContestsCell.h"
#import "AddPhotoVC.h"
#import "MyContDetailVC.h"
@interface MyContestsVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger loadedCounter;
    BOOL isLoading;
}
@property(nonatomic, strong)BackendlessCollection * beCollection;
@property(nonatomic, strong)NSMutableArray <Contest*> * curData;
@property(nonatomic, strong)BackendlessCollection * beCollection_posting;
@property(nonatomic, strong)NSMutableArray <Contest*> * curData_posting;

@property(nonatomic, strong)UIRefreshControl * refreshControl;



@end

@implementation MyContestsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoading = NO;
    loadedCounter = 0;
    [_tblView registerNib:[UINib nibWithNibName:@"MyContestsCell" bundle:nil] forCellReuseIdentifier:@"cell_MyContestsCell"];
    _tblView.delegate = self;
    
    _tblView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadAll)
                  forControlEvents:UIControlEventValueChanged];
    [_tblView addSubview:_refreshControl];
    _tblView.backgroundColor = Color_Lighter_Grey;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    kAppDelegate.mVC.navigationController.navigationBarHidden = YES;
    
    [self loadData:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    kAppDelegate.mVC.navigationController.navigationBarHidden = NO;
    
}
-(void)localize{
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
    
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

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)loadData:(BOOL)reload{
    [GD showSVHUD];
    if(isLoading)return;
    
    isLoading = YES;
    
    if(reload){
        loadedCounter = 0;
        NSDateFormatter * df = [NSDateFormatter new];
        [df setDateFormat:@"MM/dd/yyyy HH:mm:ss 'GMT'Z"];
        
        
        BackendlessDataQuery *query = [BackendlessDataQuery new];
//     
//        
//        query.whereClause = [NSString stringWithFormat:@"contest.vote_begin_date <= \'%@\' AND contest.vote_end_date > \'%@\' AND post_user.userId = \'%@\'", [df stringFromDate:[NSDate date]], [df stringFromDate:[NSDate date]], backendless.userService.currentUser.userId];
        
        
        query.whereClause = [NSString stringWithFormat:@"contest.vote_begin_date <= \'%@\' AND post_user.userId = \'%@\'", [df stringFromDate:[NSDate date]],  backendless.userService.currentUser.userId];
        
//     query.whereClause = [NSString stringWithFormat:@" post_user.userId = \'%@\'",  backendless.userService.currentUser.userId];
        NSLog(@"%@",  query.whereClause);
        QueryOptions *queryOptions = [QueryOptions new];
        queryOptions.relationsDepth = @(3);
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

            
            [self loadingCount];
            
        } error:^(Fault * fault) {
//            [GD onMain:^{
//                [_refreshControl endRefreshing];
//                [GD hideSV];
//            }];
//            
            [self loadingCount];
        }];
        
        // posting data
        //        Fault *fault = nil;
        BackendlessDataQuery *query_posting = [BackendlessDataQuery new];
        
        
//        query_posting.whereClause = [NSString stringWithFormat:@"contest.begin_date <= \'%@\' AND contest.end_date > \'%@\' AND post_user.userId = \'%@\'",[df stringFromDate:[NSDate date]], [df stringFromDate:[[NSDate date] dateByAddingTimeInterval:7*3600*24]] , backendless.userService.currentUser.userId];
        
        query_posting.whereClause = [NSString stringWithFormat:@"contest.begin_date <= \'%@\' AND contest.end_date > \'%@\' AND post_user.userId = \'%@\' AND contest.vote_begin_date > \'%@\'",[df stringFromDate:[NSDate date]], [df stringFromDate:[NSDate date]] , backendless.userService.currentUser.userId, [df stringFromDate:[NSDate date]]];
        NSLog(@"%@", query_posting.whereClause);
        
        QueryOptions *queryOptions_posting = [QueryOptions new];
        queryOptions_posting.relationsDepth = @(2);
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

            
           [self loadingCount];
        } error:^(Fault * fault) {

            [self loadingCount];
        }];
        

        
    }else{
        if(_beCollection){
            
            [_beCollection nextPageAsync:^(BackendlessCollection * becoll) {
                
                [_curData addObjectsFromArray:becoll.data];
                _curData = [[_curData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    
                    NSDate * date1 = ((Post*)obj1).contest.vote_end_date;
                    NSDate * date2 = ((Post*)obj2).contest.vote_end_date;
                    
                    
                    return [date1 compare:date2];
                }] mutableCopy];

                
                _beCollection = nil;
                _beCollection = becoll;
                
                [self loadingCount];
                
            } error:^(Fault *fault) {
                [self loadingCount];            }];
            
        }else{
            [self loadingCount];
        }
        
        if(_beCollection_posting){
            
            [_beCollection_posting nextPageAsync:^(BackendlessCollection * becoll) {
                
                [_curData_posting addObjectsFromArray:becoll.data];
                
                _curData_posting = [[_curData_posting sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    
                    NSDate * date1 = ((Post*)obj1).contest.end_date;
                    NSDate * date2 = ((Post*)obj2).contest.end_date;
                    
                    
                    return [date1 compare:date2];
                }] mutableCopy];
                
                _beCollection_posting = nil;
                _beCollection_posting = becoll;
               [self loadingCount];
                
            } error:^(Fault *fault) {
                [self loadingCount];
            }];
            
        }else{
            [self loadingCount];
        }
        
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
    if ([self.tblView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tblView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tblView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tblView setLayoutMargins:UIEdgeInsetsZero];
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
    MyContestsCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_MyContestsCell"];
    
    if(indexPath.section == 0){
        post = (Post*)[_curData_posting objectAtIndex:indexPath.row];
        
            [cell setPostData:post isPosting:YES];
        return  cell;
    }else{
        post = (Post*)[_curData objectAtIndex:indexPath.row];
        
        [cell setPostData:post isPosting:NO];
        return  cell;
        
    }
   

    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  90;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 45;
    }else{
        return 80;
    }
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if(section == 0) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [GD GetScreenSize].width, 45)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, [GD GetScreenSize].width, 3)];
        [sepLine setBackgroundColor:Color_Grey];
        [view addSubview:sepLine];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, [GD GetScreenSize].width, 25)];
        [title setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18.]];
        [title setTextColor:Color_Grey];
        title.text = MCLocalString(@"Posting Time");
        title.textAlignment = NSTextAlignmentCenter;
        [view addSubview:title];
        
        
        return view;
    }else{
        
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [GD GetScreenSize].width, 80)];
        [view setBackgroundColor:[UIColor whiteColor]];
        UIImageView * sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 77, [GD GetScreenSize].width, 3)];
        [sepLine setBackgroundColor:Color_Grey];
        
        UIImageView * sepLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [GD GetScreenSize].width, 35)];
        [sepLine1 setBackgroundColor:Color_Grey];
        
        [view addSubview:sepLine];
        
        [view addSubview:sepLine1];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, [GD GetScreenSize].width, 25)];
        [title setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18.]];
        [title setTextColor:Color_Grey];
        title.text = MCLocalString(@"Voting Time");
        title.textAlignment = NSTextAlignmentCenter;
        [view addSubview:title];

        
        return view;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     Post * post;

    if(indexPath.section == 0) {
//        return _curData_posting.count;
        post = (Post*)[_curData_posting objectAtIndex:indexPath.row];
    }else{
//        return _curData.count;
        post = (Post*)[_curData objectAtIndex:indexPath.row];
    }
    
    
    kAppDelegate.curUploadedContest = post.contest;
    
   
        
        
//        NSLog(@"ContestID : %@, count : %@", post.contest.objectId,[[ post.contest.contest_posts objectAtIndex:0] post_user].objectId);
        
        BackendlessDataQuery *query = [BackendlessDataQuery new];
        
        
        query.whereClause = [NSString stringWithFormat:@"objectId = \'%@\'",kAppDelegate.curUploadedContest.objectId ];
        
        QueryOptions *queryOptions = [QueryOptions new];
        queryOptions.relationsDepth = @(2);
        query.queryOptions = queryOptions;
        
        [GD showSVHUD];
        [backendless.persistenceService find:[Contest class] dataQuery:query response:^(BackendlessCollection * collection) {
            kAppDelegate.curUploadedContest = [collection.data objectAtIndex:0];
            [GD onMain:^{
                [GD hideSV];
                
                
                if(indexPath.section == 0){
                    
                    AddPhotoVC * aVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"AddPhotoVC"];
                    aVC.curContest = post.contest;
                    aVC.curPost = post;
                    
                    [CYAnimation PushAnimationRight2left:self nav:self.navigationController target:aVC];

                    
                }else{
                    //        post = (Post*)[_curData objectAtIndex:indexPath.row];
                    
                    MyContDetailVC * mVC = [[MyContDetailVC alloc] initWithNibName:@"MyContDetailVC" bundle:nil];
                    mVC.curPost = post;
                    mVC.curContest = post.contest;
                    NSLog(@"ContestID : %@, count : %@", post.contest.objectId,[[ post.contest.contest_posts objectAtIndex:0] post_user].objectId);
                    
                    [CYAnimation PushAnimationRight2left:self nav:self.navigationController target:mVC];
                    
                    
                    
                    
                }

               
            }];
        } error:^(Fault *fault) {
            [GD onMain:^{
                [GD hideSV];
                [GD ShowAlertViewTitle:@"Error_Network" message:MCLocalString(@"Data is invalid, please try again.") VC:self Ok:nil];
            }];
        }];
        
        
    
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
