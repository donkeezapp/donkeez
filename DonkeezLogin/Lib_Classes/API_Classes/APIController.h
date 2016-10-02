//
//  APIController.h
//  BubbleBump
//
//  Created by Admin on 5/22/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "APIClient.h"
#import "SettingModel.h"

#define sAPIController [APIController sharedInstance]

@interface APIController : NSObject
+ (instancetype)sharedInstance;

@property(nonatomic, strong)UserModel * curUser;
@property(nonatomic, strong)NSMutableArray * myTeams;


-(void)LogInEmail:(NSString*)eMail pwd:(NSString*)pwd  Success:(void (^)(UserModel* user))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)SignUpWithUserModel:(UserModel*)um Success:(void (^)(UserModel* user))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)ConfirmSignUpWithEmail:(NSString*)email SMSCode:(NSString*)smscode Success:(void (^)(UserModel* user))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)GetActivityListSuccess:(void (^)(NSArray<EventModel *> * centerList))success  failure:(void (^)(id responseObj, NSString *errorString))failure;
-(void)GetActivityTypeListSuccess:(void (^)(NSArray * typeList))success  failure:(void (^)(id responseObj, NSString *errorString))failure;
-(void)GetActivityCustomerList:(NSInteger)activityID  Success:(void (^)(NSArray * customerDict))success  failure:(void (^)(id responseObj, NSString *errorString))failure;


//-(void)changeProfilePicture:(UIImage*)avatar Success:(void (^)(UserModel* user))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)GetSportsTypeListSuccess:(void (^)(NSArray * customerDict))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)GetTournamentListSuccess:(void (^)(NSArray * tournamentList))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)SaveSetting:(SettingModel*)sm Success:(void (^)(SettingModel * settingModel))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)GetSettingSuccess:(void (^)(SettingModel * settingModel))success  failure:(void (^)(id responseObj, NSString *errorString))failure;


-(void)CreateActivity:(EventModel *)em Success:(void (^)(EventModel * ev))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)CreateTournament:(TournamentModel *)tm Success:(void (^)(TournamentModel * ev))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)CreateTeam:(TeamModel *)tm Success:(void (^)(TeamModel * ev))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)GetVenueListSuccess:(void (^)(NSArray<VenueModel*> * venueActList, NSArray<VenueModel*> * venueTournList ))success  failure:(void (^)(id responseObj, NSString *errorString))failure;


-(void)profileUpdate:(UserModel *)um Success:(void (^)(UserModel* user))success  failure:(void (^)(id responseObj, NSString *errorString))failure;
-(void)GetLocationListSuccess:(void (^)(NSArray<LocationModel *> * locModelList))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)UploadPhotoForTournament:(NSInteger)tID image:(UIImage *)image  Success:(void (^)())success  failure:(void (^)(id responseObj, NSString *errorString))failure;
-(void)UploadPhotoForActivity:(NSInteger)tID image:(UIImage *)image  Success:(void (^)())success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)GetPhotoForActivity:(NSInteger)aID success:(void(^)(NSString * imgUrl))success failed:(void(^)(id resObj, NSString * errorString))failed;

-(void)GetPhotoForTournament:(NSInteger)tID success:(void(^)(NSString * imgUrl))success failed:(void(^)(id resObj, NSString * errorString))failed;

-(void)GetMyTournamentListSuccess:(void (^)(NSArray * tournamentList))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)GetMyActivityListSuccess:(void (^)(NSArray<EventModel *> * centerList))success  failure:(void (^)(id responseObj, NSString *errorString))failure;


-(void)GetMyTeamListSuccess:(void (^)(NSArray<TeamModel *> * tmList))success  failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)GetNotificationListSuccess:(void(^)(NSArray * notiArr))success failed:(void(^)(NSString * error))failed;


-(void)JoinToActivity:(NSInteger)actID nickName:(NSString*)nick success:(void(^)())success failed:(void(^)(NSString * error))failed;
-(void)JoinToTournament:(NSInteger)tournID teamID:(NSInteger)teamID nickName:(NSString*)nick success:(void(^)())success failed:(void(^)(NSString * error))failed;

-(void)SigninwithFaceBook:(NSDictionary *)para success:(void(^)(UserModel * um))success failed:(void(^)(NSString * error))failed;
@end
