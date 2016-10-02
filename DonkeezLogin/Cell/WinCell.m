//
//  WinCell.m
//  Donkeez
//
//  Created by Zhang RenJun on 6/23/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "WinCell.h"
@interface WinCell()<UIScrollViewDelegate>


@end
@implementation WinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)prepareForReuse{
    
    _cont = nil;
    _lblContTags.text = @"";
    
    _cont1 = nil;
    _lblContTags1.text = @"";
    _cont2 = nil;
    _lblContTags2.text = @"";
    
    
}
-(void)setContData:(Contest*)cont cont1:(Contest*)cont1 cont2:(Contest*)cont2{
    
    
    
    _cont = cont;
    _cont1 = cont1;
    _cont2 = cont2;
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake([GD GetScreenSize].width, _scrollView.bounds.size.height)];
    if(_cont !=nil){
    _lblContTags.text = _cont.tags;
    
//    [_imgWinnerPost setMHImageWithURL:[NSURL URLWithString:cont.post_win.photo]];
    [_imgContMark setMHImageWithURL:[NSURL URLWithString:_cont.mark_image]];
    
        UIActivityIndicatorView * actLoader = [GD activityViewToView:_imgWinnerPost];
        
        [_imgWinnerPost setMHImageWithURL:[NSURL URLWithString:cont.post_win.photo] completion:^(NSError *error, NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [GD onMain:^{
                [actLoader stopAnimating];
            }];
            
        }];

        
        UserInfo *userInfo = [kAppDelegate GetUserInfo:cont.post_win.post_user];
        if(userInfo){
            [GD onMain:^{
                _postUserName.text  = isSet(userInfo.first_name)?userInfo.first_name:@"";
            }];
        }else{
            [GD onMain:^{
                _postUserName.text  = isSet([cont.post_win.post_user getProperty:@"firstname"])?[cont.post_win.post_user getProperty:@"firstname"]:@"";
            }];
        }

       
        
        
        [_scrollView setContentSize:_scrollView.frame.size];
        
    }
    
    if(_cont1 !=nil){
    _lblContTags1.text = _cont1.tags;
    
//    [_imgWinnerPost1 setMHImageWithURL:[NSURL URLWithString:_cont1.post_win.photo]];
    [_imgContMark1 setMHImageWithURL:[NSURL URLWithString:_cont1.mark_image]];
        
        UIActivityIndicatorView * actLoader = [GD activityViewToView:_imgWinnerPost1];
        
        [_imgWinnerPost1 setMHImageWithURL:[NSURL URLWithString:_cont1.post_win.photo] completion:^(NSError *error, NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [GD onMain:^{
                [actLoader stopAnimating];
            }];
            
        }];
        
        
        UserInfo *userInfo = [kAppDelegate GetUserInfo:cont1.post_win.post_user];
        if(userInfo){
            [GD onMain:^{
                _postUserName1.text  = isSet(userInfo.first_name)?userInfo.first_name:@"";
            }];
        }else{
            [GD onMain:^{
                _postUserName1.text  = isSet([cont1.post_win.post_user getProperty:@"firstname"])?[cont1.post_win.post_user getProperty:@"firstname"]:@"";
            }];
        }
  
        
        [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width*2, _scrollView.frame.size.height)];
    }
    
    if(_cont2 !=nil){
     
        _lblContTags2.text = _cont2.tags;
        
        
        [_imgContMark2 setMHImageWithURL:[NSURL URLWithString:_cont2.mark_image]];
        
        UIActivityIndicatorView * actLoader = [GD activityViewToView:_imgWinnerPost2];
        
        [_imgWinnerPost2 setMHImageWithURL:[NSURL URLWithString:_cont2.post_win.photo] completion:^(NSError *error, NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [GD onMain:^{
                [actLoader stopAnimating];
            }];
            
        }];

         UserInfo *userInfo = [kAppDelegate GetUserInfo:cont2.post_win.post_user];
        if(userInfo){
            [GD onMain:^{
                _postUserName2.text  = isSet(userInfo.first_name)?userInfo.first_name:@"";
            }];
        }else{
            [GD onMain:^{
                _postUserName2.text  = isSet([cont2.post_win.post_user getProperty:@"firstname"])?[cont2.post_win.post_user getProperty:@"firstname"]:@"";
            }];
        }

      
        [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width*3, _scrollView.frame.size.height)];
    }
    
    if(!cont1){
        _view2.hidden = YES;
    }
    if(!cont2){
        _view3.hidden = YES;
    }
    if(!cont){
        _view1.hidden = YES;
    }
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _pgControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
}



- (IBAction)onTapWin1:(id)sender {
    
    if(_cont != nil && [_delegate respondsToSelector:@selector(onTapWin:contest:)]){
        
        [_delegate onTapWin:1 contest:_cont];
    }
}


- (IBAction)onTapWin2:(id)sender {
    
    if(_cont1 != nil && [_delegate respondsToSelector:@selector(onTapWin:contest:)]){
        
        [_delegate onTapWin:2 contest:_cont1];
    }
}

- (IBAction)onTapWin3:(id)sender {
    
    if(_cont2 != nil && [_delegate respondsToSelector:@selector(onTapWin:contest:)]){
        
        [_delegate onTapWin:3 contest:_cont2];
    }
}

@end
