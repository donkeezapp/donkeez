//
//  VoteCell.m
//  Donkeez
//
//  Created by Zhang RenJun on 7/14/16.
//  Copyright © 2016 Backendless. All rights reserved.
//

#import "VoteCell.h"
#import "UIImageView+AFNetworking.h"

@implementation VoteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setVoteDetailImage:(NSString *)imagePath{
    
    _imgLogo.hidden = NO;   
    UIActivityIndicatorView * actLoader = [GD activityViewToView:_imgBack];
    
    [_imgLogo setMHImageWithURL:[NSURL URLWithString:imagePath] completion:^(NSError *error, NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [GD onMain:^{
            [actLoader stopAnimating];
        }];
        
    }];
    
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _imgLogo.image = nil;
    [_imgLogo cancelImageDownloadTask];
}


@end
