//
//  SettingModel.h
//  SportsMatch
//
//  Created by Zhang RenJun on 6/17/16.
//  Copyright © 2016 Zhang RenJun. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SettingModel : NSObject

@property(nonatomic)NSInteger  _id;
@property(nonatomic)NSInteger  accounts_id;


@property(nonatomic, strong)NSString * activity_types;
@property(nonatomic, strong)NSString * tournament_types;
@property(nonatomic, strong)NSString * tournament_mapaddress;
@property(nonatomic, strong)NSString * sport_types;
@property(nonatomic, strong)NSString * nearby_distance;

@property(nonatomic)NSInteger  updated_at;
@property(nonatomic)NSInteger  min_age;
@property(nonatomic)NSInteger  max_age;

@property(nonatomic, strong)NSMutableArray * activity_types_list;
@property(nonatomic, strong)NSMutableArray * tournament_types_list;
@property(nonatomic, strong)NSMutableArray * sport_types_list;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
-(NSDictionary *)getSaveDict;

@end

