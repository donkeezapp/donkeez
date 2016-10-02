//
//  UserModel.h
//  SearchBook
//
//  Created by Admin on 4/5/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CenterModel;
@interface UserModel : NSObject

@property(nonatomic, strong)NSString * email;
@property(nonatomic, strong)NSString * first_name;
@property(nonatomic, strong)NSString * last_name;
@property(nonatomic, strong)NSString * password;

@property(nonatomic, strong)NSString * phone;
@property(nonatomic, strong)NSString * avatar;
@property(nonatomic, strong)NSString * user_id;
@property(nonatomic, strong)NSString * gender;
@property(nonatomic, strong)NSString * country;
@property(nonatomic, strong)NSString * city;
@property(nonatomic, strong)UIImage * avatarImage;
@property(nonatomic)NSInteger age;


-(NSString*)getUserName;
-(instancetype)initWithDictionary:(NSDictionary *)dict;


-(NSDictionary *)getDictForSignup;
-(NSDictionary *)getDictForProfileUpdate;

-(void)saveToLocal;
-(BOOL)readFromLocal;
-(void)removeFromLocal;

@end



@interface EventModel : NSObject


@property(nonatomic, strong)NSString * activity_id;
@property(nonatomic, strong)NSString * activity_title;
@property(nonatomic, strong)NSString * activity_owner_fname;
@property(nonatomic)NSInteger  activity_featured_from;
@property(nonatomic)NSInteger  activity_featured_to;

@property(nonatomic, strong)NSDate * fromDate;
@property(nonatomic, strong)NSDate * toDate;

@property(nonatomic)NSInteger  activity_min_age;
@property(nonatomic)NSInteger  activity_max_age;

@property(nonatomic)NSInteger  activity_max_players;

@property(nonatomic)NSString*  activity_sport;
@property(nonatomic)NSInteger  activity_type;

@property(nonatomic, strong)NSString * activity_email;
@property(nonatomic, strong)NSString * activity_phone;
@property(nonatomic, strong)NSString * thumbnail_image;

@property(nonatomic, strong)NSString * activity_desc;



@property(nonatomic, strong)NSString * activity_location;
@property(nonatomic, strong)NSString * activity_latitude;
@property(nonatomic, strong)NSString * activity_longitude;
@property(nonatomic, strong)NSString * activity_mapaddress;

@property(nonatomic, strong)NSMutableArray * activity_location_list;

@property(nonatomic)NSInteger customers_num;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
-(NSDictionary*)getDictToCreateActivity;

@end


@interface SportsModel : NSObject


@property(nonatomic)NSInteger  sport_id;


@property(nonatomic, strong)NSString * sport_type;
@property(nonatomic, strong)NSString * sport_name;
@property(nonatomic, strong)NSString * sport_gender;




-(instancetype)initWithDictionary:(NSDictionary *)dict;


@end





@interface TournamentModel : NSObject


@property(nonatomic)NSInteger  tournament_id;


@property(nonatomic, strong)NSString * tournament_title;
@property(nonatomic, strong)NSString * tournament_desc;

@property(nonatomic, strong)NSString * tournament_location;
@property(nonatomic, strong)NSString * tournament_type;
@property(nonatomic, strong)NSString * tournament_mapaddress;
@property(nonatomic, strong)NSString * tournament_sport;
@property(nonatomic, strong)NSString * tournament_owner_email;
@property(nonatomic, strong)NSString * tournament_owner_mobile;
@property(nonatomic, strong)NSString * tournament_owner_fname;
@property(nonatomic, strong)NSString * tournament_owner_lname;

@property(nonatomic)NSInteger  tournament_featured_from;
@property(nonatomic)NSInteger  tournament_featured_to;

@property(nonatomic)NSInteger  tournament_min_age;
@property(nonatomic)NSInteger  tournament_max_age;

@property(nonatomic)NSInteger  tournament_max_players;
@property(nonatomic)CGFloat  tournament_latitude;
@property(nonatomic)CGFloat  tournament_longitude;

@property(nonatomic, strong)NSDate * fromDate;
@property(nonatomic, strong)NSDate * toDate;

@property(nonatomic, strong)NSString * thumbnail_image;

@property(nonatomic, strong)NSMutableArray * tournament_location_list;

@property(nonatomic)NSInteger teams_num;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

-(NSDictionary *)getDictToCreateTournament;

@end

@interface VenueModel : NSObject


@property(nonatomic)NSInteger  venue_id;

@property(nonatomic, strong)NSString * country;
@property(nonatomic, strong)NSString * location;

@property(nonatomic, strong)NSString * latitude;
@property(nonatomic, strong)NSString * longitude;
@property(nonatomic, strong)NSString * user;
@property(nonatomic, strong)NSString * total;
@property(nonatomic, strong)NSString * status;


@property(nonatomic)CGFloat lat;
@property(nonatomic)CGFloat lon;


@property(nonatomic, strong)NSMutableArray<EventModel*> * eventList;
-(instancetype)initWithDict : (NSDictionary*)dict;





@end


@interface NotificationModel : NSObject


@property(nonatomic)NSString *  push_id;

@property(nonatomic, strong)NSString * push_category;
@property(nonatomic, strong)NSString * push_action;

@property(nonatomic, strong)NSString * message;
@property(nonatomic, strong)NSString * created_at;
@property(nonatomic, strong)NSString * item_name;
@property(nonatomic, strong)NSDate * createdDate;

-(instancetype)initWithDict : (NSDictionary*)dict;


@end


@class TeamUserModel;

@interface TeamModel : NSObject



@property(nonatomic, strong)NSString * _id;
@property(nonatomic, strong)NSString * name;
@property(nonatomic, strong)NSString * accounts_id;
@property(nonatomic, strong)NSString * _description;

@property(nonatomic, strong)NSString * team_min_age;
@property(nonatomic, strong)NSString * team_max_age;
@property(nonatomic, strong)NSString * team_sport_type;
@property(nonatomic, strong)NSString * team_member_type;
@property(nonatomic, strong)NSString * created_at;
@property(nonatomic, strong)NSString * updated_at;
@property(nonatomic, strong)NSString * accounts_email;



@property(nonatomic,strong)NSMutableArray<TeamUserModel*> * players;
//@property(nonatomic, strong)CenterModel * centerOfTeam;

-(NSDictionary *)getDictToCreateUpdate;
-(instancetype)initWithDict:(NSDictionary*)dict;
-(void)loadPlayersOfTeamSucees:(void(^)())success failed:(void(^)(NSString * err))failed;
-(void)loadCenterOfTeam:(void(^)())success failed:(void(^)(NSString * err))failed;
@end



@interface LocationModel : NSObject


@property(nonatomic, strong)NSString * _id;
@property(nonatomic, strong)NSString * country;
@property(nonatomic, strong)NSString * location;
@property(nonatomic, strong)NSString * latitude;

@property(nonatomic, strong)NSString * longitude;
@property(nonatomic, strong)NSString * user;


-(instancetype)initWithDict:(NSDictionary*)dict;

@end





@interface ActivityModel : NSObject

// to create

@property(nonatomic, strong)NSString * activityname;
@property(nonatomic, strong)NSString * activitydesc;
@property(nonatomic, strong)NSString * activitytype;

@property(nonatomic, strong)NSString * ffrom;
@property(nonatomic, strong)NSString * fto;

@property(nonatomic, strong)NSString * activityemail;
@property(nonatomic, strong)NSString * activityfulladdress;
@property(nonatomic, strong)NSString * activityphone;
@property(nonatomic, strong)NSString * activityexclusions;
@property(nonatomic, strong)NSMutableArray * locations;
@property(nonatomic, strong)NSString * activitymapaddress;
@property(nonatomic, strong)NSString * latitude;
@property(nonatomic, strong)NSString * longitude;
@property(nonatomic, strong)NSString * activitysport;
@property(nonatomic, strong)NSString * activityminage;
@property(nonatomic, strong)NSString * activitymaxage;
@property(nonatomic, strong)NSString * activitymaxplayers;


// to get dict
@property(nonatomic, strong)NSString * activity_id;
@property(nonatomic, strong)NSString * activity_title;
@property(nonatomic, strong)NSString * activity_slug;
@property(nonatomic, strong)NSString * activity_desc;
@property(nonatomic, strong)NSString * activity_featured_from;
@property(nonatomic, strong)NSString * activity_featured_to;
@property(nonatomic, strong)NSString * activity_owned_by;
@property(nonatomic, strong)NSString * activity_type;
@property(nonatomic, strong)NSString * activity_location;
@property(nonatomic, strong)NSString * activity_latitude;
@property(nonatomic, strong)NSString * activity_longitude;
@property(nonatomic, strong)NSString * activity_mapaddress;
@property(nonatomic, strong)NSString * activity_max_players;
@property(nonatomic, strong)NSString * activity_min_age;
@property(nonatomic, strong)NSString * activity_max_age;
@property(nonatomic, strong)NSString * activity_email;
@property(nonatomic, strong)NSString * activity_phone;
@property(nonatomic, strong)NSString * activity_sport;
@property(nonatomic, strong)NSString * activity_fulladdress;
@property(nonatomic, strong)NSString * activity_created_at;
@property(nonatomic, strong)NSString * thumbnail_image;
@property(nonatomic, strong)NSString * customers_num;

-(instancetype)initWithDict:(NSDictionary*)dict;
-(NSDictionary *)getDictToCreateActivity;
@end

@interface BookModel : NSObject

@property(nonatomic, strong)NSString * bookingID;
@property(nonatomic, strong)NSString * checkin;
@property(nonatomic, strong)NSString * date;

@property(nonatomic, strong)NSString * bookingUser;
@property(nonatomic, strong)NSString * userFullName;
@property(nonatomic, strong)NSString * userMobile;
@property(nonatomic, strong)NSDictionary * subItem;
@property(nonatomic, strong)NSString * location;
@property(nonatomic, strong)NSString * bookingDate;

@property(nonatomic, strong)NSString * thumbnail;
@property(nonatomic, strong)NSString * status;
@property(nonatomic, strong)NSString * accountEmail;
@property(nonatomic, strong)NSString * teamName;



-(void)initWithDict:(NSDictionary*)dict;
-(NSDate *)getBookingDate;
-(NSDate *)getCheckInDate;
-(NSDate *)getDate;
@end

@interface TeamUserModel : NSObject

//{
    //                         "id": "409",
    //                         "user_id": "385",
    //                         "team_id": "37",
    //                         "apply_date": "1464549684",
    //                         "accept_date": "1464549920",
    //                         "status": "Yes",
    //                         "first_name": "ming",
    //                         "last_name": "xingd",
    //                         "email": "xiaomingmin@163.com",
    //                         "mobile": "0",
    //                         "avatar": "385-avatar.png",
    //                         "center_id": "68"
    //                     }
@property(nonatomic, strong)NSString * _id;
@property(nonatomic, strong)NSString * user_id;
@property(nonatomic, strong)NSString * team_id;

@property(nonatomic)NSInteger  apply_date;
@property(nonatomic)NSInteger  accept_date;

@property(nonatomic)BOOL  status;
@property(nonatomic, strong)NSString * first_name;
@property(nonatomic, strong)NSString * last_name;
@property(nonatomic, strong)NSString * email;
@property(nonatomic, strong)NSString * mobile;
@property(nonatomic, strong)NSString * avatar;

@property(nonatomic, strong)NSString * center_id;

-(void)initWithDict:(NSDictionary*)dict;
-(NSDate *)getApplyDate;
-(NSDate *)getAcceptDate;


@end





@interface CreateBookModel : NSObject



@property(nonatomic, strong)NSString * userid;
@property(nonatomic, strong)NSString * additionalnotes;


@property(nonatomic, strong)NSString * itemid;
@property(nonatomic, strong)NSString * checkin;
@property(nonatomic, strong)NSString * adults;
@property(nonatomic, strong)NSString * children;
@property(nonatomic, strong)NSString * infant;

@property(nonatomic, strong)NSString * btype;
@property(nonatomic, strong)NSString * team_id;

-(NSDictionary*)getDictionaryToBooking;

@end


@interface PayModel : NSObject



@property(nonatomic, strong)NSString * firstname;
@property(nonatomic, strong)NSString * lastname;


@property(nonatomic, strong)NSString * cardnum;

@property(nonatomic, strong)NSString * expMonth;
@property(nonatomic, strong)NSString * cardtype;
@property(nonatomic, strong)NSString * expYear;

@property(nonatomic, strong)NSString * cvv;
@property(nonatomic, strong)NSString * postcode;

@property(nonatomic, strong)NSString * paymethod;
@property(nonatomic, strong)NSString * bookingid;
@property(nonatomic, strong)NSString * refno;

-(NSDictionary*)getDictionaryToPay;

@end


//firstname:wjsskanyo
//lastname:buyer2
//cardnum:4032032072520106
//cardtype:Visa
//expMonth:06
//expYear:2021
//cvv:123

//postcode:95131

//paymethod:paypalpaymentspro
//bookingid:107
//refno:1691
