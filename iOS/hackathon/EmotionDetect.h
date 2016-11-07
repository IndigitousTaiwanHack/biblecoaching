//
//  EmotionDetect.h
//  EmotionDetecti
//
//  Created by GIGIGUN on 24/10/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface EmotionDetect : NSObject
+ (instancetype) getInstance;

- (void) getEmotionDetectWithImageData : (NSData*) ImageData
                               Success : (void (^)(id responseObj))success
                               Failure : (void (^)(NSError *error))failure;
@end
