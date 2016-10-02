#import "APIClient.h"
//#import "DataBook.h"
@implementation APIClient

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Methods

-(AFURLSessionManager*)getAFURLSessionManager{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    return manager;
}
-(NSString *)getToken{
    //    return [NSString stringWithFormat:@"%@ %@", self.token_type, self.access_token];
    return [NSString stringWithFormat:@"%@", isSet(self.access_token)?self.access_token:@""];
}
#pragma mark - APIs Prototype

-(BOOL)isLoggedin
{
    
    return  isSet([self getToken]);
}


-(void)GetRequestWithSubURL:(NSString*)suburl  Success:(void (^)(id responseObject))success  failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    AFURLSessionManager *manager = [self getAFURLSessionManager];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:GET_FULL_URL_FROMROOT(suburl) parameters:nil error:nil];
    
    //    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    NSLog(@"apiTOken %@", [self getToken]);
    NSString * apitoken = [self getToken];
    [req setValue: apitoken forHTTPHeaderField:@"Secret"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            //            if ([responseObject isKindOfClass:[NSDictionary class]]) {
            //blah blah
            success(responseObject);
            //            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            failure(responseObject, error.description);
        }
    }] resume];
    
}






-(void)PutRequestWithSubUrl:(NSString*)subUrl Params:(id)params success:(void (^)(id responseObject))success
                    failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    //    NSDictionary *body = params;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    AFURLSessionManager *manager = [self getAFURLSessionManager];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:GET_FULL_URL_FROMROOT(subUrl) parameters:nil error:nil];
    
    //    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    NSString * apitoken = [self getToken];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [req setValue: apitoken forHTTPHeaderField:@"Secret"];
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"apitoken %@", apitoken);
    
    NSURLSessionDataTask * ta = [manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
                success(responseObject);
            }else{
                success(responseObject);
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            failure(responseObject, error.description);
        }
    }];
    
    [ta resume];
    
    
}

-(void)DelRequestWithSubUrl:(NSString*)subUrl Params:(id)params success:(void (^)(id responseObject))success
                    failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    //    NSDictionary *body = params;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager = [self getAFURLSessionManager];
    NSString * fullUrlPath = GET_FULL_URL_FROMROOT(subUrl);
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"DELETE" URLString:fullUrlPath parameters:nil error:nil];
    
    //    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    NSString * apitoken = [self getToken];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if(![subUrl isEqualToString:@"oauth/token"] && ![subUrl isEqualToString:@"users/register"]){
        [req setValue: apitoken forHTTPHeaderField:@"Secret"];
    }
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"apiToken : %@ \n  %@", apitoken,jsonString);
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
                success(responseObject);
            }else{
                failure(responseObject, @"response object is not Json result.");
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            failure(responseObject, error.description);
        }
    }] resume];
    
}


-(void)PostRequestWithSubUrl:(NSString*)subUrl Params:(id)params success:(void (^)(id responseObject))success
                     failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    //    NSDictionary *body = params;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager = [self getAFURLSessionManager];
    NSString * fullUrlPath = GET_FULL_URL_FROMROOT(subUrl);
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:fullUrlPath parameters:nil error:nil];
    
    //    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    NSString * apitoken = [self getToken];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if(![subUrl isEqualToString:@"oauth/token"] && ![subUrl isEqualToString:@"users/register"]){
        [req setValue: apitoken forHTTPHeaderField:@"Secret"];
    }
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"apiToken : %@ \n  %@", apitoken,jsonString);
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
                success(responseObject);
            }else{
                failure(responseObject, @"response object is not Json result.");
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            failure(responseObject, error.description);
        }
    }] resume];
    
}


-(void)PostMultiPartRequestWithSubUrl:(NSString*)subUrl imageData:(NSData*)imageData keyForImage:(NSString*)keyForImage Params:(id)params success:(void (^)(id responseObject))success
                              failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    //    NSDictionary *body = params;
    //    NSError *error;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    //    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    AFURLSessionManager *manager = [self getAFURLSessionManager];
    NSString * fullUrlPath = GET_FULL_URL_FROMROOT(subUrl);
    //    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:fullUrlPath parameters:nil error:nil];
    
    //    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    NSString * apitoken = [self getToken];
    //    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //
    //    if(![subUrl isEqualToString:@"oauth/token"] && ![subUrl isEqualToString:@"users/register"]){
    //        [req setValue: apitoken forHTTPHeaderField:@"Secret"];
    //    }
    //
    ////    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"apiToken : %@ \n  %@", apitoken,jsonString);
    
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",apitoken] forHTTPHeaderField:@"Secret"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    //    [manager POST:fullUrlPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //
    //        if(imageData){
    //            [formData appendPartWithFileData:imageData name:keyForImage fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
    //        }
    //
    //    } success:^(NSURLSessionTask *task, id responseObject) {
    //        success(responseObject);
    //    } failure:^(NSURLSessionTask *operation, NSError *error) {
    //        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    //        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
    //
    //        NSLog(@"Error: %@, %@", error, serializedData);
    //        failure(serializedData, error.description);
    //    }];
    
    [manager POST:fullUrlPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if(imageData){
            [formData appendPartWithFileData:imageData name:keyForImage fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
        }        // etc.
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        
        NSLog(@"Error: %@, %@", error, serializedData);
        failure(serializedData, error.description);
    }];
    
    
    
    
}



-(void)PostRequestWithFullUrl:(NSString*)fullUrl Params:(id)params success:(void (^)(id responseObject))success
                      failure:(void (^)(id responseObj, NSString *errorString))failure{
    
    //    NSDictionary *body = params;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager = [self getAFURLSessionManager];
    NSString * fullUrlPath = fullUrl;
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:fullUrlPath parameters:nil error:nil];
    
    //    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    NSString * apitoken = [self getToken];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if(![fullUrl isEqualToString:@"oauth/token"] && ![fullUrl isEqualToString:@"users/register"]){
        [req setValue: apitoken forHTTPHeaderField:@"Secret"];
    }
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"apiToken : %@ \n  %@", apitoken,jsonString);
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
                success(responseObject);
            }else{
                failure(responseObject, @"response object is not Json result.");
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            failure(responseObject, error.description);
        }
    }] resume];
    
}

- (void)uploadUserAvatarImae:(NSData *)image
             keyNameforImage:(NSString*)keyname
                         url:(NSString *)subUrl
                  parameters:(NSDictionary *)params
                     success:(void(^)( id responseObject))success
                     failure:(void(^)(NSString * errString))failure {
    
    NSURL * url = [NSURL URLWithString:GET_FULL_URL_FROMROOT(subUrl)];
    
    __block AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    //    [sessionManager POST:url
    //              parameters:params
    //constructingBodyWithBlock:^(id < AFMultipartFormData > formData) {
    //
    //    if(image){
    //        [formData appendPartWithFormData:image name:keyname];
    //    }
    //
    //}
    //                 success:^(NSURLSessionDataTask *task, id responseObject) {
    //                     NSLog( @"Upload response: %@", responseObject );
    //
    //                     sessionManager = nil;
    //
    ////                     {
    ////                         "error": 0,
    ////                         "data": [
    ////                                  "http://searchapp-bucket.oss-cn-beijing.aliyuncs.com/images/mark_quran_trans.png"
    ////                                  ],
    ////                         "msg": "Upload successful"
    //                     //                     }
    ////                     NSDictionary * resDict = (NSDictionary*)responseObject;
    ////                     NSInteger errorCode = [[resDict objectForKey:@"error"] integerValue];
    ////                     if(errorCode == 0){
    ////
    ////                         NSString * path = [resDict objectForKey:@"data"];
    //                         success( responseObject);
    //
    ////                     }else{
    ////
    ////
    ////                         failure(@"Failed to upload. please try again.");
    ////                     }
    ////
    //                 }
    //                 failure:^(NSURLSessionDataTask *task, NSError *error) {
    //
    //                     sessionManager = nil;
    //
    //                     failure(isSet(error.description)?error.description:@"Failed to uploading.");
    //                 }];
    
    [sessionManager POST:GET_FULL_URL_FROMROOT(subUrl) parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if(image){
            [formData appendPartWithFormData:image name:keyname];
        }      // etc.
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog( @"Upload response: %@", responseObject );
        
        sessionManager = nil;
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        sessionManager = nil;
        
        failure(isSet(error.description)?error.description:@"Failed to uploading.");
    }];
    
    
    
    
    
}






@end
