//
//  VoteVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "VoteVC.h"
#import "ContestCell.h"
#import "ProdCell.h"
#import "VoteDetailVC.h"
@interface VoteVC ()<UITableViewDelegate, UITableViewDataSource, ContestCellDelegate>


@property(nonatomic, strong)BackendlessCollection * beCollection;
@property(nonatomic, strong)NSMutableArray <Contest*> * curData;

@property(nonatomic, strong)UIRefreshControl * refreshControl;


@property(nonatomic)NSInteger tappedRow;


@end

@implementation VoteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [_tblView registerNib:[UINib nibWithNibName:@"ContestCell" bundle:nil] forCellReuseIdentifier:@"cell_contest"];
       [_tblView registerNib:[UINib nibWithNibName:@"ProdCell" bundle:nil] forCellReuseIdentifier:@"cell_prod_tapped"];
    _tblView.delegate = self;
    
    _tblView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = Color_Lighter_Grey;
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadAll)
                  forControlEvents:UIControlEventValueChanged];
    [_tblView addSubview:_refreshControl];
    
    _tappedRow = -1;
    // Do any additional setup after loading the view.
    _tblView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self loadData:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    kAppDelegate.mVC.navigationController.navigationBarHidden = NO;
    
}

//////     cell seperator line full width
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
////////    \\\\\\\\\\\

-(void)reloadAll{
    
    [self loadData:YES];
}

-(void)loadData:(BOOL)reload{
    [GD showSVHUD];
    if(reload){
            _tappedRow = -1;
        //        Fault *fault = nil;
        BackendlessDataQuery *query = [BackendlessDataQuery new];
        NSDateFormatter * df = [NSDateFormatter new];
        [df setDateFormat:@"MM/dd/yyyy HH:mm:ss 'GMT'Z"];
        
        query.whereClause = [NSString stringWithFormat:@"vote_begin_date <= \'%@\' AND vote_end_date >= \'%@\'",[df stringFromDate:[NSDate date]],[df stringFromDate:[NSDate date]]];
        
        QueryOptions *queryOptions = [QueryOptions new];
        queryOptions.relationsDepth = @(2);
        queryOptions.sortBy = @[@"vote_end_date ASC"];
        query.queryOptions = queryOptions;
        
        [backendless.persistenceService find:[Contest class] dataQuery:query response:^(BackendlessCollection * beCollection) {
            _beCollection = beCollection;
            [_curData removeAllObjects];
            
            _curData = nil;
            _curData = [beCollection.data mutableCopy];
            [GD onMain:^{
                [GD hideSV];
                [_refreshControl endRefreshing];
                [_tblView reloadData];
            }];
            
        } error:^(Fault * fault) {
            [GD onMain:^{
                [_refreshControl endRefreshing];
                [GD hideSV];
            }];
        }];
        
        
    }else{
        if(_beCollection){
            
            [_beCollection nextPageAsync:^(BackendlessCollection * becoll) {
                
                [_curData addObjectsFromArray:becoll.data];
                _beCollection = nil;
                _beCollection = becoll;
                
                [GD onMain:^{
                    [GD hideSV];
                    [_refreshControl endRefreshing];
                    [_tblView reloadData];
                }];
                
            } error:^(Fault *fault) {
                [GD onMain:^{
                    [_refreshControl endRefreshing];
                    [GD hideSV];
                }];
            }];
            
        }else{
            [GD hideSV];
            [_refreshControl endRefreshing];
        }
        
        
    }
    
    
}

#pragma mark tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_tappedRow > -1){
        Contest * cont = (Contest*)[_curData objectAtIndex:_tappedRow];
        
        return _curData.count +  cont.products.count;
    }
    return _curData.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_tappedRow > -1){
        Contest * selCont = (Contest*)[_curData objectAtIndex:_tappedRow];
        
        if(indexPath.row > _tappedRow  &&  indexPath.row <=  _tappedRow + selCont.products.count){
            
            long i = indexPath.row - _tappedRow - 1;
            
            ProdCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_prod_tapped"];
            
            Products * curProd = [selCont.products objectAtIndex:i];
            
            [cell.imgProd setMHImageWithURL:[NSURL URLWithString:curProd.item_image]];
            cell.lblProd.text = curProd.item_name;
            
            return  cell;
            
            
        }else if(indexPath.row <= _tappedRow){
            
            Contest * cont = (Contest*)[_curData objectAtIndex:indexPath.row ];

            
                ContestCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_contest"];
                
                [cell setDataCell:cont isSel:(indexPath.row == _tappedRow)];
//                cell.imgContestLogo.hidden = NO;
            
                cell.delegate  = self;
                return  cell;
            
            
        }else {
            Contest * cont = (Contest*)[_curData objectAtIndex:indexPath.row  - selCont.products.count];
            
                        
                ContestCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_contest"];
//                cell.imgContestLogo.hidden = NO;
                [cell setDataCell:cont isSel:(indexPath.row == _tappedRow)];
                cell.delegate  = self;
                return  cell;
            
                
        }
    }else{
        Contest * cont = (Contest*)[_curData objectAtIndex:indexPath.row ];
        NSLog(@"Posts count Of Contest : %ld", (unsigned long)cont.contest_posts.count);
        
            ContestCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_contest"];
            
            [cell setDataCell:cont isSel:NO];
            cell.delegate  = self;
            return  cell;
        
    }
    

    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
               return  127;
    
}


-(BOOL)onTappedPlus:(ContestCell *)cell contest:(Contest *)contData{
    
 
    
    
    if(contData.products.count <= 0){
        
        return NO;
    }
    
    NSIndexPath * idp = [_tblView indexPathForCell:cell];
    Contest * cont = nil;
    
    if(_tappedRow != -1){
        
        ContestCell * oldCell = [_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_tappedRow inSection:0]];
        [oldCell initPlusButton];
        
        cont =(Contest*)[_curData objectAtIndex:_tappedRow];
        NSInteger count = cont.products.count;
        NSMutableArray * idpArr = [NSMutableArray new];
        
        for(int i=1 ; i<=count; i++){
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:_tappedRow+i inSection:0];
            [idpArr addObject:newIndexPath];
            
        }
        NSInteger newTappedRow = -1;
        if(_tappedRow != -1 && idp.row > _tappedRow){
            
            newTappedRow = idp.row - count;
        }
        else{
            newTappedRow = idp.row;
        }
        if(_tappedRow == newTappedRow) newTappedRow = -1;
        
        _tappedRow = -1;
        if(idpArr.count > 0){
            [_tblView beginUpdates];
            [_tblView deleteRowsAtIndexPaths:idpArr withRowAnimation:UITableViewRowAnimationAutomatic];
            [_tblView endUpdates];
        }
        
        if(newTappedRow == -1) return NO;
        _tappedRow = newTappedRow;
        
    }
    
    
    NSInteger count = 0;
    
    if(_tappedRow == -1){
        _tappedRow = idp.row;
    }
    Contest * cont1 = (Contest*)[_curData objectAtIndex:_tappedRow];
    count = cont1.products.count;
    
    NSMutableArray * idpArr = [NSMutableArray new];
    
    for(int i=1 ; i<=count; i++){
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:_tappedRow+i inSection:0];
        [idpArr addObject:newIndexPath];
        
    }
    if(idpArr.count > 0){
        [_tblView beginUpdates];
        [_tblView insertRowsAtIndexPaths:idpArr withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tblView endUpdates];
    }
    
    return YES;
    
}


-(void)onTappedSharing:(ContestCell *)cell contest:(Contest *)contData{
    
    [[SocialPostManager sharedManager] inviteToFacebook];
//    NSIndexPath * idp = [_tblView indexPathForCell:cell];
//    
//    ContestCell * curcell = (ContestCell*)[_tblView cellForRowAtIndexPath:idp];
//    NSURL * imgurl = [NSURL URLWithString:contData.mark_post];
////    [[SocialPostManager sharedManager] postToFacebook:self IMAGE:curcell.imgBack.image MSG:@""];
//    [[SocialPostManager sharedManager] GeneralShareText:contData.desc andImage:curcell.imgBack.image andUrl:[NSURL URLWithString:kAppDelegate.appStoreUrl] viewController:kAppDelegate.mVC imageUrl:imgurl];
}
-(void)onTappedView:(ContestCell *)cell contest:(Contest *)contData
{

    
    VoteDetailVC * vVC = [[VoteDetailVC alloc] initWithNibName:@"VoteDetailVC" bundle:nil];
    // remove invalid posts
    NSMutableArray * inValidPosts = [NSMutableArray new];
    for (Post * eachPost in contData.contest_posts) {
        if(eachPost.is_valid.boolValue !=  YES && ![eachPost.post_user.userId isEqualToString:backendless.userService.currentUser.userId] ){
            
            [inValidPosts addObject:eachPost];
        }
    }
    
    for (Post * eachPost in inValidPosts) {
        [contData removeFromContest_posts:eachPost];
    }
    
    vVC.curContest = contData;
    
    [CYAnimation PushAnimationRight2left:self nav:kAppDelegate.mVC.navigationController target:vVC];
    
    
}

@end
