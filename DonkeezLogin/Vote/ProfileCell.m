//
//  ProfileCell.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)GetUserInfo:(BackendlessUser * )user completion:(void(^)(UserInfo* uinfo))completion{
    
    BackendlessDataQuery *query = [BackendlessDataQuery new];
    
    query.whereClause = [NSString stringWithFormat:@"user_id = \'%@\'", user.userId ];
    NSLog(@"whereClausre : %@", query.whereClause );
    QueryOptions *queryOptions = [QueryOptions new];
    
    query.queryOptions = queryOptions;
    id<IDataStore> dsUI = [backendless.persistenceService of:[UserInfo class]];
    
    
    [dsUI find:^(BackendlessCollection *becoll) {
        
        if(becoll.data.count > 0){
            UserInfo * ui = [becoll.data objectAtIndex:0];
            completion(ui);
            
        }else{
            completion(nil);
        }
        
        
    } error:^(Fault * fault) {
        completion(nil);
    }];
    
}
-(void)setProfileUserInfo:(UserInfo*)userinfo{
    
   
    NSString * urlPath = userinfo.avatar;
    NSLog(@"ProfileCell avatar url : %@", urlPath);
    [_imgAvatar makeCircled];
    [_imgAvatar setImage:[UIImage imageNamed:@"dummy-avatar.png"]];
    if(isSet(urlPath)){
        UIActivityIndicatorView * act = [GD activityViewToView:_imgAvatar];
        
        [_imgAvatar setMHImageWithURL:[NSURL URLWithString:urlPath] completion:^(NSError *error, NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [act stopAnimating];
        }];
    }
    
    NSString * fname =userinfo.first_name;
 
  _lblName.text = isSet(fname)?fname : @"";
}


-(void)setProfileUser:(BackendlessUser*)user{
    
    _user = user;
    [_imgAvatar makeCircled];
    [self GetUserInfo:user completion:^(UserInfo *userInfo) {
       
        [GD onMain:^{
            
            if(userInfo){
                _ui = userInfo;
                NSLog(@"name first : %@", userInfo.first_name);
                NSString * urlPath = [_user getProperty:@"avatar"];
                if(!isSet(urlPath)) urlPath = userInfo.avatar;
                if(isSet(urlPath)){
                    [_imgAvatar setMHImageWithURL:[NSURL URLWithString:urlPath]];
                }
                
                NSString * fname = [_user getProperty:@"firstname"];
                if(!isSet(fname)) fname = userInfo.first_name;
                _lblName.text = isSet(fname)?fname : @"";
            }else{
                NSString * urlPath = [_user getProperty:@"avatar"];
                
                if(isSet(urlPath)){
                    [_imgAvatar setMHImageWithURL:[NSURL URLWithString:urlPath]];
                }
                
                NSString * fname = [_user getProperty:@"firstname"];
                
                _lblName.text = isSet(fname)?fname : @"";
            }
            
        }];
        
        
    }];
    
 
    
}


- (IBAction)onShare:(id)sender {
    
    if([_delegate respondsToSelector:@selector(onTappedShare:user:)]){
        
        [_delegate onTappedShare:self user:_user];
        
        
    }
    
    
}



@end
