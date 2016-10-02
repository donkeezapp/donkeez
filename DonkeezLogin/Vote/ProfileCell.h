//
//  ProfileCell.h
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProfileCell;
@protocol ProfileCellDelegate <NSObject>

@optional
-(void)onTappedShare:(ProfileCell*)cell user:(BackendlessUser*)user;


@end

@interface ProfileCell : UITableViewCell

@property(weak, nonatomic)id<ProfileCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnShate;

@property(nonatomic, strong)UserInfo * ui;
@property(nonatomic, strong)BackendlessUser * user;

-(void)setProfileUserInfo:(UserInfo*)userinfo;
-(void)setProfileUser:(BackendlessUser*)user;
@end
