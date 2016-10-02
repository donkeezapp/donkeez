//
//  PhotoFilterVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/13/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "PhotoFilterVC.h"
#import "Filtercell.h"
#import <QuartzCore/QuartzCore.h>

#import "UploadPostVC.h"
@interface PhotoFilterVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

{
    NSArray * filterNameList;
    CGSize itemSize;
    NSMutableArray * filteredImageList;
    NSMutableArray *arrEffects;
    UIImage  *thumbImage;
    UIImage *minithumbImage;
    UIImage * originImage;
    
}

@end

@implementation PhotoFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collFilter.dataSource = self;
    _collFilter.delegate = self;
    [_collFilter registerNib:[UINib nibWithNibName:@"Filtercell" bundle:nil] forCellWithReuseIdentifier:@"cell_filter"];
    
    
    [_collFilter setBackgroundColor:[UIColor whiteColor]];
    arrEffects = [[NSMutableArray alloc] initWithObjects:
                  [NSDictionary dictionaryWithObjectsAndKeys:@"Original",@"title",@"",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E1",@"title",@"e1",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E2",@"title",@"e2",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E3",@"title",@"e3",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E4",@"title",@"e4",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E5",@"title",@"e5",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E6",@"title",@"e6",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E7",@"title",@"e7",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E8",@"title",@"e8",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E9",@"title",@"e9",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E10",@"title",@"e10",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E11",@"title",@"e11",@"method", nil],
                  nil];

    
    
    if(!_capImage){
        
        _capImage = [UIImage imageNamed:@"welcome.png"];
        
    }
    
    
//    _imgPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [GD GetScreenSize].width,[GD GetScreenSize].width)];
    
//    [capturedImageView addSubview:vImage];
    _imgPhoto.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth);
    _imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
    _imgPhoto.clipsToBounds = YES;
//    vImage.image = theImage;
    
    
    
    [_imgPhoto setImage:_capImage];
    
    _capImage = [GD captureView:_imgPhoto withArea:_imgPhoto.bounds];
    originImage = [_capImage copy];
//    NSData * imageData = UIImageJPEGRepresentation(_capImage, 1.0);
//    CFDataRef cd = CFDataCreate(NULL, [imageData bytes], [imageData length]);
//    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData(cd);
//    
//    CGImageRef cgImg = CGImageCreateWithJPEGDataProvider(dataProvider, nil, YES, kCGRenderingIntentDefault);
//    
//    _capImage = [UIImage imageWithCGImage:cgImg scale:1.0 orientation:UIImageOrientationRight];
    UICollectionViewFlowLayout * fl =  (UICollectionViewFlowLayout*)_collFilter.collectionViewLayout;
    itemSize = CGSizeMake(_collFilter.frame.size.height - 2, _collFilter.frame.size.height - 2);
    fl.itemSize = itemSize;
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    fl.minimumInteritemSpacing = 0.;
    
    filterNameList=  [NSArray new];
    
    thumbImage = [_capImage resizedImageToSize:CGSizeMake(320, 320)];
    minithumbImage = [thumbImage resizeImageToNewSize:itemSize];
    
    filteredImageList = [NSMutableArray new];
    
    UIActivityIndicatorView * ind = [GD activityViewToView:_collFilter];
    
    
    [CLFilterTool GetFilteredImageArr:_capImage completion:^(NSArray *images) {
        [GD onMain:^{
            [ind stopAnimating];
            filteredImageList = [images mutableCopy];
            [_collFilter reloadData];
        }];
        
    }];
    
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    filterNameList = [CYAnimation GetFilterNaemArray];
    
    
    
    [_collFilter reloadData];
    
}
- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)localize{
    _lblFilter.text = MCLocalString(@"Filters");
    _lblTItle.text = MCLocalString(@"Photo");
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
    [_btnNext setTitle:MCLocalString(@"Next") forState:UIControlStateNormal];
}


#pragma  mark - uicollectionview delegate datsource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    return arrEffects.count;
    return filteredImageList.count;
    
    
    
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cell_filter";
    
    Filtercell * cell = [_collFilter dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

//    [cell.imgView setImage:_capImage];
    [cell.imgView setContentMode:UIViewContentModeScaleAspectFit];
//    [cell.imgView setImage:[self fliterEvent:[filterNameList objectAtIndex:indexPath.row]]];
    cell.imgView.image = [filteredImageList objectAtIndex:indexPath.row];

//    if(((NSString *)[[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]).length > 0) {
//        
////        SEL _selector = NSSelectorFromString([[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]);
//        
////        cell.imgView.image = [minithumbImage performSelector:_selector];
//        
//        
//    } else{
//        cell.imgView.image = _capImage;
//    }
//        cell.imgView.image = minithumbImage;
    
    return  cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        
        [_imgPhoto setImage:originImage];
    }else{
        
//        Filtercell * cell = (Filtercell *)[_collFilter cellForItemAtIndexPath:indexPath];
        
//        [_imgPhoto setImage:[cell.imgView.image resizeImageToNewSize:CGSizeMake([GD GetScreenSize].width, [GD GetScreenSize].width)]];
//        SEL _selector = NSSelectorFromString([[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]);
//        _capImage = [originImage performSelector:_selector] ;
        
        _capImage = [filteredImageList objectAtIndex:indexPath.row];
        if(_ips == IPSCamera){
            _capImage = [UIImage imageWithCGImage:[_capImage CGImage] scale:[_capImage scale] orientation:UIImageOrientationUp];

        }
        [_imgPhoto setImage:_capImage];
       
    }
    
}

- (IBAction)onNext:(id)sender {
    
    UploadPostVC * uVC = [[UploadPostVC alloc] initWithNibName:@"UploadPostVC" bundle:nil];
    uVC.curContest = _curContest;
    UIImage * image = [GD captureView:_imgPhoto withArea:CGRectMake(0, 0, _imgPhoto.bounds.size.width, _imgPhoto.bounds.size.height)];
    uVC.imgPosted = image;
    [self.navigationController pushViewController:uVC animated:YES];
    

}

@end
