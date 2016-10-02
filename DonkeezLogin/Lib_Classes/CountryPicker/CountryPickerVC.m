//
//  CountryPickerVC.m
//  SportsMatch
//
//  Created by Zhang RenJun on 6/16/16.
//  Copyright © 2016 Zhang RenJun. All rights reserved.
//

#import "CountryPickerVC.h"

@interface CountryPickerVC ()<CountryPickerDelegate>
@end

@implementation CountryPickerVC



- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerCountry.delegate = self;
    [self.view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{

    if([_delegate respondsToSelector:@selector(CountryPickerVC:didSelectCountryWithName:code:)]){
        
        [_delegate CountryPickerVC:self didSelectCountryWithName:name code:code];
        
    }
    
    
}

- (IBAction)onDone:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
