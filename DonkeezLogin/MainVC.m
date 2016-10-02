//
//  PageVC.m
//  HealthKit
//
//  Created by Admin on 2/21/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "MainVC.h"

#import "PostVC.h"
#import "VoteVC.h"
#import "WinVC.h"
#import "MyContestsVC.h"

#import "ProfileView.h"
@interface MainVC ()
@property (nonatomic) CAPSPageMenu *pageMenu;
@property(nonatomic)CGFloat menuHeight;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuHeight = 37.0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotiSelPage1) name:NOTI_PAGESEL_1 object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotiSelPage2) name:NOTI_PAGESEL_2 object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotiSelPage3) name:NOTI_PAGESEL_3 object:nil];
    kAppDelegate.mVC = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    [self.view setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - _menuHeight)];
    //    
    
    
    
    
    //    self.navigationItem.title = @"Setting";
    
    //    UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 23)];
    //    self.navigationItem.titleView = lblTitle;
    //    lblTitle.text = @"Setting";
    //    lblTitle.textColor = [UIColor whiteColor];
    
    
    
    
    [self.navigationController.navigationBar setFrame:CGRectMake(0,0 , [GD GetScreenSize].width, 60)];
    
    
    // Do any additional setup after loading the view.
    PostVC * pVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"PostVC"];
    
    VoteVC * vVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"VoteVC"];
    WinVC * wVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"WinVC"];
    
    pVC.title = MCLocalString(@"Post");
    
    vVC.title =MCLocalString(@"Vote");
    wVC.title = MCLocalString(@"Win");
    
    CGSize screensize = [GlobalDefine GetScreenSize];
    
    
    NSArray *controllerArray = @[pVC, vVC, wVC];
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor],
                                 CAPSPageMenuOptionViewBackgroundColor:[UIColor whiteColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor: Color_Slider,
                                 CAPSPageMenuOptionBottomMenuHairlineColor: Color_Grey,
                                 CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"Helvetica Neue" size:17.0],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: [UIColor darkGrayColor],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor : [UIColor lightGrayColor],
                                 CAPSPageMenuOptionMenuHeight: @(_menuHeight),
                                 CAPSPageMenuOptionMenuItemWidth: @(screensize.width / 3.),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight : @(1.),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl : @(YES),
                                 CAPSPageMenuOptionEnableHorizontalBounce : @(YES),
                                 CAPSPageMenuOptionMenuItemSeparatorWidth:@(2.0),
                                 CAPSPageMenuOptionMenuItemSeparatorColor : Color_Slider
                                 
                                 //                                 MenuImagesKey : @[@"home_30.png", @"upload_30.png", @"log_30.png"],
                                 //                                 MenuImagesKeyHighlighted : @[ @"log_30.png", @"home_30.png", @"upload_30.png"]
                                 };
    
    
    if(!_pageMenu){
        _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, self.view.frame.origin.y + self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width, self.view.frame.size.height - (self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height + 20)) options:parameters];
        
        [self.view addSubview:_pageMenu.view];
    }
    _pageMenu.controllerScrollView.scrollEnabled = NO;
    
    NSInteger curPage = [[GD ReadDefaultStoreforKey:@"page_no"] integerValue];
    
    
    
    UIImageView * imgTitleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    
    imgTitleView.image = [UIImage imageNamed:@"donkeez_mark.png"];
    imgTitleView.contentMode = UIViewContentModeScaleAspectFit;
    //    self.navigationItem.titleView = imgTitleView;
    imgTitleView.center = self.navigationController.navigationBar.center;
    [self.navigationController.navigationBar addSubview:imgTitleView];
    
    UIImageView * imgCorner = [[UIImageView alloc] initWithFrame:CGRectMake([GD GetScreenSize].width - 60, 0, 60, 60)];
    [imgCorner setImage:[[UIImage imageNamed:@"topright_corner.png"] resizedImageToSize:CGSizeMake(45, 45)]];
    [self.navigationController.navigationBar addSubview:imgCorner];
    
    
    
    UIImage * donkImage = [[UIImage imageNamed:@"main_mark.png"] resizeImageToNewSize:CGSizeMake(52, 45)];
    
    UIButton * btnRight =  [[UIButton alloc] initWithFrame:CGRectMake([GD GetScreenSize].width - 60, 10, 52, 45)];
    //    UIButton * btnRight = [[UIButton alloc] initWithFrame:CGRectMake([GD GetScreenSize].width - 60, 10, 30, 30)];
    btnRight.center = CGPointMake(imgCorner.center.x+5, imgCorner.center.y);
    
    
    [btnRight setTitle:@"" forState:UIControlStateNormal];
    [btnRight setImage:donkImage forState:UIControlStateNormal];

    
    [btnRight addTarget:self action:@selector(onRightButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:btnRight];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    
    
    if(curPage >= 1){
        [_pageMenu moveToPage:curPage];
        [GD WriteDefaultStore:@(0) forKey:@"page_no"];
    }
    for (UIView * view in self.navigationController.navigationBar.subviews) {
        [self.navigationController.navigationBar willRemoveSubview:view];
        
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    self.navigationItem.titleView = nil;
}
-(void)onRightButton{
    
    MyContestsVC * mVC = [[MyContestsVC alloc] initWithNibName:@"MyContestsVC" bundle:nil];
    [CYAnimation PushAnimationRight2left:self nav:self.navigationController target:mVC];
    
}
-(void)onLeftButton{
    dispatch_async(dispatch_get_main_queue(), ^{
        ProfileView * pVC = [[ProfileView alloc] initWithNibName:@"ProfileView" bundle:nil];
        [CYAnimation PushAnimationLeft2Right:self nav:self.navigationController target:pVC];
    });
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    [self.view layoutSubviews];
    //    [self.view layoutIfNeeded];
    
    
    
    self.navigationController.navigationBarHidden = NO;
    
    UIButton * btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35 , 35)];
    [btnLeft setTitle:@"" forState:UIControlStateNormal];
    [btnLeft setImage:[[UIImage imageNamed:@"menu.png"] resizeImageToNewSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    
    [btnLeft addTarget:self action:@selector(onLeftButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    
    //    [self.navigationController.navigationBar setFrame:CGRectMake(0,0 , [GD GetScreenSize].width, 60)];
    //    if(_pageMenu){
    //        [_pageMenu.view setFrame:CGRectMake(0.0, self.view.frame.origin.y + self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width, self.view.frame.size.height - (self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height + 20))];
    //    
    ////        _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, self.view.frame.origin.y + self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width, self.view.frame.size.height - (self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height + 20)) options:parameters];
    //    }
}

-(void)onNotiSelPage1{
    
    [GD onMain:^{
        [_pageMenu moveToPage:0];
    }];
    
    
    
}
-(void)onNotiSelPage2{
    
    [GD onMain:^{
        [_pageMenu moveToPage:1];
    }];
    
    
    
}
-(void)onNotiSelPage3{
    
    [GD onMain:^{
        [_pageMenu moveToPage:2];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didTapGoToLeft {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex > 0) {
        [_pageMenu moveToPage:currentIndex - 1];
    }
}

- (void)didTapGoToRight {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex < self.pageMenu.controllerArray.count) {
        [self.pageMenu moveToPage:currentIndex + 1];
    }
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
