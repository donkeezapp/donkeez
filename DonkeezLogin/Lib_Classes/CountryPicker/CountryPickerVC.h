//
//  CountryPickerVC.h
//  SportsMatch
//
//  Created by Zhang RenJun on 6/16/16.
//  Copyright © 2016 Zhang RenJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryPicker.h"
@class CountryPickerVC;

@protocol CountryPickerVCDeldgate <NSObject>

@optional
-(void)CountryPickerVC:(CountryPickerVC*)cpVC didSelectCountryWithName:(NSString *)name code:(NSString *)code;

@end


@interface CountryPickerVC : UIViewController
@property (weak, nonatomic) IBOutlet CountryPicker *pickerCountry;

@property(weak, nonatomic)id<CountryPickerVCDeldgate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@end
