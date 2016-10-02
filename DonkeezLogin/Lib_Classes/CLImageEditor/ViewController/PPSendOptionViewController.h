//
//  PPSendOptionViewController.h
//  SnapStream
//
//  Created by Admin on 11/9/15.
//  Copyright © 2015 Cyrusdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPSendOptionViewControllerDelegate;

@interface PPSendOptionViewController : UIViewController

@property (nonatomic,weak)id<PPSendOptionViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblPublic;
@property (weak, nonatomic) IBOutlet UILabel *lblPrivate;
@property (weak, nonatomic) IBOutlet UIImageView *imgPublic;
@property (weak, nonatomic) IBOutlet UIImageView *imgPrivate;
@property (weak, nonatomic) IBOutlet UIView *viewOption;

@end

@protocol PPSendOptionViewControllerDelegate <NSObject>
@optional


- (void)didSelectedSendOption:(PPSendOptionViewController*)viewController andOptionString:(NSString*)sendOpt;

@end