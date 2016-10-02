//
//  UserModel.m
//  SearchBook
//
//  Created by Admin on 4/5/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(instancetype)initWithDictionary : (NSDictionary *)dict
{

    if([dict isKindOfClass : [NSArray class]]){
        dict = (NSDictionary*) [(NSArray*)dict objectAtIndex : 0];
    }
    
    NSString * user_id = [dict objectForKey : @"accounts_id"] ;
    _user_id = user_id;
    if(!isSet(self.user_id)){
        self.user_id = @"";
    }
    
    self.first_name = [dict objectForKey : @"ai_first_name"];
    if(!isSet(self.first_name)){
        self.first_name = @"";
    }
    self.last_name = [dict objectForKey : @"ai_last_name"];
    if(!isSet(self.last_name)){
        self.last_name = @"";
    }

    self.email = [dict objectForKey : @"accounts_email"];
    if(!isSet(self.email)){
        self.email = @"";
    }
    self.avatar = [dict objectForKey : @"ai_image"];
    if(!isSet(self.avatar)){
        self.avatar = @"";
    }
    
    
    return self;
}




-(NSDictionary *)getDictForProfileUpdate{

    
    NSDictionary * data = [self getDictForSignup];
    
    return data;
    
}


-(NSDictionary *)getDictForSignup{
    

    return @{
             @"fname"  :  isSet(_first_name)?self.first_name  :  @"",
             @"lname"  :  isSet(_last_name)?self.last_name  :  @"",
             @"password"  :  isSet(_password)?_password  :  @"",
             @"email"     :  isSet(_email)?_email  :  @"",
             @"phone"    :  isSet(_phone)?_phone  :  @"",
             @"gender" :  isSet(_gender)?_gender  :  @"",
             @"age" :  @(_age),
             @"country" :  isSet(_country)?_country  :  @"",
             @"state" :  @"DEF_NULL",
             @"city" :  isSet(_city)?_city  :  @"",
             
             @"address" :  @"DEF_NULL",
             @"center_id" :  @"DEF_NULL",
             
             
             
             };
}

-(void)saveToLocal{
    

    NSDictionary * saveData = [self getDictForSignup];
    [GD WriteDefaultStore : saveData forKey : @"userData"];
    
}
-(void)removeFromLocal{
    
    [GD WriteDefaultStore : @{} forKey : @"userData"];
    
}

-(BOOL)readFromLocal{
    
    NSDictionary * dict = [GD ReadDefaultStoreforKey : @"userData"];
    
    if(!dict){
        return NO;
    }
    
    self.first_name = [dict objectForKey : @"firstName"];
    if(!isSet(self.first_name)){
        self.first_name = @"";
    }
    self.last_name = [dict objectForKey : @"lastName"];
    if(!isSet(self.last_name)){
        self.last_name = @"";
    }
    self.password = [dict objectForKey : @"password"];
    if(!isSet(self.password)){
        self.password = @"";
    }
    self.email = [dict objectForKey : @"email"];
    if(!isSet(self.email)){
        self.email = @"";
    }
    self.avatar = [dict objectForKey : @"avatar"];
    if(!isSet(self.avatar)){
        self.avatar = @"";
    }
    self.phone = [dict objectForKey : @"phone"];
    if(!isSet(self.phone)){
        self.phone = @"";
    }
 
    self.user_id = [dict objectForKey : @"user_id"];
    if(!isSet(self.user_id)){
        self.user_id = @"";
    }
    
    
    return YES;
}

-(NSString*)getUserName{
    
    
    return [NSString stringWithFormat : @"%@ %@", _first_name, _last_name];
    
}
@end



@implementation EventModel


-(instancetype)initWithDictionary : (NSDictionary *)dict{
    
    self.activity_title = [dict objectForKey : @"activity_title"];
    self.activity_title = isSet(self.activity_title)?self.activity_title : @"";
    
    self.activity_id = [dict objectForKey : @"activity_id"];
    self.activity_id = isSet(self.activity_id)?self.activity_id : @"";
    
    self.activity_email = [dict objectForKey : @"activity_email"];
    self.activity_email = isSet(self.activity_email)?self.activity_email : @"";
    
    self.activity_phone = [dict objectForKey : @"activity_phone"];
    self.activity_phone = isSet(self.activity_phone)?self.activity_phone : @"";
    
    self.activity_desc = [dict objectForKey : @"activity_desc"];
    self.activity_desc = isSet(self.activity_desc)?self.activity_desc : @"";
    
    self.thumbnail_image = [dict objectForKey : @"thumbnail_image"];
    self.thumbnail_image = isSet(self.thumbnail_image)?self.thumbnail_image : @"";
    
    NSString * activity_max_age_str = isSet([dict objectForKey : @"activity_max_age"])?[dict objectForKey : @"activity_max_age"] : @"-1";
    NSString * activity_min_age_str = isSet([dict objectForKey : @"activity_min_age"])?[dict objectForKey : @"activity_min_age"] : @"-1";
    
    self.activity_max_age = [activity_max_age_str integerValue];
    
    self.activity_min_age = [activity_min_age_str integerValue];
    
    NSString * activity_featured_from_str = isSet([dict objectForKey : @"activity_featured_from"])?[dict objectForKey : @"activity_featured_from"] : @"-1";
    self.activity_featured_from = [activity_featured_from_str integerValue];
    
    NSString * activity_featured_to_str = isSet([dict objectForKey : @"activity_featured_to"])?[dict objectForKey : @"activity_featured_to"] : @"-1";
    self.activity_featured_to = [activity_featured_to_str integerValue];
  
    
    _fromDate =[NSDate dateWithTimeIntervalSince1970 : _activity_featured_from];
    _toDate =[NSDate dateWithTimeIntervalSince1970 : _activity_featured_to];
    
    
    self.activity_type = [[dict objectForKey : @"activity_type"] integerValue];
    
    self.activity_sport = [GD getStringFrom:dict forKey:@"activity_sport"];
    NSString * activity_max_players_str = isSet([dict objectForKey : @"activity_max_players"])?[dict objectForKey : @"activity_max_players"] : @"-1";
    self.activity_max_players = [activity_max_players_str integerValue];
    
    
    self.activity_owner_fname = [dict objectForKey : @"activity_owner_fname"] ;
    

    self.activity_location = [dict objectForKey : @"activity_location"];
    self.activity_location = isSet(self.activity_location)?self.activity_location : @"";
    self.activity_latitude = [dict objectForKey : @"activity_latitude"];
    self.activity_latitude = isSet(self.activity_latitude)?self.activity_latitude : @"";
    self.activity_longitude = [dict objectForKey : @"activity_longitude"];
    self.activity_longitude = isSet(self.activity_longitude)?self.activity_longitude : @"";
    self.activity_mapaddress = [dict objectForKey : @"activity_mapaddress"];
    self.activity_mapaddress = isSet(self.activity_mapaddress)?self.activity_mapaddress : @"";
    
    self.customers_num = [GD getIntFrom:dict forKey:@"customers_num"];
    _activity_location_list = [[_activity_location componentsSeparatedByString:@","] mutableCopy];
    
    
    return self;

}


-(NSDictionary*)getDictToCreateActivity{
    
    
    NSDictionary * para =@{
                                @"activitystatus":@"Yes",
                                @"activityname":_activity_title,
                                @"activitydesc":_activity_desc,
                                @"activitystars":@(1),
                                @"activitytype":[GD intToString:_activity_type],
                                @"isfeatured":@"yes",
                                @"ffrom": [GD intToString:_activity_featured_from],
                                @"fto": [GD intToString:_activity_featured_to],
                                @"maxadult":@"1",
                                @"maxchild":@"",
                                @"maxinfant":@"",
                                @"adultprice":@"",
                                @"activityemail":_activity_email,
                                @"activitywebsite":@"",
                                @"activityfulladdress":@"",
                                @"activityphone":_activity_phone,
                                @"activitymetatitle":@"",
                                @"activitymetadesc":@"",
                                @"activitykeywords":@"",
                                @"activityprivacy":@"",
                                @"activityexclusions[]":@"254",
                                @"childprice":@"",
                                @"infantprice":@"",
                                @"activitydays":@"",
                                @"activitynights":@"",
                                @"locations[]":_activity_location_list,
                                @"deposittype":@"fixed",
                                @"depositvalue":@"",
                                @"taxtype":@"fixed",
                                @"taxvalue":@"",
                                @"relatedactivities[]":@"25",
                                @"activitymapaddress":_activity_mapaddress,
                                @"latitude":_activity_latitude,
                                @"longitude":_activity_longitude,
                                @"adultstatus":@"1",
                                @"childstatus":@"0",
                                @"infantstatus":@"0",
                                @"activitysport":_activity_sport,
                                @"activityminage": [GD intToString:_activity_min_age],
                                @"activitymaxage": [GD intToString:_activity_max_age],
                                @"activitymaxplayers": [GD intToString:_activity_max_players]
                                };
    
    return para;
    
}


@end



@implementation SportsModel


-(instancetype)initWithDictionary : (NSDictionary *)dict{
    

    self.sport_type = [dict objectForKey : @"sport_type"];
    self.sport_type = isSet(self.sport_type)?self.sport_type : @"";
    
    self.sport_name = [dict objectForKey : @"sport_name"];
    self.sport_name = isSet(self.sport_name)?self.sport_name : @"";
    
    self.sport_gender = [dict objectForKey : @"sport_gender"];
    self.sport_gender = isSet(self.sport_gender)?self.sport_gender : @"";
    

    NSString * sport_id_str = isSet([dict objectForKey : @"sport_id"])?[dict objectForKey : @"sport_id"] : @"-1";
    
    self.sport_id = [sport_id_str integerValue];
    
   
    
    return self;
    
}

@end

//TournamentModel

@implementation TournamentModel

-(instancetype)initWithDictionary : (NSDictionary *)dict{
    
    
    self.tournament_id = [[dict objectForKey : @"tournament_id"] integerValue];
    
    
    self.tournament_desc = [dict objectForKey : @"tournament_desc"];
    self.tournament_desc = isSet(self.tournament_desc)?self.tournament_desc : @"";
    
    self.tournament_location = [dict objectForKey : @"tournament_location"];
    self.tournament_location = isSet(self.tournament_location)?self.tournament_location : @"";
    
    self.tournament_type = [dict objectForKey : @"tournament_type"];
    self.tournament_type = isSet(self.tournament_type)?self.tournament_type : @"";
    
    self.tournament_mapaddress = [dict objectForKey : @"tournament_mapaddress"];
    self.tournament_mapaddress = isSet(self.tournament_mapaddress)?self.tournament_mapaddress : @"";
    
    self.tournament_sport = [dict objectForKey : @"tournament_sport"];
    self.tournament_sport = isSet(self.tournament_sport)?self.tournament_sport : @"";
    
    self.tournament_owner_email = [dict objectForKey : @"tournament_owner_email"];
    self.tournament_owner_email = isSet(self.tournament_owner_email)?self.tournament_owner_email : @"";
    
    self.tournament_owner_mobile = [dict objectForKey : @"tournament_owner_mobile"];
    self.tournament_owner_mobile = isSet(self.tournament_owner_mobile)?self.tournament_owner_mobile : @"";
    
    self.tournament_owner_fname = [dict objectForKey : @"tournament_owner_fname"];
    self.tournament_owner_fname = isSet(self.tournament_owner_fname)?self.tournament_owner_fname : @"";
    
    self.tournament_owner_lname = [dict objectForKey : @"tournament_owner_lname"];
    self.tournament_owner_lname = isSet(self.tournament_owner_lname)?self.tournament_owner_lname : @"";
    
    NSString * tournament_featured_from = isSet([dict objectForKey : @"tournament_featured_from"])?[dict objectForKey : @"tournament_featured_from"] : @"-1";
    
    self.tournament_featured_from = [tournament_featured_from integerValue];
    
    NSString * tournament_featured_to = isSet([dict objectForKey : @"tournament_featured_to"])?[dict objectForKey : @"tournament_featured_to"] : @"-1";
    
    self.tournament_featured_to = [tournament_featured_to integerValue];
    
    _fromDate = [NSDate dateWithTimeIntervalSince1970:_tournament_featured_from];
    _toDate = [NSDate dateWithTimeIntervalSince1970:_tournament_featured_to];
    
    
    NSString * tournament_min_age = isSet([dict objectForKey : @"tournament_min_age"])?[dict objectForKey : @"tournament_min_age"] : @"-1";
    
    self.tournament_min_age = [tournament_min_age integerValue];
    
    NSString * tournament_max_age = isSet([dict objectForKey : @"tournament_max_age"])?[dict objectForKey : @"tournament_max_age"] : @"-1";
    
    self.tournament_max_age = [tournament_max_age integerValue];
    
    NSString * tournament_max_players = isSet([dict objectForKey : @"tournament_max_players"])?[dict objectForKey : @"tournament_max_players"] : @"-1";
    
    self.tournament_max_players = [tournament_max_players integerValue];
    
    NSString * tournament_latitude = isSet([dict objectForKey : @"tournament_latitude"])?[dict objectForKey : @"tournament_latitude"] : @"-1";
    
    self.tournament_latitude = [tournament_latitude floatValue];
    
    NSString * tournament_longitude = isSet([dict objectForKey : @"tournament_longitude"])?[dict objectForKey : @"tournament_longitude"] : @"-1";
    
    self.tournament_longitude = [tournament_longitude integerValue];
    
    self.teams_num = [GD getIntFrom:dict forKey:@"teams_num"];
    
    self.thumbnail_image = [dict objectForKey : @"thumbnail_image"];
    self.thumbnail_image = isSet(self.thumbnail_image)?self.thumbnail_image : @"";
    return self;
    
}



-(NSDictionary *)getDictToCreateTournament{
    
    NSDictionary * para = @{
                            @"tournamentstatus" : @(YES),
                            @"tournamentname" : _tournament_title,
                            @"tournamentdesc" : _tournament_desc,
                            @"maxadult" : @"",
                            @"maxchild" : @"",
                            @"maxinfant" : @"",
                            @"adultprice" : @"",
                            @"childprice" : @"",
                            @"infantprice" : @"",
                            @"tournamentstars" : @(1),
                            @"tournamentdays" : @"",
                            @"tournamentnights" : @"",
                            @"tournamenttype" : _tournament_type,
                            @"isfeatured" : @(YES),
                            @"ffrom" : [GD intToString:_tournament_featured_from],
                            @"fto" : [GD intToString:_tournament_featured_to],
                            @"locations" : _tournament_location_list,
                            @"deposittype" : @"fixed",
                            @"depositvalue" : @"",
                            @"taxtype" : @"fixed",
                            @"taxvalue" : @"",
                            @"relatedtournaments[]" : @[],
                            @"tournamentmapaddress" : _tournament_mapaddress,
                            @"latitude" : @(_tournament_latitude),
                            @"longitude" : @(_tournament_longitude),
                            @"tournamentamenities[]" : @[],
                            @"tournamentexclusions[]" : @[],
                            @"tournamentmetatitle" : @"",
                            @"tournamentkeywords" : @"",
                            @"tournamentmetadesc" : @"",
                            @"tournamentprivacy" : @"",
                            @"tournamentemail" : _tournament_owner_email,
                            @"tournamentwebsite" : @"",
                            
                            @"tournamentphone" : _tournament_owner_mobile,
                            @"tournamentfulladdress" : @"",
                            @"tournamentid" : @"",
                            @"adultstatus" : @"1",
                            @"childstatus" : @"0",
                            
                            @"infantstatus" : @"0",
                            @"tournamentsport" : _tournament_sport,
                            @"tournamentminage" : @(_tournament_min_age),
                            @"tournamentmaxage" : @(_tournament_max_age),
                            @"tournamentmaxplayers" : @(_tournament_max_players)
                            
                            
                            };
    
    return  para;
    
    
}
@end


@implementation VenueModel


-(instancetype)initWithDict : (NSDictionary*)dict{
    
    self.venue_id = [GD getIntFrom:dict forKey:@"id"];
    self.country = [GD getStringFrom:dict forKey:@"country"];
    self.location = [GD getStringFrom:dict forKey:@"location"];
    self.latitude = [GD getStringFrom:dict forKey:@"latitude"];
    self.latitude = [GD getStringFrom:dict forKey:@"latitude"];
    
    self.user = [GD getStringFrom:dict forKey:@"user"];
    self.total = [GD getStringFrom:dict forKey:@"total"];
    self.status = [GD getStringFrom:dict forKey:@"status"];
    
    self.lat = [self.latitude floatValue];
    self.lon = [self.longitude floatValue];
    
    self.eventList = [NSMutableArray new];
    
    
    NSArray<NSDictionary*> * events = [GD getArrFrom:dict forKey:@"events"];
    
    if([events isKindOfClass:[NSArray class]]){
        for (NSDictionary * each in events) {
            EventModel * em = [[EventModel alloc] initWithDictionary:each];
            
            [self.eventList addObject:em];
            
        }
    }
  
    
    return self;
    
}



@end

@implementation NotificationModel

-(instancetype)initWithDict : (NSDictionary*)dict{
    

    
    self.push_id = [GD getStringFrom:dict forKey:@"push_id"];
    self.push_category = [GD getStringFrom:dict forKey:@"push_category"];
    self.push_action = [GD getStringFrom:dict forKey:@"push_action"];
    self.message = [GD getStringFrom:dict forKey:@"message"];
    self.created_at = [GD getStringFrom:dict forKey:@"created_at"];
    self.item_name = [GD getStringFrom:dict forKey:@"item_name"];
    self.createdDate = [NSDate dateWithTimeIntervalSince1970:[_created_at integerValue] ];
    return  self;
}

@end

@implementation TeamModel


-(NSDictionary *)getDictToCreateUpdate{
    
    //name :wangming2 team 2
    //description :Something descriptions
    //min_age :20
    //max_age :30
    //member_type :man
    //sport_type:2
    NSDictionary * para = @{
                            @"name":_name,
                            @"description":__description,
                            @"min_age":_team_min_age,
                            @"max_age":_team_max_age,
                            @"member_type":_team_member_type,
                            @"sport_type":_team_sport_type
                            
                            };
    
    return  para;
    
}

-(instancetype)initWithDict : (NSDictionary*)dict{
    

    
    self._id = [GD getStringFrom:dict forKey:@"id"];
    self.name = [GD getStringFrom:dict forKey:@"name"];
    self.accounts_id = [GD getStringFrom:dict forKey:@"accounts_id"];
    self._description = [GD getStringFrom:dict forKey:@"_description"];
    self.team_min_age = [GD getStringFrom:dict forKey:@"team_min_age"];
    self.team_max_age = [GD getStringFrom:dict forKey:@"team_max_age"];
    self.team_sport_type = [GD getStringFrom:dict forKey:@"team_sport_type"];
    self.team_member_type = [GD getStringFrom:dict forKey:@"team_member_type"];
    self.created_at = [GD getStringFrom:dict forKey:@"created_at"];
    self.updated_at = [GD getStringFrom:dict forKey:@"updated_at"];
    self.accounts_email = [GD getStringFrom:dict forKey:@"accounts_email"];
    
    return  self;
    
    
}

-(void)loadCenterOfTeam : (void(^)())success failed : (void(^)(NSString * err))failed{
    
//    [sAPIController getCenterDetailByID : [_center_id integerValue] success : ^(CenterModel *center) {
//        _centerOfTeam = center;
//        success();
//    } failed : ^(NSString *errorString) {
//        failed(errorString);
//    }];
    

    
}
-(void)loadPlayersOfTeamSucees : (void(^)())success failed : (void(^)(NSString * err))failed{

        
//        NSInteger teamId =[__id integerValue];
//    
//        [sAPIController getTeamUserListTeamId : teamId success : ^(NSArray *userList) {
//            
//            _players = [[NSMutableArray alloc] initWithArray : userList];
//
//            success();
//        } failed : ^(NSString *error) {
//            NSLog(@"%@", error);
//            
//            failed(error);
//        }];
    
    
}

@end



@implementation LocationModel

-(instancetype)initWithDict:(NSDictionary*)dict{

    self._id = [GD getStringFrom:dict forKey:@"id"];
    self.country = [GD getStringFrom:dict forKey:@"country"];
    self.location = [GD getStringFrom:dict forKey:@"location"];
    self.latitude = [GD getStringFrom:dict forKey:@"latitude"];
    self.longitude = [GD getStringFrom:dict forKey:@"longitude"];
    self.user = [GD getStringFrom:dict forKey:@"user"];
    
    return  self;
}

@end



@implementation ActivityModel


-(instancetype)initWithDict:(NSDictionary*)dict{
    

    
    self.activity_id = [GD getStringFrom:dict forKey:@"activity_id"];
    self.activity_title = [GD getStringFrom:dict forKey:@"activity_title"];
    self.activity_slug = [GD getStringFrom:dict forKey:@"activity_slug"];
    self.activity_desc = [GD getStringFrom:dict forKey:@"activity_desc"];
    self.activity_featured_from = [GD getStringFrom:dict forKey:@"activity_featured_from"];
    self.activity_featured_to = [GD getStringFrom:dict forKey:@"activity_featured_to"];
    self.activity_owned_by = [GD getStringFrom:dict forKey:@"activity_owned_by"];
    self.activity_type = [GD getStringFrom:dict forKey:@"activity_type"];
    self.activity_location = [GD getStringFrom:dict forKey:@"activity_location"];
    self.activity_latitude = [GD getStringFrom:dict forKey:@"activity_latitude"];
    self.activity_longitude = [GD getStringFrom:dict forKey:@"activity_longitude"];
    self.activity_mapaddress = [GD getStringFrom:dict forKey:@"activity_mapaddress"];
    self.activity_max_players = [GD getStringFrom:dict forKey:@"activity_max_players"];
    self.activity_min_age = [GD getStringFrom:dict forKey:@"activity_min_age"];
    self.activity_max_age = [GD getStringFrom:dict forKey:@"activity_max_age"];
    self.activity_email = [GD getStringFrom:dict forKey:@"activity_email"];
    self.activity_phone = [GD getStringFrom:dict forKey:@"activity_phone"];
    self.activity_sport = [GD getStringFrom:dict forKey:@"activity_sport"];
    self.activity_fulladdress = [GD getStringFrom:dict forKey:@"activity_fulladdress"];
    self.activity_created_at = [GD getStringFrom:dict forKey:@"activity_created_at"];
    self.thumbnail_image = [GD getStringFrom:dict forKey:@"thumbnail_image"];
    self.customers_num = [GD getStringFrom:dict forKey:@"customers_num"];
    
    return  self;
    
}

-(NSDictionary *)getDictToCreateActivity{
    
    NSDictionary * para = @{
                            @"activitystatus":@"Yes",
                            @"activityname":_activityname,
                            @"activitydesc":_activitydesc,
                            @"activitystars":@(3),
                            @"activitytype":_activitytype,
                            @"isfeatured":@"yes",
                            @"ffrom":_ffrom,
                            @"fto":_fto,
                            @"maxadult":@(1),
                            @"maxchild":@"",
                            @"maxinfant":@"",
                            @"adultprice":@"",
                            @"activityemail":_activityemail,
                            @"activitywebsite":@"",
                            @"activityfulladdress":@"",
                            @"activityphone":_activityphone,
                            @"activitymetatitle":@"",
                            @"activitymetadesc":@"",
                            @"activitykeywords":@"",
                            @"activityprivacy":@"",
                            @"activityexclusions":@[@(264)],
                            @"childprice":@"",
                            @"infantprice":@"",
                            @"activitydays":@"",
                            @"activitynights":@"",
                            @"locations":_locations,
                            @"deposittype":@"fixed",
                            @"depositvalue":@"",
                            @"taxtype":@"fixed",
                            @"taxvalue":@"",
                            @"relatedactivities":@[@(35)],
                            @"activitymapaddress":_activitymapaddress,
                            @"latitude":_latitude,
                            @"longitude":_longitude,
                            @"adultstatus":@(1),
                            @"childstatus":@(0),
                            @"infantstatus":@(0),
                            @"activitysport":_activitysport,
                            @"activityminage":_activityminage,
                            @"activitymaxage":_activitymaxage,
                            @"activityminage":_activityminage,
                            @"activitymaxplayers":_activitymaxplayers,
                            };
    
    return  para;
    
}



@end

@implementation BookModel


-(void)initWithDict : (NSDictionary*)dict{
    
    self.bookingID = [dict objectForKey : @"bookingID"];
    if(!isSet(self.bookingID)){
        self.bookingID = @"";
    }
    self.checkin = [dict objectForKey : @"checkin"];
    if(!isSet(self.checkin)){
        self.checkin = @"";
    }
    self.date = [dict objectForKey : @"date"];
    if(!isSet(self.date)){
        self.date = @"";
    }
    self.bookingUser = [dict objectForKey : @"bookingUser"];
    if(!isSet(self.bookingUser)){
        self.bookingUser = @"";
    }
    
    self.userFullName = [dict objectForKey : @"userFullName"];
    if(!isSet(self.userFullName)){
        self.userFullName = @"";
    }
    
    self.userMobile = [dict objectForKey : @"userMobile"];
    if(!isSet(self.userMobile)){
        self.userMobile = @"";
    }
    
    self.subItem = [dict objectForKey : @"subItem"];
    if(!self.subItem){
        self.subItem = @{};
    }
    
    self.location = [dict objectForKey : @"location"];
    if(!isSet(self.location)){
        self.location = @"";
    }
    
    self.bookingDate = [dict objectForKey : @"bookingDate"];
    if(!isSet(self.bookingDate)){
        self.bookingDate = @"";
    }
    
    self.thumbnail = [dict objectForKey : @"thumbnail"];
    if(!isSet(self.thumbnail)){
        self.thumbnail = @"";
    }
    
    self.status = [dict objectForKey : @"status"];
    if(!isSet(self.status)){
        self.status = @"";
    }
    
    self.accountEmail = [dict objectForKey : @"accountEmail"];
    if(!isSet(self.accountEmail)){
        self.accountEmail = @"";
    }
    self.teamName = [dict objectForKey : @"teamName"];
    if(!isSet(self.teamName)){
        self.teamName = @"";
    }
    
}




-(NSDate *)getBookingDate{
    
    NSDateFormatter * df = [NSDateFormatter new];
    [df setDateFormat : @"dd/MM/yyyy"];
    
    return  [df dateFromString : _bookingDate];
    
    
}
-(NSDate *)getCheckInDate{
    
    NSDateFormatter * df = [NSDateFormatter new];
    [df setDateFormat : @"dd/MM/yyyy"];
    
    return  [df dateFromString : _checkin];
    
    
}
-(NSDate *)getDate{
    
    NSDateFormatter * df = [NSDateFormatter new];
    [df setDateFormat : @"dd/MM/yyyy"];
    
    return  [df dateFromString : _date];
    
    
}

@end


@implementation TeamUserModel



-(void)initWithDict : (NSDictionary*)dict{
    
    
//    "id" :  "814",
    //                    "token" :  "erxwJhAgbnaqdNuwAgHQAsDSVo6xmi8BJG8tYJK9",
    //                    "token_created_at" :  "1465788092",
    //                    "token_expired_at" :  "1465960892",
    //                    "accounts_id" :  "457",
    //                    "token_type" :  "customer",
    //                    "ai_title" :  "0",
    //                    "ai_first_name" :  "0",
    //                    "ai_last_name" :  "0",
    //                    "accounts_email" :  "zhengyunxm@gmail.com",
    //                    "accounts_password" :  "7c4a8d09ca3762af61e59520943dc26494f8941b",
    //                    "ai_dob" :  null,
    //                    "ai_country" :  "US",
    //                    "ai_state" :  "WA",
    //                    "ai_city" :  "Seattle",
    //                    "ai_address_1" :  "0",
    //                    "ai_address_2" :  "0",
    //                    "ai_mobile" :  "15104338495",
    //                    "ai_fax" :  "0",
    //                    "ai_postal_code" :  "0",
    //                    "ai_passport" :  null,
    //                    "ai_website" :  null,
    //                    "ai_image" :  "457-avatar.jpg",
    //                    "accounts_type" :  "customers",
    //                    "accounts_is_admin" :  "0",
    //                    "accounts_created_at" :  "2016-06-10 06 : 32 : 11",
    //                    "accounts_updated_at" :  "2016-06-13 03 : 07 : 50",
    //                    "accounts_status" :  "yes",
    //                    "accounts_verified" :  "1",
    //                    "accounts_last_login" :  "1465540331",
    //                    "accounts_permissions" :  null,
    //                    "appliedfor" :  null,
    //                    "facebook_id" :  null,
    //                    "center_id" :  "68"
    
    //    "response" :  {
    //        "id" :  "407",
    //        "user_id" :  "378",
    //        "team_id" :  "36",
    //        "apply_date" :  "1464549586",
    //        "accept_date" :  null,
    //        "status" :  "No",
    //        "email" :  "xingming@163.com",
    //        "mobile" :  "15104338495",
    //        "center_id" :  "68"
    //    }
    
//    "id" :  "437",
//    "user_id" :  "459",
//    "team_id" :  "82",
//    "apply_date" :  "1465809519",
//    "accept_date" :  "1465809610",
//    "status" :  "Yes",
//    "first_name" :  "z",
//    "last_name" :  "y",
//    "email" :  "zhengyunxm@gmail.com",
//    "mobile" :  "15104338473",
//    "avatar" :  "http : //bubblebump.org/uploads/images/users/459-avatar.jpg",
//    "center_id" :  "68"


    self._id = [dict objectForKey : @"id"];
    if(!isSet(self._id)){
        self._id = @"";
    }
    self.user_id = [dict objectForKey : @"user_id"];
    
    if(!isSet(self.user_id)){
        self.user_id = [dict objectForKey : @"accounts_id"];
        self.user_id = isSet(_user_id)?_user_id : @"";
    }
    
    self.team_id = [dict objectForKey : @"team_id"];
    if(!isSet(self.team_id)){
        self.team_id = @"";
    }
    
    
    self.first_name = [dict objectForKey : @"fname"];
    NSString * firstName = [dict objectForKey : @"first_name"];
    NSString * lastName = [dict objectForKey : @"last_name"];
    
    if(isSet(firstName)){
        _first_name = firstName;
    }
    _first_name = isSet(_first_name)?_first_name : [dict objectForKey : @"ai_first_name"];
    
    
    if(!isSet(self.first_name)){
        self.first_name = @"";
    }
    self.last_name = [dict objectForKey : @"lname"];
    
    if(isSet(lastName)){
        _last_name = lastName;
    }
    
    _last_name = isSet(_last_name)?_last_name : [dict objectForKey : @"ai_last_name"];
    if(!isSet(self.last_name)){
        self.last_name = @"";
    }
    self.email = [dict objectForKey : @"email"];
    if(!isSet(self.email)){
        self.email = @"";
    }
    self.avatar = [dict objectForKey : @"avatar"];
    if(!isSet(self.avatar)){
        
        _avatar = [dict objectForKey : @"ai_image"];
        self.avatar = isSet(_avatar)?_avatar : @"";
    }
    self.center_id = [dict objectForKey : @"center_id"];
    if(!isSet(self.center_id)){
        self.center_id = @"";
    }
    
    self.mobile = [dict objectForKey : @"mobile"];
    if(!isSet(self.mobile)){
        self.mobile = @"";
    }
    
    NSString * accd = [dict objectForKey : @"accept_date"];
    if(!isSet(accd)){
        accd = @"";
    }
    
    NSString * appd = [dict objectForKey : @"apply_date"];
    if(!isSet(appd)){
        appd = @"";
    }
    
    self.accept_date = [accd integerValue];
    self.apply_date = [appd integerValue];
    
    self.status = [[dict objectForKey : @"status"] boolValue];
    
}


-(NSDate *)getApplyDate
{
    
    NSDate * res = [NSDate dateWithTimeIntervalSince1970 : self.apply_date];
    
    return res;
    
}
-(NSDate *)getAcceptDate{
    NSDate * res = [NSDate dateWithTimeIntervalSince1970 : self.accept_date];
    
    return res;
}

@end


@implementation CreateBookModel


-(NSDictionary*)getDictionaryToBooking{
    
    NSDictionary * dict = @{
                            
                            @"userid" : _userid,
                            @"additionalnotes" : self.additionalnotes,
                            @"itemid" : self.itemid,
                            @"checkin" : self.checkin,
                            @"adults" : self.adults,
                            @"children" : self.children,
                            @"infant" : self.infant,
                            @"btype" : self.btype,
                            @"team_id" : self.team_id
                            
                            };
    
    return dict;
}





@end


@implementation PayModel


-(NSDictionary*)getDictionaryToPay{
    
    NSDictionary * res = @{
                           @"firstname" : _firstname,
                           @"lastname" : _lastname,
                           @"cardnum" : _cardnum,
                           @"cardtype" : _cardtype,
                           @"expMonth" : _expMonth,
                           @"expYear" : _expYear,
                           @"cvv" : _cvv,
                           
                           @"postcode" : _postcode,
                           
                           @"paymethod" : _paymethod,
                           @"bookingid" : _bookingid,
                           @"refno" : _refno
                           
                           };
    
    return  res;
    
    
}

@end