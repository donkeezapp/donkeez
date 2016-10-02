//
//  MyContDetailVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "MyContDetailVC.h"
#import "ProductsCell.h"
#import "ProdCell.h"
@interface MyContDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * myPosts;
    NSInteger selRow;
}
@end

@implementation MyContDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tblProd.delegate = self;
    selRow  = -1;
    _tblProd.dataSource = self;
    [_tblProd registerNib:[UINib nibWithNibName:@"ProductsCell" bundle:nil] forCellReuseIdentifier:@"cell_prod"];
    [_tblProd registerNib:[UINib nibWithNibName:@"ProdCell" bundle:nil] forCellReuseIdentifier:@"cell_prod_tapped"];
    self.tblProd.backgroundColor = Color_Lighter_Grey;
    self.view.backgroundColor = Color_Lighter_Grey;
    self.seperateImgView.backgroundColor = Color_Lighter_Grey;
    // Do any additional setup after loading the view from its nib.
}

-(NSDictionary * )GetRankOfPost:(NSArray <Post*>* )postList{
    
    NSMutableArray * sortedPostList =[[ postList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        Post* post1 = (Post*)obj1;
        Post* post2 = (Post*)obj2;
        
        return post1.likes > post2.likes ? NSOrderedAscending: NSOrderedDescending;
        
        
    }] mutableCopy];
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Post * _Nullable each, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [each.is_valid boolValue];
    }];
    
    [sortedPostList filterUsingPredicate:predicate];
    
    
    NSMutableDictionary * rankDict = [NSMutableDictionary new];
    
    NSInteger i = sortedPostList.count;
    Post * oldPost = nil;
    for (Post * eachPost in sortedPostList) {

        
        if(oldPost && oldPost.likes.integerValue == eachPost.likes.integerValue){
          
            NSInteger oldRank = [[rankDict objectForKey:oldPost.objectId] integerValue];
            [rankDict setObject:@(oldRank) forKey:eachPost.objectId];
        }else{
                [rankDict setObject:@(i) forKey:eachPost.objectId];
        }
        

        oldPost = eachPost;
        
        i--;
    }
    [rankDict setObject:@(sortedPostList.count) forKey:@"total"];
    NSLog(@"Rank : %@", rankDict);
    
    
    return  rankDict;
    
}
-(void)localize{
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
    _lblProgress.text = MCLocalString(@"Progress");
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  
    [_imgLogo setMHImageWithURL:[NSURL URLWithString:_curContest.mark_image]];
    _lblTagsCont.text= _curContest.tags;
    _lblTitle.text = _curContest.title;
    
    [_imgPhoto setMHImageWithURL:[NSURL URLWithString:_curPost.photo]];
    
    _lblTime.text = [GD getDuringofDate:_curContest.vote_end_date];
    _lblLikes.text  = [NSString stringWithFormat:@"%ld", (long)_curPost.likes.integerValue];
    _lblEye.hidden = YES;
    
    
    
    // FIXME: create a better solution than this hot fix, the post is sometimes not in the relation
    
    BOOL isThere = NO;
    
    for (Post *post in self.curContest.contest_posts) {
        if ([post.objectId isEqualToString:self.curPost.objectId]) {
            isThere = YES;
            break;
        }
    }
    
    if (isThere == NO) {
        [self.curContest.contest_posts addObject:self.curPost];
    }
    
    
    
    // FIXME end
 
    NSDictionary * rankDict = [self GetRankOfPost:self.curContest.contest_posts];
    NSInteger total = [[rankDict allKeys] count];
    NSInteger curRank = [[rankDict objectForKey:_curPost.objectId] integerValue];
    
    
    _lblTotalRank.text = [NSString stringWithFormat:@"/%ld rank", (long)total];
    _lblMyRank.text  = [NSString stringWithFormat:@"%ld", (long)(total - curRank +1)];
    
    
    CGFloat rate = (CGFloat)curRank  / total;
    if(total == 0){
        rate = 0;
    }
    
//    if (rate == 1){
//        _nlSliderFrontWidth.constant = 0;
//        _nlThumbLeft.constant = 18;
//    } else {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 45.0f * 2.0;
        _nlSliderFrontWidth.constant = width * (1.0f - rate);
        _nlThumbLeft.constant += _nlSliderFrontWidth.constant;
///    }
    
    [_barFront setBackgroundColor:Color_Slider];
    CGRect frame = _barFront.frame;
    frame.size.width = _nlSliderFrontWidth.constant;
    [_barFront setFrame:frame];
    
    if([[NSDate date] compare:_curContest.vote_end_date ] == NSOrderedDescending){
        // ended
        [_imgSlide setImage:[UIImage imageNamed:@"icn_gr.png"]];
        [_barFront setBackgroundColor:Color_Grey];
        
        
    }else{
        
//        
//        NSDate * endLimit = [[NSDate date] dateByAddingTimeInterval:7 * 24 * 3600];
//        if([endLimit compare:_curContest.end_date] == NSOrderedDescending){
//            
            [_imgSlide setImage:[UIImage imageNamed:@"white-icn_tr.png"]];
//            
//            
//        }else{
//
//            
//        }
        
        
    }
    
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
    
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
    if ([self.tblProd respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tblProd setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tblProd respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tblProd setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger cnt = selRow!=-1?1:0;
    NSInteger count =_curContest.products.count + cnt;
    return count;

    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if(selRow != -1 && indexPath.row == selRow + 1){
        // prod image cell
        Products * prod= (Products*)[_curContest.products objectAtIndex:selRow];
        ProdCell * cell = [_tblProd dequeueReusableCellWithIdentifier:@"cell_prod_tapped"];
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
        
        Products * prod= (Products*)[_curContest.products objectAtIndex:idx];
        
        ProductsCell * cell = [_tblProd dequeueReusableCellWithIdentifier:@"cell_prod"];
        
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

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    return view;
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onShare:(id)sender {
    
    NSURL * imgUrl =  [NSURL URLWithString:_curPost.photo];
    if(!isSet(_curPost.photo)){
        imgUrl = [NSURL URLWithString:_curContest.mark_image];
    }
    [[SocialPostManager sharedManager] GeneralShareText:kAppDelegate.curUploadedContest.desc andImage:_imgPhoto.image andUrl:[NSURL URLWithString:kAppDelegate.appStoreUrl] viewController:self imageUrl:imgUrl];
}



-(void)onTapPlus:(id)sender{
    
    UIView * view = (UIView*)sender;
    NSInteger tag = view.tag;
    NSInteger oldSelRow = selRow;
    if(selRow != -1){
        NSIndexPath * idp = [NSIndexPath indexPathForRow:selRow+1 inSection:0];
        
        selRow = -1;
        
        [_tblProd beginUpdates];
        [_tblProd deleteRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tblProd endUpdates];
        
        if(oldSelRow == tag) return;
        
    }
    
    
    selRow = oldSelRow < tag && oldSelRow !=-1? tag - 1: tag;
    
    
    [_tblProd beginUpdates];
    NSIndexPath * idp = [NSIndexPath indexPathForRow:selRow+1 inSection:0];
    [_tblProd insertRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationAutomatic];
    //    [_tblProducts reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tblProd endUpdates];
    
    
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
