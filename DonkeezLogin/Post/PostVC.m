//
//  PostVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "PostVC.h"
#import "ContestCell.h"
#import "WinCell.h"
#import "AddPhotoVC.h"
#import "ProdCell.h"
@interface PostVC ()<ContestCellDelegate, UITableViewDelegate, UITableViewDataSource, WinCellDelegate>

@property(nonatomic, strong)BackendlessCollection * beCollection;
@property(nonatomic, strong)NSMutableArray <Contest*> * curData;

@property(nonatomic, strong)NSMutableArray <Contest*> * curWinData;
@property(nonatomic, strong)UIRefreshControl * refreshControl;

@property(nonatomic)NSInteger tappedRow;
@property(nonatomic)NSInteger loadCount;

@end

@implementation PostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _curData = [NSMutableArray new];
    [_tblView registerNib:[UINib nibWithNibName:@"WinCell" bundle:nil] forCellReuseIdentifier:@"cell_win"];
    [_tblView registerNib:[UINib nibWithNibName:@"ContestCell" bundle:nil] forCellReuseIdentifier:@"cell_contest"];
    [_tblView registerNib:[UINib nibWithNibName:@"ProdCell" bundle:nil] forCellReuseIdentifier:@"cell_prod_tapped"];
    _tblView.delegate = self;
    
    _tblView.dataSource = self;
    _loadCount = 0;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = Color_Lighter_Grey;
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadAll)
                  forControlEvents:UIControlEventValueChanged];
    [_tblView addSubview:_refreshControl];
    
    _tappedRow = -1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadAll) name:NOTI_RELOAD object:nil];
    
    _tblView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self reloadAll];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    kAppDelegate.mVC.navigationController.navigationBarHidden = NO;
    
}
-(void)reloadAll{
    
    [self loadData:YES];
}

-(void)loadCounter{
    
    _loadCount ++;
    if(_loadCount == 2){
        
        _loadCount = 0;
        [GD hideSV];
        [_refreshControl endRefreshing];
        [_tblView reloadData];
        
    }
    
    
}

-(void)loadWinData{
    
    NSDateFormatter * df = [NSDateFormatter new];
    [df setDateFormat:@"MM/dd/yyyy HH:mm:ss 'GMT'Z"];

    BackendlessDataQuery *query = [BackendlessDataQuery new];
    query.whereClause =  [NSString stringWithFormat:@"vote_end_date <= \'%@\' AND post_win.objectId != '' ",[df stringFromDate:[NSDate date]] ];
    
    NSLog(@"%@", query.whereClause);
//    query.whereClause =  [NSString stringWithFormat:@" post_win.objectId != '' " ];
    QueryOptions *queryOptions = [QueryOptions new];
    queryOptions.relationsDepth = @(2);
    queryOptions.sortBy = @[@"vote_end_date DESC"];
    [queryOptions setPageSize:@(3)];
    
    query.queryOptions = queryOptions;
    
    [backendless.persistenceService find:[Contest class] dataQuery:query response:^(BackendlessCollection * beCollection) {
//        _beCollection = beCollection;
        [_curWinData removeAllObjects];
//
        _curWinData = nil;
        _curWinData = [beCollection.data mutableCopy];
        [GD onMain:^{

            [self loadCounter];
        }];
        
    } error:^(Fault * fault) {
        [GD onMain:^{

            [self loadCounter];
        }];
        
    }];
    
    
}

-(void)loadData:(BOOL)reload{
    [GD showSVHUD];
    _tappedRow = -1;
    if(reload){
        [self loadWinData];
//        Fault *fault = nil;
        BackendlessDataQuery *query = [BackendlessDataQuery new];
        NSDateFormatter * df = [NSDateFormatter new];
        [df setDateFormat:@"MM/dd/yyyy HH:mm:ss 'GMT'Z"];
        
        query.whereClause = [NSString stringWithFormat:@"begin_date <= \'%@\' AND end_date >= \'%@\' AND vote_begin_date > \'%@\'",[df stringFromDate:[NSDate date]],[df stringFromDate:[NSDate date]],[df stringFromDate:[NSDate date]] ];
        
        QueryOptions *queryOptions = [QueryOptions new];
        queryOptions.relationsDepth = @(2);
        queryOptions.sortBy = @[@"end_date ASC"];
        query.queryOptions = queryOptions;
        
        [backendless.persistenceService find:[Contest class] dataQuery:query response:^(BackendlessCollection * beCollection) {
            _beCollection = beCollection;
            [_curData removeAllObjects];
            
            _curData = nil;
            _curData = [beCollection.data mutableCopy];
            [GD onMain:^{
                [self loadCounter];
//                [GD hideSV];
//                [_refreshControl endRefreshing];
//                [_tblView reloadData];
            }];
            
        } error:^(Fault * fault) {
            [GD onMain:^{
                [self loadCounter];
//                [_refreshControl endRefreshing];
//                [GD hideSV];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger winCel = _curWinData.count>0?1:0;
    if(_tappedRow > -1){
        Contest * cont = (Contest*)[_curData objectAtIndex:_tappedRow];
       
        return _curData.count +  cont.products.count+winCel;
    }
    return _curData.count+winCel;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger cellWinExist = _curWinData.count > 0?1:0;
    if(indexPath.row == 0 && _curWinData.count > 0){
        WinCell * wCell = [_tblView dequeueReusableCellWithIdentifier:@"cell_win"];
        Contest * cont1 =_curWinData.count>0?[_curWinData objectAtIndex:0]:nil;
        Contest * cont2 =_curWinData.count>1?[_curWinData objectAtIndex:1]:nil;
        Contest * cont3 =_curWinData.count>2?[_curWinData objectAtIndex:2]:nil;
        [wCell setContData:cont1 cont1:cont2 cont2:cont3];
        wCell.delegate = self;
        return  wCell;
        
    }
    
    NSInteger realRow = indexPath.row - cellWinExist;
    
    if(_tappedRow != -1){
        
        Contest * selCont = (Contest*)[_curData objectAtIndex:_tappedRow];
        NSInteger prodCount = selCont.products.count;
        
        if(realRow <= _tappedRow ){
            
            Contest * cont = (Contest*)[_curData objectAtIndex:realRow ];
            
            ContestCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_contest"];
            
            
            [cell setDataCell:cont isSel:(realRow == _tappedRow)];
            
            cell.delegate  = self;
            return  cell;

        }else if(realRow > _tappedRow && realRow <= _tappedRow +  prodCount ){
            
            ProdCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_prod_tapped"];
            long i = realRow - _tappedRow - 1;
            Products * curProd = [selCont.products objectAtIndex:i];
            
            [cell.imgProd setMHImageWithURL:[NSURL URLWithString:curProd.item_image]];
            cell.lblProd.text = curProd.item_name;
            
            return  cell;

            
        }else if(realRow > _tappedRow + prodCount){
            
            Contest * cont = (Contest*)[_curData objectAtIndex:realRow - prodCount ];
            
            ContestCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_contest"];
            
            [cell setDataCell:cont isSel:NO];
            cell.delegate  = self;
            return  cell;
            
        }
    }else{
        
        NSLog(@"  Un Tapped for prod, _tappedrow %ld", (long)_tappedRow);
        Contest * cont = (Contest*)[_curData objectAtIndex:realRow ];
        
        ContestCell * cell = [_tblView dequeueReusableCellWithIdentifier:@"cell_contest"];
        
        [cell setDataCell:cont  isSel:NO];
        cell.delegate  = self;
        return  cell;
    }
    
    
    
    return  nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_curWinData.count > 0 && indexPath.row ==0){
        
        return 224;
    }
    return  127;
    
}


-(BOOL)onTappedPlus:(ContestCell *)cell contest:(Contest *)contData{
       NSInteger existWin = _curWinData.count > 0? 1:0;
    
    NSInteger oldTappedRow = _tappedRow;
    
    if(contData.products.count <= 0){
        [self.view makeToast:MCLocalString(@"There is no products.") duration:1.2 position:CSToastPositionBottom];
        return NO;
    }
    
    
    NSIndexPath * idp = [_tblView indexPathForCell:cell];

    
    if(_tappedRow != -1){
        
        
        
        ContestCell * oldCell = [_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_tappedRow+existWin inSection:0]];
        [oldCell initPlusButton];
        
        Contest * oldCont = [_curData objectAtIndex:oldTappedRow];
        NSInteger oldCount = oldCont.products.count;
//        NSInteger count = contData.products.count;
        NSMutableArray * idpArr = [NSMutableArray new];
        
        for(int i=1 ; i<=oldCount; i++){
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:oldTappedRow + i + existWin inSection:0];
            [idpArr addObject:newIndexPath];
            NSLog(@"deleted rows %d: %ld",i, oldTappedRow + i + existWin);
        }
        
        _tappedRow = -1;
        if(idpArr.count > 0){
            [_tblView beginUpdates];
            [_tblView deleteRowsAtIndexPaths:idpArr withRowAnimation:UITableViewRowAnimationAutomatic];
            [_tblView endUpdates];
        }
        
        NSInteger realRow = idp.row - existWin;
        
        if(oldTappedRow == realRow) return NO;
        
        _tappedRow = realRow <= oldTappedRow ? realRow : realRow - oldCount;
        
    }else{
        _tappedRow = idp.row - existWin;
    }
  
    
        NSInteger count = 0;

    NSLog(@"_tappedRow> %ld", _tappedRow);
    
            Contest * cont1 = (Contest*)[_curData objectAtIndex:_tappedRow];
            count = cont1.products.count;

        NSMutableArray * idpArr = [NSMutableArray new];
        
        for(int i=1 ; i<=count; i++){
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:_tappedRow+i+existWin inSection:0];
            [idpArr addObject:newIndexPath];
            NSLog(@"inserted rows %d: %ld",i, _tappedRow+i+existWin);
            
        }
        if(idpArr.count > 0){
            [_tblView beginUpdates];
            [_tblView insertRowsAtIndexPaths:idpArr withRowAnimation:UITableViewRowAnimationAutomatic];
            [_tblView endUpdates];
        }
    
    return YES;
}

-(void)onTappedSharing:(ContestCell *)cell contest:(Contest *)contData{

    
    NSURL * imgUrl = [NSURL URLWithString:contData.mark_post];
    [[SocialPostManager sharedManager] GeneralShareText:contData.desc andImage:cell.imgBack.image andUrl:[NSURL URLWithString:kAppDelegate.appStoreUrl] viewController:kAppDelegate.mVC imageUrl:imgUrl];
    
}
-(void)onTappedView:(ContestCell *)cell contest:(Contest *)contData
{
    AddPhotoVC * aVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPhotoVC"];

    kAppDelegate.curUploadedContest = contData;
    aVC.curContest = contData;
    
    [CYAnimation PushAnimationRight2left:self nav:kAppDelegate.mVC.navigationController target:aVC];
    
}



-(void)onTapWin:(NSInteger)winNumber contest:(Contest *)contest{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_PAGESEL_3 object:nil];
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
