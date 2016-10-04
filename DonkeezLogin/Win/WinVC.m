//
//  WinVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "WinVC.h"
#import "WinVCCell.h"
#import "ProdCell.h"
#import "ProfileCell.h"

@interface WinVC ()<UITableViewDelegate, UITableViewDataSource, WinVCCellDelegate, ProfileCellDelegate>
{
    
    NSInteger selRow;
}
@property(nonatomic, strong)BackendlessCollection * beCollection;
@property(nonatomic, strong)NSMutableArray <Contest*> * curData;

@property(nonatomic, strong)UIRefreshControl * refreshControl;
@property(nonatomic, strong)NSMutableArray * userInfoList;

@end

@implementation WinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tblView registerNib:[UINib nibWithNibName:@"WinVCCell" bundle:nil] forCellReuseIdentifier:@"cell_win_vc"];
    [_tblView registerNib:[UINib nibWithNibName:@"ProdCell" bundle:nil] forCellReuseIdentifier:@"cell_prod_tapped"];
    [_tblView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:@"cell_profile_cell"];
    _tblView.delegate = self;
    
    _tblView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = Color_Lighter_Grey;
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadAll)
                  forControlEvents:UIControlEventValueChanged];
    [_tblView addSubview:_refreshControl];
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


-(void)reloadAll{
    
    [self loadData:YES];
}


-(void)loadData:(BOOL)reload{
    selRow = -1;
    [GD showSVHUD];
    if(reload){
   
        NSDateFormatter * df = [NSDateFormatter new];
        [df setDateFormat:@"MM/dd/yyyy HH:mm:ss 'GMT'Z"];
        
        //        Fault *fault = nil;
        BackendlessDataQuery *query = [BackendlessDataQuery new];
        query.whereClause =  [NSString stringWithFormat:@"vote_end_date <= \'%@\'",[df stringFromDate:[NSDate date]] ];
        
        QueryOptions *queryOptions = [QueryOptions new];
        queryOptions.relationsDepth = @(2);
        queryOptions.sortBy = @[@"vote_end_date DESC"];
        query.queryOptions = queryOptions;
        
        
        
        [backendless.persistenceService find:[Contest class] dataQuery:query response:^(BackendlessCollection * beCollection) {
            _beCollection = beCollection;
            [_curData removeAllObjects];
            
            _curData = nil;
            _curData = [beCollection.data mutableCopy];
            
            
            _userInfoList = [NSMutableArray new];
            for(int i = 0; i< _curData.count ; i++){
                
                BackendlessUser * user = [(Contest*)[_curData objectAtIndex:i] post_win].post_user;
                
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
                
                
                for(int i = 0; i< becoll.data.count ; i++){
                    
                    BackendlessUser * user = [(Contest*)[becoll.data objectAtIndex:i] post_win].post_user;
                    
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
    
    NSInteger countAdd  = selRow > -1? 1:0;
    
    
    return _curData.count + countAdd;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     if(indexPath.row == selRow + 1 && selRow > -1){
         
         ProfileCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_profile_cell"];
          Contest * cont = (Contest*)[_curData objectAtIndex:selRow ];
         cell.btnShate.hidden = YES;
//         Post * post = cont.post_win;
         
//         [cell setProfileUser:post.post_user];
         
         UserInfo * uinfo = [_userInfoList objectAtIndex:selRow];
         if([uinfo isKindOfClass:[UserInfo class]]){
             [cell setProfileUserInfo:uinfo];
         }else{
             
         }
         
         cell.delegate = self;
         return  cell;

         
     }else{
         NSInteger Row = (selRow > -1 && indexPath.row > selRow + 1 )? indexPath.row -1 : indexPath.row;
         
         
         Contest * cont = (Contest*)[_curData objectAtIndex:Row ];
         
         
         WinVCCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_win_vc"];
         
         
         [cell setContestForCell:cont isSel:(indexPath.row == selRow  && selRow > -1)];
         
         
         cell.delegate  = self;
         
         return  cell;

     }
    
//    if(selRow > -1){
//        Contest * selcont = (Contest*)[_curData objectAtIndex:selRow ];
//        NSInteger countOfProds = selcont.products.count;
//        NSInteger endRow = selRow + countOfProds;
//        if(indexPath.row > selRow && indexPath.row <= endRow){
//            long i = indexPath.row - selRow - 1;
//            ProdCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_prod_tapped"];
//            
//            Products * curProd = [selcont.products objectAtIndex:i];
//            
//            [cell.imgProd setMHImageWithURL:[NSURL URLWithString:curProd.item_image]];
//            cell.lblProd.text = curProd.item_name;
//            
//            return  cell;
//
//            
//        }else{
//            NSInteger row = indexPath.row;
//            
//            if(selRow < indexPath.row){
//                row = indexPath.row - countOfProds;
//            }
//            Contest * cont = (Contest*)[_curData objectAtIndex:row ];
//            
//            
//            WinVCCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_win_vc"];
//            [cell setContestForCell:cont];
//            
//            
//            cell.delegate  = self;
//            
//            return  cell;
//
//        }
//        
//    }else{
//        
//    
//        
//    }
    
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat h = indexPath.row == selRow + 1 && selRow > -1? 80:[GD GetScreenSize].width;
    return  h;
    
    
}

-(BOOL)onTappedPlus:(Contest *)contest cell:(WinVCCell *)cell image:(UIImage *)winImage{
    
    if(!contest.post_win){
        [self.view makeToast:MCLocalString(@"There is no win post.") duration:1.2 position:CSToastPositionBottom];
        return NO;
    }
    
    NSIndexPath * idp = [_tblView indexPathForCell:cell];
//    Contest * cont = nil;
    
    if(selRow != -1){
        
        
        WinVCCell * oldCell = [_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selRow inSection:0]];
        [oldCell initPlusButton];
        
//        cont =(Contest*)[_curData objectAtIndex:selRow];
//        NSInteger count = cont.products.count;
        NSMutableArray * idpArr = [NSMutableArray new];
        
//        for(int i=1 ; i<=count; i++){
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:selRow+1 inSection:0];
            [idpArr addObject:newIndexPath];
            
//        }
        NSInteger newTappedRow = -1;
        if(selRow != -1 && idp.row > selRow){
            
            newTappedRow = idp.row - 1;
        }
        else{
            newTappedRow = idp.row;
        }
        if(selRow == newTappedRow) newTappedRow = -1;
        
        selRow = -1;
        if(idpArr.count > 0){
            [_tblView beginUpdates];
            [_tblView deleteRowsAtIndexPaths:idpArr withRowAnimation:UITableViewRowAnimationAutomatic];
            [_tblView endUpdates];
        }
        
        if(newTappedRow == -1) return NO;
        selRow = newTappedRow;
        
    }
    
    
    NSInteger count = 0;
    
    if(selRow == -1){
        selRow = idp.row;
    }
    Contest * cont1 = (Contest*)[_curData objectAtIndex:selRow];
    count = cont1.products.count;
    
    NSMutableArray * idpArr = [NSMutableArray new];
    
//    for(int i=1 ; i<=count; i++){
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:selRow+1 inSection:0];
        [idpArr addObject:newIndexPath];
        
//    }
    if(idpArr.count > 0){
        [_tblView beginUpdates];
        [_tblView insertRowsAtIndexPaths:idpArr withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tblView endUpdates];
    }
    
    return YES;
    
}
-(void)onTappedShare:(ProfileCell *)cell user:(BackendlessUser *)user{
    
//    NSIndexPath * idp = [_tblView indexPathForCell:cell];
//    NSIndexPath * postIdp = [NSIndexPath indexPathForRow:idp.row-1 inSection:0];
//    
//    
//    WinVCCell  * wvCell = (WinVCCell*)[_tblView cellForRowAtIndexPath:postIdp];
//    NSURL * imgUrl = [NSURL URLWithString:wvCell.winPost.photo];
//    [[SocialPostManager sharedManager] GeneralShareText:wvCell.curContest.desc andImage:wvCell.imgPhoto.image andUrl:[NSURL URLWithString:kAppDelegate.appStoreUrl] viewController:kAppDelegate.mVC imageUrl:imgUrl];
    [[SocialPostManager sharedManager] inviteToFacebook];

}
-(void)onTappedShare:(Contest *)contest cell:(WinVCCell *)cell image:(UIImage *)winImage{
    
    [[SocialPostManager sharedManager] inviteToFacebook];
//     NSURL * imgUrl = [NSURL URLWithString:cell.winPost.photo];
//      [[SocialPostManager sharedManager] GeneralShareText:contest.desc andImage:winImage andUrl:[NSURL URLWithString:kAppDelegate.appStoreUrl] viewController:kAppDelegate.mVC imageUrl:imgUrl];
    
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
