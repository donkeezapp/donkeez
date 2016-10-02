//
//  APIController.m
//  BubbleBump
//
//  Created by Admin on 5/22/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "APIController.h"

@implementation APIController

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
    });
    
    return sharedInstance;
}


-(void)LogInEmail:(NSString*)eMail pwd:(NSString*)pwd  Success:(void (^)(UserModel* user))success  failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    eMail = isSet(eMail)?eMail : @"";
    pwd = isSet(pwd)?pwd : @"";
    
    NSDictionary * pa = @{@"email":eMail, @"password":pwd};

    
    
    [sAPIClient PostRequestWithSubUrl:@"api/user/login" Params:pa success:^(id responseObject) {

        NSDictionary * res = [responseObject objectForKey:@"response"];
        
        if([res isKindOfClass:[NSDictionary class]]){
            BOOL status = [[res objectForKey:@"status"] boolValue];
            
            
            if(status){
                NSDictionary * data = [res objectForKey:@"data"];
                
                NSDictionary * userDict = [data objectForKey:@"user"];
                
                if([userDict isKindOfClass:[NSArray class]]){
                    userDict = [(NSArray*)userDict objectAtIndex:0];
                    
                }
                
                UserModel * um = [[UserModel alloc] initWithDictionary:userDict];
                success(um);
                self.curUser = [[UserModel alloc] initWithDictionary:userDict];
                self.curUser.password  = pwd;
                [self.curUser saveToLocal];
                NSString  * accToken = [data objectForKey:@"access_token"];
                sAPIClient.access_token = accToken;
                sAPIClient.token_type = @"";
                
                
            }else{
                NSString * msg = [res objectForKey:@"message"];
                
                    failure(responseObject, msg);
            }
        }else{
            failure(responseObject, @"Failed to login.");
        }
        
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Failed to login.");
    }];
    
    
}

-(void)SignUpWithUserModel:(UserModel*)um Success:(void (^)(UserModel* user))success  failure:(void (^)(id responseObj, NSString *errorString))failure{

    NSDictionary * para = [um getDictForSignup];
    NSString * subUrl  = @"api/user/signup";
    
    NSData * imgData = UIImageJPEGRepresentation(um.avatarImage, 0.8);
    
   
    
    [sAPIClient PostMultiPartRequestWithSubUrl:subUrl imageData:imgData keyForImage:@"photo" Params:para success:^(id responseObject) {

        
        NSDictionary * res = [responseObject objectForKey:@"response"];
        BOOL status = [[res objectForKey:@"status"] boolValue];
        NSString * msg = [res objectForKey:@"message"];
        if(status){
            [GD SaveAvatar:um.avatarImage];
            success(um);
        }else{
            failure(responseObject, msg);
        }
        
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj ,errorString);
    }];
    
}


-(void)profileUpdate:(UserModel *)um Success:(void (^)(UserModel* user))success  failure:(void (^)(id responseObj, NSString *errorString))failure{
    NSDictionary * para = [um getDictForSignup];
    NSString * subUrl  = @"api/user/profile";
     NSData * imgData = UIImageJPEGRepresentation(um.avatarImage, 0.8);
    
    
    [sAPIClient PostMultiPartRequestWithSubUrl:subUrl imageData:imgData keyForImage:@"photo" Params:para success:^(id responseObject) {
        
        
        NSDictionary * res = [responseObject objectForKey:@"response"];
        BOOL status = [[res objectForKey:@"status"] boolValue];
        NSString * msg = [res objectForKey:@"message"];
        if(status){
            NSDictionary * data = [res objectForKey:@"data"];
            NSArray * profile = [data objectForKey:@"profile"];
            
            NSDictionary * each = [profile objectAtIndex:0];
            
            UserModel * user = [[UserModel alloc] initWithDictionary:each];
            
            success(user);
        }else{
            failure(responseObject, msg);
        }
        
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj ,errorString);
    }];
    


   
}

-(void)ConfirmSignUpWithEmail:(NSString*)email SMSCode:(NSString*)smscode Success:(void (^)(UserModel* user))success  failure:(void (^)(id responseObj, NSString *errorString))failure{
    

    
    NSDictionary * para = @{
                            @"email":email,
                            @"smscode":smscode
                            
                            };
    NSString * subUrl  = @"api/user/signup/confirm";
    
 
    [sAPIClient PostRequestWithSubUrl:subUrl Params:para success:^(id responseObject) {
        
        NSDictionary * res = [responseObject objectForKey:@"response"];
        BOOL status = [[res objectForKey:@"status"] boolValue];
        NSString * msg = [res objectForKey:@"message"];
        
        if(status){
            NSDictionary * data = [res objectForKey:@"data"];
            NSDictionary * profile = [data objectForKey:@"profile"];
            UserModel * um = [[UserModel alloc] initWithDictionary:profile];
            
            success(um);
        }else{
            failure(responseObject, msg);
        }

    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj ,errorString);
    }];
    
 
}


-(void)GetActivityListSuccess:(void (^)(NSArray<EventModel *> * centerList))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{

    
    NSString * subUrl  = @"api/activity/list/all";
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
       
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * res = [responseObject objectForKey:@"response"];
            if([res isKindOfClass:[NSArray class]]){
                NSMutableArray<EventModel*> * resArr = [[NSMutableArray alloc]init];
                for(NSDictionary * each in res){
                    EventModel * cm = [[EventModel alloc] initWithDictionary:each];
                    [resArr addObject:cm];
                }
                
                success(resArr);
                
            }else{
                
                NSString * msg = [res objectForKey:@"message"];
                
                failure(responseObject, msg);
            }
            
            
        }else{
            failure(responseObject, @"Failed to fetch the activity data.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Failed to fetch the activity data.");
    }];
    
    
}
-(void)GetActivityTypeListSuccess:(void (^)(NSArray * typeList))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
//    {
//        "response": {
//            "msg": "Success",
//            "data": [
//                     {
//                         "id": "200",
//                         "name": "Female"
//                     },
//
    NSString * subUrl  = @"api/activity/types";
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * res = [responseObject objectForKey:@"response"];
            NSArray * data = [res objectForKey:@"data"];
            
            
            if([data isKindOfClass:[NSArray class]]){

                
                success(data);
                
            }else{
                
                NSString * msg = [res objectForKey:@"message"];
                
                failure(responseObject, msg);
            }
            
            
        }else{
            failure(responseObject, @"Failed to fetch the activity data.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Failed to fetch the activity data.");
    }];
    
    
}


//api/activity/customers/59

//{
//    "response": {
//        "msg": "Success",
//        "data": [
//                 {
//                     "ac_id": "11",
//                     "activity_id": "59",
//                     "customer_id": "8",
//                     "customer_nickname": "Mandela",
//                     "join_time": "1465283419"
//                 },


-(void)GetActivityCustomerList:(NSInteger)activityID  Success:(void (^)(NSArray * customerDict))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
    
//        "response": {
//            "msg": "Success",
//            "data": [
//                     {
//                         "ac_id": "11",
//                         "activity_id": "59",
//                         "customer_id": "8",
//                         "customer_nickname": "Mandela",
//                         "join_time": "1465283419"
//                     },
    NSString * subUrl  = [NSString stringWithFormat: @"api/activity/customers/%ld", (long)activityID];
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * res = [responseObject objectForKey:@"response"];
            NSArray * data = [res objectForKey:@"data"];
            
            
            if([data isKindOfClass:[NSArray class]]){
                
                
                success(data);
                
            }else{
                
                NSString * msg = [res objectForKey:@"message"];
                
                failure(responseObject, msg);
            }
            
            
        }else{
            failure(responseObject, @"Failed to fetch the activity data.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Failed to fetch the activity data.");
    }];
    
    
}

//api/user/sports

-(void)GetSportsTypeListSuccess:(void (^)(NSArray * customerDict))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
//    
//    {
//        "response": {
//            "status": true,
//            "message": "Get sports success",
//            "data": {
//                "sports": [
//                           {
//                               "sport_id": "1",
//                               "sport_type": "couple",
//                               "sport_name": "Tennis",
//                               "sport_gender": "both"
//                           },
    
    
    NSString * subUrl  = [NSString stringWithFormat: @"api/user/sports"];
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * res = [responseObject objectForKey:@"response"];
            BOOL status = [[res objectForKey:@"status"] boolValue];
            
            if(status){
                
                
                NSDictionary * data = [res objectForKey:@"data"];
                NSArray *  sports = [data objectForKey:@"sports"];
                if([sports isKindOfClass:[NSArray class]]){
                    NSMutableArray * smList= [NSMutableArray new];
                    for(NSDictionary * each in sports){
                        
                        SportsModel * sm = [[SportsModel alloc] initWithDictionary:each];
                        
                        [smList addObject:sm];
                    }
                    
                    success(smList);
                }
                
            }else{
                NSString * msg = [res objectForKey:@"message"];
                
                failure(responseObject, msg);
            }
            
        
            
        }else{
            failure(responseObject, @"Failed to fetch the activity data.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Failed to fetch the activity data.");
    }];
    
    
}



-(void)GetTournamentListSuccess:(void (^)(NSArray * tournamentList))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
   
    
    NSString * subUrl  = [NSString stringWithFormat: @"api/tournaments/list/all"];
    
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSArray * res = [responseObject objectForKey:@"response"];
            
           if([res isKindOfClass:[NSArray class]]){
                
               
                    NSMutableArray * tnList= [NSMutableArray new];
                    for(NSDictionary * each in res){
                        
                        TournamentModel * sm = [[TournamentModel alloc] initWithDictionary:each];
                        
                        [tnList addObject:sm];
                    }
                    
                    success(tnList);
               
                
            }else{
                NSString * msg = [responseObject objectForKey:@"message"];
                
                failure(responseObject, msg);
            }
            
            
            
        }else{
            failure(responseObject, @"Failed to fetch the tournament data.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Failed to fetch the tournament data.");
    }];
    
    
}


-(void)GetSettingSuccess:(void (^)(SettingModel * settingModel))success  failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    NSString * subUrl  = [NSString stringWithFormat: @"api/user/settings"];
    
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * res = [responseObject objectForKey:@"response"];
            
            BOOL status = [[res objectForKey:@"status"] boolValue];
            
            if(status){
                
                NSDictionary * data = [res objectForKey:@"data"];
                NSDictionary * settings = [data objectForKey:@"settings"];
                
                if([settings isKindOfClass:[NSArray class]]){
                    settings = [(NSArray*)settings objectAtIndex:0];
                    
                }
                SettingModel * sm = [[SettingModel alloc] initWithDictionary:settings];
                
                
                success(sm);
                
                
            }else{
                NSString * msg = [responseObject objectForKey:@"message"];
                
                failure(responseObject, msg);
            }
            
            
            
        }else{
            failure(responseObject, @"Failed to fetch the tournament data.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Failed to fetch the tournament data.");
    }];
    
    
}

-(void)SaveSetting:(SettingModel*)sm Success:(void (^)(SettingModel * settingModel))success  failure:(void (^)(id responseObj, NSString *errorString))failure{

    
    NSString * subUrl  = [NSString stringWithFormat: @"api/user/settings"];
    NSDictionary * para = [sm getSaveDict];
    [sAPIClient PostRequestWithSubUrl:subUrl Params:para success:^(id responseObject) {
        
        NSDictionary * res = [responseObject objectForKey:@"response"];
        BOOL status = [[res objectForKey:@"status"] boolValue];
        NSString * msg = [res objectForKey:@"message"];
        
        if(status){
            
            success(sm);
        }else{
            failure(responseObject, msg);
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj ,errorString);
    }];

    
    
}



-(void)CreateActivity:(EventModel *)em Success:(void (^)(EventModel * ev))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
    NSString * subUrl  = [NSString stringWithFormat: @"api/activity/create"];
    NSDictionary * para = [em getDictToCreateActivity];
    

    [sAPIClient PostMultiPartRequestWithSubUrl:subUrl imageData:nil keyForImage:nil Params:para success:^(id responseObject) {
        NSDictionary * res = [responseObject objectForKey:@"response"];
        NSString * message = [GD getStringFrom:res forKey:@"message"];
        NSInteger status =  [GD getIntFrom:res forKey:@"status"];
        if(status != 1){
            
            failure(message, responseObject);
        }else{
            
            NSDictionary * data = [res objectForKey:@"data"];
            NSArray * activity = [data objectForKey:@"activity"];
            
            if([activity isKindOfClass:[NSArray class]] && activity.count > 0){
                NSDictionary * each = [activity objectAtIndex:0];
                EventModel * em = [[EventModel alloc] initWithDictionary:each];
                
                success(em);
                
            }else{
                failure(res, @"Results error.");
            }
            
        }
        

    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Connection error.");

    }];
//    [sAPIClient PostRequestWithSubUrl:subUrl Params:para success:^(id responseObject) {
//        
//        NSDictionary * res = [responseObject objectForKey:@"response"];
//        NSString * message = [GD getStringFrom:res forKey:@"message"];
//        
//        if(isSet(message)){
//            
//            failure(message, responseObject);
//        }else{
//            NSDictionary * data = [res objectForKey:@"data"];
//            if([data isKindOfClass:[NSArray class]]){
//                
//                data = [(NSArray *)data objectAtIndex:0];
//                
//            }
//            
//            EventModel * em = [[EventModel alloc] initWithDictionary:data];
//            
//            success(em);
//            
//        }
//        
//        
//    } failure:^(id responseObj, NSString *errorString) {
//        
//        failure(responseObj, @"Connection error.");
//        
//    }];
    
}


-(void)CreateTournament:(TournamentModel *)tm Success:(void (^)(TournamentModel * ev))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
    NSString * subUrl  = [NSString stringWithFormat: @"api/tournaments/create"];
    NSDictionary * para = [tm getDictToCreateTournament];
    
    [sAPIClient PostMultiPartRequestWithSubUrl:subUrl imageData:nil keyForImage:nil Params:para success:^(id responseObject) {
        
        NSDictionary * res = [responseObject objectForKey:@"response"];
        NSString * message = [GD getStringFrom:res forKey:@"message"];
        NSInteger status =  [GD getIntFrom:res forKey:@"status"];
        if(status != 1){
            
            failure(responseObject,message );
            
        }else{
            
            NSDictionary * data = [res objectForKey:@"data"];
            NSArray * tournament = [data objectForKey:@"tournament"];
            
            if([tournament isKindOfClass:[NSArray class]] && tournament.count > 0){
//                NSDictionary * each = [tournament objectAtIndex:0];
//                TournamentModel * em = [[TournamentModel alloc] initWithDictionary:each];
                
                success(nil);
                
            }else{
                failure(res, @"Results error.");
            }
            
            
            
            
        }
        
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Connection error.");
        
    }];

}


-(void)CreateTeam:(TeamModel *)tm Success:(void (^)(TeamModel * ev))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
    NSString * subUrl  = [NSString stringWithFormat: @"api/teams/create"];
    NSDictionary * para = [tm getDictToCreateUpdate];

    [sAPIClient PostRequestWithSubUrl:subUrl Params:para success:^(id responseObject) {
        
        NSDictionary * res = [responseObject objectForKey:@"response"];
        
        NSString * message = [GD getStringFrom:res forKey:@"message"];
        if(isSet(message)){
            
            failure(message, responseObject);
        }else{
          
            success(tm);
            
        }
        
        
    } failure:^(id responseObj, NSString *errorString) {
        
        failure(responseObj, @"Connection error.");
        
    }];
    
}

-(void)GetVenueListSuccess:(void (^)(NSArray<VenueModel*> * venueActList, NSArray<VenueModel*> * venueTournList ))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
    
    
    NSString * subUrl  = [NSString stringWithFormat: @"api/venues/best"];
    
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * res = [responseObject objectForKey:@"response"];
            
            NSString * msg = [GD getStringFrom:res forKey:@"message"];
            
            if(isSet(msg)){
                
                failure(responseObject, msg);
            }else{
                
                NSArray * actList = [res objectForKey:@"activity"];
                
                NSMutableArray * actVenList = [NSMutableArray new];
                
                for (NSDictionary * each in actList) {
                    
                    VenueModel * vm = [[VenueModel alloc] initWithDict:each];
                    [actVenList addObject:vm];
                    
                    
                }
                
                
                
                NSMutableArray * tournVenList = [NSMutableArray new];
                  NSArray * tournList = [res objectForKey:@"tournament"];
                for (NSDictionary * each in tournList) {
                    
                    VenueModel * vm = [[VenueModel alloc] initWithDict:each];
                    [tournVenList addObject:vm];
                    
                    
                }
                
                success(actVenList, tournVenList);
                
            }
            
        }else{
            failure(responseObject, @"Failed to fetch the Venue data.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Connection Error.");
    }];
    
    
}


//

-(void)GetLocationListSuccess:(void (^)(NSArray<LocationModel *> * locModelList))success  failure:(void (^)(id responseObj, NSString *errorString))failure{

    NSString * subUrl  = [NSString stringWithFormat: @"api/venues/list"];
    
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * res = [responseObject objectForKey:@"response"];
            
            
            
            if([res isKindOfClass:[NSArray class]]){
                NSMutableArray * ret = [NSMutableArray new];
                
                for (NSDictionary * each in res) {
                    LocationModel * loc = [[LocationModel alloc] initWithDict:each];
                    [ret addObject:loc];
                    
                }
                success(ret);
                
                
            }else{
                NSString * msg = [res objectForKey:@"message"];
                
                failure(responseObject, msg);
            }
            
            
            
        }else{
            failure(responseObject, @"Failed to fetch the locations data.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Connection error.");
    }];
    
    
}
//{
//    "response": {
//        "msg": "Upload Success",
//        "data": "283010_close-circular-button-of-a-cross.png"
//    }
//}

//{
//    "response": {
//        "status": false,
//        "message": "Authorization failed",
//        "data": null
//    }
//}
-(void)UploadPhotoForTournament:(NSInteger)tID image:(UIImage *)image  Success:(void (^)())success  failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    NSData * data = UIImageJPEGRepresentation(image, 0.8);
    
     NSString * subUrl  = [NSString stringWithFormat: @"api/tournaments/gallery/%ld", (long)tID];
    
    [sAPIClient PostMultiPartRequestWithSubUrl:subUrl imageData:data keyForImage:@"file" Params:@{} success:^(id responseObject) {
        NSDictionary * res = [responseObject objectForKey:@"response"];
        NSString * message = [res objectForKey:@"message"];
        
        if(!isSet(message)){
            
            success();
        }else{
            failure(res, message);
        }
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Connection Error");
    }];
    
}




-(void)UploadPhotoForActivity:(NSInteger)tID image:(UIImage *)image  Success:(void (^)())success  failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    NSData * data = UIImageJPEGRepresentation(image, 0.8);
    
    NSString * subUrl  = [NSString stringWithFormat: @"api/activity/gallery/%ld", (long)tID];
    
    [sAPIClient PostMultiPartRequestWithSubUrl:subUrl imageData:data keyForImage:@"file" Params:@{} success:^(id responseObject) {
        NSDictionary * res = [responseObject objectForKey:@"response"];
        NSString * message = [res objectForKey:@"message"];
        
        if(!isSet(message)){
            
            success();
        }else{
            failure(res, message);
        }
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Connection Error");
    }];
    
}

-(void)GetPhotoForActivity:(NSInteger)aID success:(void(^)(NSString * imgUrl))success failed:(void(^)(id resObj, NSString * errorString))failed{
    
    NSString * subUrl  = [NSString stringWithFormat: @"api/activity/gallery/%ld", (long)aID];
    
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        NSDictionary * res = [responseObject objectForKey:@"response"];
        NSString * msg = [res objectForKey:@"msg"];

        
        if(isSet(msg) && [msg isEqualToString:@"Success"]){
            NSDictionary * data = [res objectForKey:@"data"];
            NSString * imgorderUrl = [data objectForKey:@"imgorderUrl"];
            
            success(imgorderUrl);
            
            
        }else{
            failed(res, @"Failed to get gallery.");
        }
        
        
    } failure:^(id responseObj, NSString *errorString) {
        failed(responseObj, @"Connection error.");
    }];
    
}
-(void)GetPhotoForTournament:(NSInteger)tID success:(void(^)(NSString * imgUrl))success failed:(void(^)(id resObj, NSString * errorString))failed{
    
    NSString * subUrl  = [NSString stringWithFormat: @"api/tournaments/gallery/%ld", (long)tID];

    
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        NSDictionary * res = [responseObject objectForKey:@"response"];
        NSString * msg = [res objectForKey:@"msg"];
        
        
        if(isSet(msg) && [msg isEqualToString:@"Success"]){
            NSDictionary * data = [res objectForKey:@"data"];
            NSString * imgorderUrl = [data objectForKey:@"imgorderUrl"];
            
            success(imgorderUrl);
            
            
        }else{
            failed(res, @"Failed to get gallery.");
        }
        
        
    } failure:^(id responseObj, NSString *errorString) {
        failed(responseObj, @"Connection error.");
    }];
    
}

-(void)GetMyTournamentListSuccess:(void (^)(NSArray * tournamentList))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
    
    
    NSString * subUrl  = [NSString stringWithFormat: @"api/tournaments/list/me"];
    
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSArray * res = [responseObject objectForKey:@"response"];
            
            if([res isKindOfClass:[NSArray class]]){
                
                
                NSMutableArray * tnList= [NSMutableArray new];
                for(NSDictionary * each in res){
                    
                    TournamentModel * sm = [[TournamentModel alloc] initWithDictionary:each];
                    
                    [tnList addObject:sm];
                }
                
                success(tnList);
                
                
            }else{
//                NSString * msg = [responseObject objectForKey:@"message"];
                
                failure(responseObject, @"There is no tournaments.");
            }
            
            
            
        }else{
            failure(responseObject, @"Failed to fetch the tournament data.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Failed to fetch the tournament data.");
    }];
    
    
}



-(void)GetMyActivityListSuccess:(void (^)(NSArray<EventModel *> * centerList))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
    
    
    NSString * subUrl  = @"api/activity/list/me";
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * res = [responseObject objectForKey:@"response"];
            if([res isKindOfClass:[NSArray class]]){
                NSMutableArray<EventModel*> * resArr = [[NSMutableArray alloc]init];
                for(NSDictionary * each in res){
                    EventModel * cm = [[EventModel alloc] initWithDictionary:each];
                    [resArr addObject:cm];
                }
                
                success(resArr);
                
            }else{
                
//                NSString * msg = [res objectForKey:@"message"];
                
                failure(responseObject, @"There is no activities.");
            }
            
            
        }else{
            failure(responseObject, @"Results error.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Connection Error.");
    }];
    
    
}



-(void)GetMyTeamListSuccess:(void (^)(NSArray<TeamModel *> * tmList))success  failure:(void (^)(id responseObj, NSString *errorString))failure
{
    
    
    NSString * subUrl  = @"api/teams/myteams";
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * res = [responseObject objectForKey:@"response"];
            if([res isKindOfClass:[NSArray class]]){
                NSMutableArray<TeamModel *> * resArr = [[NSMutableArray alloc]init];
                for(NSDictionary * each in res){
                    TeamModel * cm = [[TeamModel alloc] initWithDict:each];
                    [resArr addObject:cm];
                }
                
                success(resArr);
                
                
            }else{
                
//                NSString * msg = [res objectForKey:@"message"];
                
                failure(responseObject, @"There is no activities.");
            }
            
            
        }else{
            failure(responseObject, @"Results error.");
        }
        
    } failure:^(id responseObj, NSString *errorString) {
        failure(responseObj, @"Connection Error.");
    }];
    
    
}

-(void)GetNotificationListSuccess:(void(^)(NSArray * notiArr))success failed:(void(^)(NSString * error))failed{
//    api/user/notifications
    NSString * subUrl  = @"api/user/notifications";
    [sAPIClient GetRequestWithSubURL:subUrl Success:^(id responseObject) {
        
            
            NSDictionary * res = [responseObject objectForKey:@"response"];
            
            BOOL status = [[res objectForKey:@"status"] boolValue];
            if(status) {
                NSDictionary * data = [res objectForKey:@"data"];
                NSArray * msgs = [data objectForKey:@"messages"];
                if([msgs isKindOfClass:[NSArray class]]){
                    
                    NSMutableArray * retList = [NSMutableArray new];
                    
                    for (NSDictionary * each  in msgs) {
                        
                        NotificationModel * nModel = [[NotificationModel alloc] initWithDict:each];
                        [retList addObject:nModel];
                        
                        
                    }
                    success(retList);
                }else{
                    failed(@"Results Error");
                    
                }
                
                
            }else{
                failed(@"Results Error");
            }
            
      } failure:^(id responseObj, NSString *errorString) {
            failed(@"Connection Error");
    }];
    
    
}


-(void)JoinToActivity:(NSInteger)actID nickName:(NSString*)nick success:(void(^)())success failed:(void(^)(NSString * error))failed{

    
    NSString * subUrl  = [NSString stringWithFormat: @"api/activity/join/%ld", (long)actID];
    
    NSDictionary * para = @{
                            @"nickname":nick
                            
                            };
    
    [sAPIClient PostRequestWithSubUrl:subUrl Params:para success:^(id responseObject) {

        
        NSDictionary * res = [responseObject objectForKey:@"response"];
        NSString * msg = [res objectForKey:@"msg"];
        if(isSet(msg) && [msg isEqualToString:@"Success"]){
            
            success();
        }else{
            failed(@"Failed to join, please try again.");
        }
    } failure:^(id responseObj, NSString *errorString) {
        failed(@"Connection error.");
    }];
    
}


-(void)JoinToTournament:(NSInteger)tournID teamID:(NSInteger)teamID nickName:(NSString*)nick success:(void(^)())success failed:(void(^)(NSString * error))failed{
    
    
    NSString * subUrl  = [NSString stringWithFormat: @"api/tournaments/join/%ld", (long)tournID];
    
    NSDictionary * para = @{
                            @"teamid":@(teamID),
                            @"nickname":nick
                            
                            };
    
    [sAPIClient PostRequestWithSubUrl:subUrl Params:para success:^(id responseObject) {
        
        
        NSDictionary * res = [responseObject objectForKey:@"response"];
        NSString * msg = [res objectForKey:@"msg"];
        if(isSet(msg) && [msg isEqualToString:@"Success"]){
            
            success();
        }else{
            failed(@"Failed to join, please try again.");
        }
    } failure:^(id responseObj, NSString *errorString) {
        failed(@"Connection error.");
    }];
    
}


-(void)SigninwithFaceBook:(NSDictionary *)para success:(void(^)(UserModel* um))success failed:(void(^)(NSString * error))failed
{
//
      NSString * subUrl  = [NSString stringWithFormat: @"api/user/fblogin"];
    
    [sAPIClient PostRequestWithSubUrl:subUrl Params:para success:^(id responseObject) {
        
//        {
//            "response": {
//                "status": false,
//                "message": "Graph returned an error: Error validating access token: This may be because the user logged out or may be due to a system error.",
//                "data": null
//            }
//        }
        
//        
//        response =     {
//            data =         {
//                "access_token" = lhH88mfl8Op6TTYiUvdhxleM6LKvQKrc19lavBvE;
//                user =             (
//                                    {
//                                        "accounts_created_at" = "2016-06-21 06:39:09";
//                                        "accounts_email" = "kingtet123@gmail.com";
//                                        "accounts_id" = 93;
//                                        "accounts_last_login" = "<null>";
//                                        "accounts_updated_at" = "2016-06-21 06:39:09";
//                                        "ai_address_1" = "<null>";
//                                        "ai_address_2" = "<null>";
//                                        "ai_country" = "<null>";
//                                        "ai_fax" = "<null>";
//                                        "ai_first_name" = KingTet;
//                                        "ai_image" = "<null>";
//                                        "ai_last_name" = KingTet;
//                                        "ai_mobile" = "<null>";
//                                        "ai_passport" = "<null>";
//                                        "ai_postal_code" = "<null>";
//                                        "ai_state" = "<null>";
//                                        "ai_website" = "<null>";
//                                        appliedfor = "<null>";
//                                        "facebook_id" = 1729823903954587;
//                                    }
//                                    );
//            };
//            message = "Facebook login success";
//            status = 1;
//        };

        NSDictionary * res = [responseObject objectForKey:@"response"];
        BOOL status = [[res objectForKey:@"status"] boolValue];
        if(status){
            NSDictionary * data = [res objectForKey:@"data"];
            NSString *   access_token = [res objectForKey:@"access_token"];
            
            NSDictionary * userDict = [data objectForKey:@"user"];
            
            if([userDict isKindOfClass:[NSArray class]]){
                userDict = [(NSArray*)userDict objectAtIndex:0];
                
            }
            
            UserModel * um = [[UserModel alloc] initWithDictionary:userDict];
            um.avatar = [para objectForKey:@"img"];
           
            self.curUser = [[UserModel alloc] initWithDictionary:userDict];
//            self.curUser.password  = pwd;
//            [self.curUser saveToLocal];
            NSString  * accToken = access_token;
            sAPIClient.access_token = accToken;
            sAPIClient.token_type = @"";
             success(um);
            
        }else{
            NSString * msg = [res objectForKey:@"message"];
            failed(msg);
        }
        
        
    } failure:^(id responseObj, NSString *errorString) {
        
    }];
}

@end





    