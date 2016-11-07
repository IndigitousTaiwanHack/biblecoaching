//
//  EmotionDetect.m
//  EmotionDetecti
//
//  Created by GIGIGUN on 24/10/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "EmotionDetect.h"

/*
 EmotionDetectAPIPath : Mircosoft Face API Key path
 EmotionDetectKey : Mircosoft Face API Key 
 
 Reference : https://www.microsoft.com/cognitive-services/en-us/face-api
 */

@interface EmotionDetect (){
    AFHTTPSessionManager *manager;
}
@end


@implementation EmotionDetect

+ (instancetype) getInstance {
    
    static dispatch_once_t once;
    static EmotionDetect *instance;
    dispatch_once(&once, ^{
        instance = [[EmotionDetect alloc] initUniqueInstance];
    });
    
    return instance;
}


- (void) getEmotionDetectWithImageData : (NSData*) ImageData
                               Success : (void (^)(id responseObj))success
                               Failure : (void (^)(NSError *error))failure
{
    
    NSDictionary *infoPlistDict = [[NSBundle mainBundle] infoDictionary];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.projectoxford.ai/emotion/v1.0/recognize"]];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [request setValue:infoPlistDict[@"EmotionalKey"] forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:ImageData];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [[manager dataTaskWithRequest:request
                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            NSLog(@"Reply response: %@", response);
            NSLog(@"Reply JSON: %@", responseDict);
            success(responseDict);

        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            failure(error);
        }
    }] resume];

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
