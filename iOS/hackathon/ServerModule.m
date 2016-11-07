//
//  ServerModule.m
//  hackathon
//
//  Created by Ｗill on 2016/11/3.
//  Copyright © 2016年 hippocolors. All rights reserved.
//

#import "ServerModule.h"
#import "HTFBModule.h"


/*
 SERVER_IP : Please fill in ip address in Info.plist by SERVER_IP category 
 */

#define SERVER_IP                       @"http://%@/api/%@"
#define PARAMETER_GET_ALL_BIBLES        @"bibles"
#define PARAMETER_GET_TODAY_BIBLES      @"bible/%@"
#define PARAMETER_REGISTER              @"user/register"
#define PARAMETER_LOGIN                 @"user/login"
#define PARAMETER_USER_PROFILE          @"user/%@/profile"
#define PARAMETER_POSTS_POPULAR         @"posts/popular"
#define PARAMETER_BOOK_LIST             @"book_list"
#define PARAMETER_BIBLE_LIST            @"bible_list"
#define PARAMETER_BIBLE_EMOTION         @"bible/emotion"
#define PARAMETER_POSTS_LASTEST_LIST    @"posts/latest_list"
#define PARAMETER_BIBLE_POPULAR         @"bible/popular"
#define PARAMETER_API_RESPONSE          @"responses"
#define PARAMETER_POSTS_CREATE          @"posts/create"
#define PARAMETER_RESPONSE_CREATE       @"responses/create"
#define PARAMETER_USERS_LIKE            @"users/like"
#define PARAMETER_USERS_UNLIKE          @"users/unlike"
#define PARAMETER_POSTS_RECOMMENDLIST   @"posts/recommend_list"
#define PARAMETER_USER_PROFILE_HISTORY  @"user/%@/post_list"


@interface ServerModule (){
    AFHTTPSessionManager *manager;
}
@end

@implementation ServerModule

+ (instancetype) getInstance {
    
    static dispatch_once_t once;
    static ServerModule *instance;
    dispatch_once(&once, ^{
        instance = [[ServerModule alloc] initUniqueInstance];
    });
    
    return instance;
}

- (void) GetAllBibleInfoWithSuccess:(void (^)(id))success
                            Failure:(void (^)(NSError *))failure {
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_GET_ALL_BIBLES];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetAllBibleInfoWithSuccess \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

- (void) GetTodayBibleInfoWithParameter: (NSString*) BibleIndex
                                Success:(void (^)(id))success
                                Failure:(void (^)(NSError *))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],[NSString stringWithFormat:PARAMETER_GET_TODAY_BIBLES,BibleIndex]];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    [manager GET:TestString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetTodayBibleInfoWithParameter \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

- (void) RegisterAccountWithParameters:(NSMutableDictionary*) Parameter
                              Success : (void (^)(id responseObj))success
                              Failure : (void (^)(NSError *error))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_REGISTER];
    
    NSLog(@"TestString = %@",TestString);
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:TestString
       parameters:Parameter constructingBodyWithBlock:nil progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSLog(@"RegisterAccountWithParameters success");
              success(responseObject);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              failure(error);
          }];

}

//- (void) LoginWithParameters:(NSDictionary*) Parameter
//                    Success : (void (^)(id responseObj))success
//                    Failure : (void (^)(NSError *error))failure{
//    
//    NSString *TestString = [NSString stringWithFormat:SERVER_IP,PARAMETER_LOGIN];
//    
//    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    
//    [manager POST:TestString
//       parameters:Parameter constructingBodyWithBlock:nil progress:nil
//          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//              
//              NSLog(@"RegisterAccountWithParameters success");
//              success(responseObject);
//              
//          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//              failure(error);
//          }];
//}


- (void) GetUserProfileWithSuccess:(void (^)(id))success
                           Failure:(void (^)(NSError *))failure {
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],[NSString stringWithFormat:PARAMETER_USER_PROFILE,[HTFBModule GetFBID]]];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetUserProfileWithSuccess \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}


- (void) GetPostsPopularWithSuccess: (void (^)(id responseObj))success
                           Failure : (void (^)(NSError *error))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_POSTS_POPULAR];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetPostsPopularWithSuccess \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

- (void) GetBookListWithSuccess: (void (^)(id responseObj))success
                       Failure : (void (^)(NSError *error))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_BOOK_LIST];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetBookListWithSuccess \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

- (void) GetChapterListWithParameter:(NSDictionary*) bookDic
                             Success: (void (^)(id responseObj))success
                            Failure : (void (^)(NSError *error))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_BIBLE_LIST];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:bookDic
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetChapterListWithParameter \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

- (void) GetPopularBibleWithSuccess: (void (^)(id responseObj))success
                           Failure : (void (^)(NSError *error))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_BIBLE_POPULAR];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetPopularBibleWithSuccess \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

// Get Response list
- (void) GetResponseListWithParameter:(NSDictionary*) Parameter
                              Success: (void (^)(id responseObj))success
                             Failure : (void (^)(NSError *error))failure{
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_API_RESPONSE];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:Parameter
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetResponseListWithParameter \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

- (void) PostWithParameter:(NSDictionary*) Parameter
                   Success: (void (^)(id responseObj))success
                  Failure : (void (^)(NSError *error))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_POSTS_CREATE];
    
    NSLog(@"TestString = %@",TestString);
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:TestString
       parameters:Parameter constructingBodyWithBlock:nil progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSLog(@"PostWithParameter success");
              success(responseObject);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              failure(error);
          }];
}

- (void) PostDiscussWithParameter:(NSDictionary*) Parameter
                          Success: (void (^)(id responseObj))success
                         Failure : (void (^)(NSError *error))failure{
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_RESPONSE_CREATE];
    
    NSLog(@"TestString = %@",TestString);
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:TestString
       parameters:Parameter constructingBodyWithBlock:nil progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSLog(@"PostWithParameter success");
              success(responseObject);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              failure(error);
          }];
}

- (void) SubscribeWithParameter:(NSDictionary*) Parameter
                        Success: (void (^)(id responseObj))success
                       Failure : (void (^)(NSError *error))failure{
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_USERS_LIKE];
    
    NSLog(@"TestString = %@",TestString);
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:TestString
       parameters:Parameter constructingBodyWithBlock:nil progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSLog(@"SubscribeWithParameter success");
              success(responseObject);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              failure(error);
          }];
}

- (void) UnsubscribeWithParameter:(NSDictionary*) Parameter
                          Success: (void (^)(id responseObj))success
                         Failure : (void (^)(NSError *error))failure{
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_USERS_UNLIKE];
    
    NSLog(@"TestString = %@",TestString);
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:TestString
       parameters:Parameter constructingBodyWithBlock:nil progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSLog(@"UnsubscribeWithParameter success");
              success(responseObject);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              failure(error);
          }];
}

- (void) RecommendWithParameter:(NSDictionary*) Parameter
                        Success: (void (^)(id responseObj))success
                       Failure : (void (^)(NSError *error))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_POSTS_RECOMMENDLIST];
    
    NSLog(@"TestString = %@",TestString);
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:Parameter
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"RecommendWithParameter \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}



- (void) GetNewsWithSuccess: (void (^)(id responseObj))success
                   Failure : (void (^)(NSError *error))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_POSTS_LASTEST_LIST];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
//             NSLog(@"GetNewsWithSuccess \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

- (void) GetBibleFromEmotionWithSuccess: (void (^)(id responseObj))success
                               Failure : (void (^)(NSError *error))failure{
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],PARAMETER_BIBLE_EMOTION];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetBibleFromEmotionWithSuccess \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

- (void) GetUserProfileHistoryWithSuccess: (void (^)(id responseObj))success
                                 Failure : (void (^)(NSError *error))failure{
    
    NSString *TestString = [NSString stringWithFormat:SERVER_IP,[[NSBundle mainBundle] infoDictionary][@"SERVER_IP"],[NSString stringWithFormat:PARAMETER_USER_PROFILE_HISTORY,[HTFBModule GetFBID]]];
    
    [manager.requestSerializer setValue:HACKATHON_KEY_VALUE forHTTPHeaderField:HACKATHON_API_KEY];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:TestString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"GetUserProfileHistoryWithSuccess \n : %@", responseObject);
             
             if (![[responseObject objectForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
             }
             
             success(responseObject);
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"Error : %@", [error localizedDescription]);
             failure(error);
             
         }];
}

#pragma mark -
#pragma mark Private Functions
-(instancetype) initUniqueInstance {
    if (self = [super init]) {
        manager = [[AFHTTPSessionManager alloc] init];
        [manager.requestSerializer setTimeoutInterval:5];
    }
    return self;
}

@end
