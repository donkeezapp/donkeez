
#import "BaseViewController.h"

@interface BaseViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate >//UIActionSheetDelegate
@property(nonatomic)NSInteger preOrientation;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    _preOrientation = -1;
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localize) name:MCLocalizationLanguageDidChangeNotification object:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIDevice *device = [UIDevice currentDevice];					//Get the device object
    [device beginGeneratingDeviceOrientationNotifications];			//Tell it to start monitoring the accelerometer for orientation
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];	//Get the notification centre for the app
    [nc addObserver:self											//Add yourself as an observer
           selector:@selector(orientationChanged:)
               name:UIDeviceOrientationDidChangeNotification
             object:device];
    
    
    CGFloat w = [GlobalDefine GetScreenSize].width - 40;
    CGFloat h = 80;
    CGFloat x = ([GlobalDefine GetScreenSize].width - w) / 2.;
    CGFloat y = ([GlobalDefine GetScreenSize].height - h) / 2.;
    
    
    _lblNoneData = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _lblNoneData.numberOfLines = 5;
    _lblNoneData.text = MCLocalString(@"There is no results");
    _lblNoneData.textColor = [UIColor lightGrayColor];
    _lblNoneData.textAlignment = NSTextAlignmentCenter;
    
    _lblNoneData.hidden = YES;
    [self.view addSubview:_lblNoneData];
    [self.view bringSubviewToFront:_lblNoneData];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.backbutton = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, 25, 25)];
    [self.backbutton setImage:[UIImage imageNamed:@"left_50.png"] forState:UIControlStateNormal];
    [self.backbutton addTarget:self action:@selector(onBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0,0, 0, 0)]];
    [self localize];
    [self initTopConstant];
    
    if(_hideNavBar){
        [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, 0, 0)];
        
        [self.navigationController.navigationBar setHidden:YES];
    }
   
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.backbutton removeFromSuperview];
    [super viewWillDisappear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    if(_hideNavBar){
        //        [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, 0, 0)];
        
        [self.navigationController.navigationBar setHidden:NO];
    }
    
    [super viewDidDisappear:animated];
    
    
}
-(void)onBackButton{
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)initTopConstant{
    if(_constTop){
        CGFloat h = self.navigationController.navigationBar.frame.size.height * -1;
        _constTop.constant = h;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)localize{
    
}
-(void)orientationChanged:(NSNotification*)notify{
    UIDevice * dev = (UIDevice*)notify.object;
    switch (dev.orientation) {
        case UIDeviceOrientationFaceDown:
            NSLog(@"Device Orientation : FaceDown");
            break;
        case UIDeviceOrientationFaceUp:
            NSLog(@"Device Orientation : FaceUp");
            break;
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"Device Orientation : LandscapeLeft");
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"Device Orientation : LandscapeRight");
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"Device Orientation : Portrait");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"Device Orientation : UpsideDown");
            break;
        case UIDeviceOrientationUnknown:
            NSLog(@"Device Orientation : Unknown");
            break;
            
        default:
            break;
    }
    if(_preOrientation != dev.orientation && _preOrientation != -1){
        
        [self initTopConstant];
    }
     _preOrientation = dev.orientation;
    NSLog(@"orientationChanged >>>>>> %ld",     (long)dev.orientation);
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    NSLog(@" shouldAutorotateToInterfaceOrientation ");
    return NO;
}

-(void)goToProfileView{
    
}





-(void)ShowActionSheetForImagePickCompletion:(void(^)(UIImage * img))successBlock cancel:(void(^)())cancelBlock source:(ImagePickerSource)ips{
    
    
    _ImagePickFinish = successBlock;
    _ImagePickCancel = cancelBlock;
    
    if(ips == IPSGallery){
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
    }else if(ips == IPSCamera){
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:nil];

        
    }
    
}



-(void)ShowActionSheetForImagePickCompletion:(void(^)(UIImage * img))successBlock cancel:(void(^)())cancelBlock{

    
    _ImagePickFinish = successBlock;
    _ImagePickCancel = cancelBlock;
    
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:MCLocalString(@"Where do you want to choose your image") message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * gaAction = [UIAlertAction actionWithTitle:MCLocalString(@"Gallery") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:nil];
       
       
    }];
    UIAlertAction * caAction = [UIAlertAction actionWithTitle:MCLocalString(@"Camera") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];
    [alert addAction:gaAction];
    [alert addAction:caAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}

#pragma mark - UIImagePickerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSLog(@"image = %f",image.size.width);
    NSLog(@"image = %f",image.size.height);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if(!image ){
        
        [GD ShowAlertViewTitle:@"" message: @"There is no selected image." VC:self Ok:nil];
        if(_ImagePickFinish)
        _ImagePickFinish(nil);
        
        return;
    }
    if(_ImagePickFinish)
    _ImagePickFinish(image);
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if(_ImagePickCancel)
    _ImagePickCancel();
}




@end
