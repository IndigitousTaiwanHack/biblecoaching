//
//  ServerModule.h
//  hackathon
//
//  Created by Ｗill on 2016/11/3.
//  Copyright © 2016年 hippocolors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#define HACKATHON_API_KEY           @"hackathon-Api-Key"
#define HACKATHON_KEY_VALUE         @"3593294fc88ed19ffe61a92bbb444f44"

@interface ServerModule : NSObject
+(instancetype) getInstance;

// Get all bible info
- (void) GetAllBibleInfoWithSuccess : (void (^)(id responseObj))success
                            Failure : (void (^)(NSError *error))failure;


// Get today bible info
- (void) GetTodayBibleInfoWithParameter: (NSString*) BibleIndex
                             Success : (void (^)(id responseObj))success
                             Failure : (void (^)(NSError *error))failure;


// Register
// Url : POST API_SERVER/api/user/register
// params: {"uid”:"12345","provider":"facebook","name”:”edward"}

- (void) RegisterAccountWithParameters:(NSDictionary*) Parameter
                              Success : (void (^)(id responseObj))success
                              Failure : (void (^)(NSError *error))failure;

// Login
// Url : POST API_SERVER/api/user/login
// params: {"uid”:"12345","provider":"facebook"}
//- (void) LoginWithParameters:(NSDictionary*) Parameter
//                    Success : (void (^)(id responseObj))success
//                    Failure : (void (^)(NSError *error))failure;

// response : {
//"result": 0,
//"user": {
//    "name": "edward",
//    "post_count": 1,
//    "post_like": 1,
//    "response_like": 1
//}
//}

// Get user profile
//"result": 0,
//"user": {
//    "name": "edward",
//    "post_count": 1,
//    "post_like": 1,
//    "response_like": 1
- (void) GetUserProfileWithSuccess: (void (^)(id responseObj))success
                          Failure : (void (^)(NSError *error))failure;

// Posts popular
- (void) GetPostsPopularWithSuccess: (void (^)(id responseObj))success
                           Failure : (void (^)(NSError *error))failure;

// Get book list
- (void) GetBookListWithSuccess: (void (^)(id responseObj))success
                       Failure : (void (^)(NSError *error))failure;

// Get book list chapters
- (void) GetChapterListWithParameter:(NSDictionary*) bookid
                             Success: (void (^)(id responseObj))success
                            Failure : (void (^)(NSError *error))failure;

// Get popular bible
- (void) GetPopularBibleWithSuccess: (void (^)(id responseObj))success
                           Failure : (void (^)(NSError *error))failure;

// Get Response list
- (void) GetResponseListWithParameter:(NSDictionary*) Parameter
                              Success: (void (^)(id responseObj))success
                             Failure : (void (^)(NSError *error))failure;

// Post
// params={ “uid”:”123”, “provider”:”facebook”, “content”: “test”, “bible_bid” :1-1} #uid:  login user uid
- (void) PostWithParameter:(NSDictionary*) Parameter
                   Success: (void (^)(id responseObj))success
                  Failure : (void (^)(NSError *error))failure;

// Post Discuss
- (void) PostDiscussWithParameter:(NSDictionary*) Parameter
                          Success: (void (^)(id responseObj))success
                         Failure : (void (^)(NSError *error))failure;


// Subscribe
- (void) SubscribeWithParameter:(NSDictionary*) Parameter
                        Success: (void (^)(id responseObj))success
                        Failure : (void (^)(NSError *error))failure;

// Unsubscribe
// params={ “login_uid”:”123”, “provider”:”facebook"  , “user_id”:1}
- (void) UnsubscribeWithParameter:(NSDictionary*) Parameter
                          Success: (void (^)(id responseObj))success
                         Failure : (void (^)(NSError *error))failure;

// Recommend user
// params={ “uid”:”123”, “provider”:”facebook"}
- (void) RecommendWithParameter:(NSDictionary*) Parameter
                        Success: (void (^)(id responseObj))success
                        Failure : (void (^)(NSError *error))failure;

// Get News
- (void) GetNewsWithSuccess: (void (^)(id responseObj))success
                   Failure : (void (^)(NSError *error))failure;

// Get bible from emotion
- (void) GetBibleFromEmotionWithSuccess: (void (^)(id responseObj))success
                               Failure : (void (^)(NSError *error))failure;

// Get user profile history
- (void) GetUserProfileHistoryWithSuccess: (void (^)(id responseObj))success
                                 Failure : (void (^)(NSError *error))failure;

@end
