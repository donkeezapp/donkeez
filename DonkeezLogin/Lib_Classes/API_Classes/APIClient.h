

#import <Foundation/Foundation.h>



#define sAPIClient [APIClient sharedInstance]

#define RootUrl @"http://bubblebump.org/"

#define GET_FULL_URL_FROMROOT(url) [RootUrl stringByAppendingString:url]


static inline bool isDictionary(id obj){
    
    if([obj isKindOfClass:[NSDictionary class]]){
        return  YES;
    }else{
        return NO;
    }
    
}

@interface APIClient : NSObject

@property(nonatomic, strong) NSString* access_token;
@property(nonatomic, strong) NSString* refresh_token;
@property(nonatomic, strong) NSString* expires_in;
@property(nonatomic, strong) NSString* token_type;

+ (instancetype)sharedInstance;

-(void)GetRequestWithSubURL:(NSString*)suburl  Success:(void (^)(id responseObject))success  failure:(void (^)(id responseObj, NSString *errorString))failure;
-(void)PutRequestWithSubUrl:(NSString*)subUrl Params:(id)params success:(void (^)(id responseObject))success
                    failure:(void (^)(id responseObj, NSString *errorString))failure;
-(void)PostRequestWithSubUrl:(NSString*)subUrl Params:(id)params success:(void (^)(id responseObject))success
                     failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)PostRequestWithFullUrl:(NSString*)fullUrl Params:(id)params success:(void (^)(id responseObject))success
                      failure:(void (^)(id responseObj, NSString *errorString))failure;

-(void)DelRequestWithSubUrl:(NSString*)subUrl Params:(id)params success:(void (^)(id responseObject))success
                    failure:(void (^)(id responseObj, NSString *errorString))failure;



-(NSString *)getToken;

-(BOOL)isLoggedin;

- (void)uploadUserAvatarImae:(NSData *)image
             keyNameforImage:(NSString*)keyname
                         url:(NSString *)subUrl
                  parameters:(NSDictionary *)params
                     success:(void(^)( id responseObject))success
                     failure:(void(^)(NSString * errString))failure;

-(void)PostMultiPartRequestWithSubUrl:(NSString*)subUrl imageData:(NSData*)imageData keyForImage:(NSString*)keyForImage Params:(id)params success:(void (^)(id responseObject))success
                              failure:(void (^)(id responseObj, NSString *errorString))failure;
@end
