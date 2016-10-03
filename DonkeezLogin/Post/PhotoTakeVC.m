//
//  PhotoTakeVC.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/13/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "PhotoTakeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "PhotoFilterVC.h"
@interface PhotoTakeVC ()


@property(nonatomic, strong)AVCaptureSession * session;
@property(nonatomic, strong)AVCaptureStillImageOutput * stillImageOutput;
@property(nonatomic, strong)AVCaptureVideoPreviewLayer * videoPreviewLayer;

@property(nonatomic, strong)UIImage * capturedImage;

@end

@implementation PhotoTakeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)localize{
    [_btnBack setTitle:MCLocalString(@"Back") forState:UIControlStateNormal];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _session = [AVCaptureSession new];
    _session.sessionPreset = AVCaptureSessionPresetHigh;
     AVCaptureDevice * backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError * error;
    AVCaptureDeviceInput * input = [[AVCaptureDeviceInput alloc] initWithDevice:backCamera error:&error];
    
    
    if(error!=nil){
        NSLog(@"error: capture device.");
    }
    
    if( error == nil && [_session canAddInput:input] ){

        [_session addInput:input];
        _stillImageOutput = [AVCaptureStillImageOutput new];
        _stillImageOutput.outputSettings = @{ AVVideoCodecKey:AVVideoCodecJPEG};
        
        
    }
    
    if ([_session canAddOutput:_stillImageOutput] ){
        [_session addOutput:_stillImageOutput];
    }
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _videoPreviewLayer.videoGravity =AVLayerVideoGravityResizeAspectFill;
    
    _videoPreviewLayer.frame = CGRectMake(0, 0, [GD GetScreenSize].width, [GD GetScreenSize].width) ;
    
    [_viewCap.layer addSublayer:_videoPreviewLayer];
    [_session startRunning];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    
    if ([device hasTorch] && [device hasFlash]){
        
        //        if (device.flashMode == AVCaptureFlashModeOff) {
        
        //            [device setTorchMode:AVCaptureTorchModeOn];
        [_session beginConfiguration];
        [device lockForConfiguration:nil];
        [device setFlashMode:AVCaptureFlashModeOff];
        
        [device unlockForConfiguration];
        
        
        [_session commitConfiguration];
        //        }
        [_btnFlash setSelected:NO];
    }
}

-(void)switchFrontToBack
{
    if(_session)
    {
        [_session beginConfiguration];
        
        AVCaptureInput *currentCameraInput = [_session.inputs objectAtIndex:0];
        
        [_session removeInput:currentCameraInput];
        
        AVCaptureDevice *newCamera = nil;
        
        if(((AVCaptureDeviceInput*)currentCameraInput).device.position == AVCaptureDevicePositionBack)
        {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
        }
        else
        {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
        
        NSError *err = nil;
        
        AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:newCamera error:&err];
        
        if(!newVideoInput || err)
        {
            NSLog(@"Error creating capture device input: %@", err.localizedDescription);
        }
        else
        {
            [_session addInput:newVideoInput];
        }
        
        [_session commitConfiguration];
    }
    
    
    
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position)
            return device;
    }
    return nil;
}


- (void) toggleTorch {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device hasTorch] && [device hasFlash]){
        
        if (device.flashMode == AVCaptureFlashModeOff) {
            
            NSLog(@"It's currently off.. turning on now.");
            
            
            [_session beginConfiguration];
            [device lockForConfiguration:nil];
            
//            [device setTorchMode:AVCaptureTorchModeOn];
            [device setFlashMode:AVCaptureFlashModeOn];
            
            
            [device unlockForConfiguration];
            
            
            [_session commitConfiguration];

            
            [_btnFlash setSelected:YES];

        }
        else {
            
            NSLog(@"It's currently on.. turning off now.");
            
            
            [_session beginConfiguration];
            [device lockForConfiguration:nil];
            
//            [device setTorchMode:AVCaptureTorchModeOff];
            [device setFlashMode:AVCaptureFlashModeOff];
            
            
            [device unlockForConfiguration];
            
            
            [_session commitConfiguration];
            
       
            
            [_btnFlash setSelected:NO];
            
        }
        
    }
    
}

-(IBAction)powerBtn
{
    [self toggleTorch];
}

- (IBAction)onSwitch:(id)sender {
    
    [self switchFrontToBack];
}

- (IBAction)onFlash:(id)sender {
    
    [self toggleTorch];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
 

    
}

- (IBAction)onBack:(id)sender {
    
    if(self.navigationController != nil){
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [self dismissMoviePlayerViewControllerAnimated];
        
    }
}


- (IBAction)btnTake:(id)sender {
    
    AVCaptureConnection * videoConnection = [_stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if(videoConnection){
        // ...
        // Code for photo capture goes here...
        [_stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if(imageDataSampleBuffer != nil){
                
                NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                CFDataRef cd = CFDataCreate(NULL, [imageData bytes], [imageData length]);
                CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData(cd);
                
                CGImageRef cgImg = CGImageCreateWithJPEGDataProvider(dataProvider, nil, YES, kCGRenderingIntentDefault);
                
                AVCaptureInput *currentCameraInput = [_session.inputs objectAtIndex:0];
                
                if(((AVCaptureDeviceInput*)currentCameraInput).device.position == AVCaptureDevicePositionBack){
                    _capturedImage = [UIImage imageWithCGImage:cgImg scale:1.0 orientation:UIImageOrientationRight];
                }else{
                    _capturedImage = [UIImage imageWithCGImage:cgImg scale:1.0 orientation:UIImageOrientationLeftMirrored];
                }
                
                
                [GD onMain:^{
                    PhotoFilterVC * pVC = [[PhotoFilterVC  alloc] initWithNibName:@"PhotoFilterVC" bundle:nil];
                    pVC.capImage = _capturedImage ;
                    pVC.curContest = _curContest;
                    pVC.ips = IPSCamera;
                    [self.navigationController pushViewController:pVC animated:YES];
                }];
            }
            
        }];
       
    }else{
        [GD onMain:^{
            PhotoFilterVC * pVC = [[PhotoFilterVC  alloc] initWithNibName:@"PhotoFilterVC" bundle:nil];
            pVC.curContest = _curContest;
//            pVC.capImage = _capturedImage ;
            
            [self.navigationController pushViewController:pVC animated:YES];
            
        }];

    }
    
}

- (IBAction)btnPhoto:(id)sender {
    
    
}
- (IBAction)btnPeli:(id)sender {
    
   [self ShowActionSheetForImagePickCompletion:^(UIImage *img) {
       _capturedImage = img;
       [GD onMain:^{
           PhotoFilterVC * pVC = [[PhotoFilterVC  alloc] initWithNibName:@"PhotoFilterVC" bundle:nil];
           pVC.capImage = _capturedImage ;
           pVC.curContest = _curContest;
           pVC.ips = IPSGallery;
           [self.navigationController pushViewController:pVC animated:YES];
           
       }];
       

   } cancel:^{
       
   } source:IPSGallery];
    
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
