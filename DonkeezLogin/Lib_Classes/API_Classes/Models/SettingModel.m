//
//  SettingModel.m
//  SportsMatch
//
//  Created by Zhang RenJun on 6/17/16.
//  Copyright © 2016 Zhang RenJun. All rights reserved.
//

#import "SettingModel.h"



@implementation SettingModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    self.accounts_id = [[dict objectForKey:@"accounts_id"] integerValue];
    self._id = [[dict objectForKey:@"id"] integerValue];
    
    self.activity_types = [dict objectForKey:@"activity_types"];
    self.activity_types = isSet(self.activity_types)?self.activity_types:@"";
    
    
    self.tournament_types = [dict objectForKey:@"tournament_types"];
    self.tournament_types = isSet(self.tournament_types)?self.tournament_types:@"";
    
    self.sport_types = [dict objectForKey:@"sport_types"];
    self.sport_types = isSet(self.sport_types)?self.sport_types:@"";
    
    
    NSString * min_age = isSet([dict objectForKey:@"min_age"])?[dict objectForKey:@"min_age"]:@"-1";
    
    self.min_age = [min_age integerValue];
    
    NSString * max_age = isSet([dict objectForKey:@"max_age"])?[dict objectForKey:@"max_age"]:@"-1";
    
    self.max_age = [max_age integerValue];
    
    NSString * updated_at = isSet([dict objectForKey:@"updated_at"])?[dict objectForKey:@"updated_at"]:@"-1";
    
    self.updated_at = [updated_at integerValue];
    
    
    _sport_types_list = [[NSArray arrayWithArray:[_sport_types componentsSeparatedByString:@","]] mutableCopy];
    _activity_types_list = [[NSArray arrayWithArray:[_activity_types componentsSeparatedByString:@","]] mutableCopy];
    _tournament_types_list = [[NSArray arrayWithArray:[_tournament_types componentsSeparatedByString:@","]] mutableCopy];
    
    
    return self;
    
}


-(NSDictionary *)getSaveDict{
    
    NSArray * activitytypes = [NSArray arrayWithArray: _activity_types_list];
    NSArray * tournamenttypes = [NSArray arrayWithArray: _tournament_types_list];
    NSArray * sporttypes = [NSArray arrayWithArray: _sport_types_list];
    
    NSDictionary * ret = @{
                           @"minage":@(_min_age),
                           @"maxage":@(_max_age),
                           @"activitytypes":activitytypes,
                           @"tournamenttypes":tournamenttypes,
                           @"sporttypes":sporttypes
                           };
    return ret;
}


@end