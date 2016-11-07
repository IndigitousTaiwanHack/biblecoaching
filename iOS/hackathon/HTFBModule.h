//
//  HTFBModule.h
//  hackathon
//
//  Created by Ｗill on 2016/11/4.
//  Copyright © 2016年 hippocolors. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FBInfoKey              @"FBInfoKey"

@interface HTFBModule : NSObject

// get FB info
+ (NSDictionary*) GetFBInfo;

// get FB image url
+ (NSString *) GetImageUrl;

// get FB name
+ (NSString *) GetFBName;

// get FB ID
+ (NSString *) GetFBID;

// save FB info
+ (void) SaveFBInfo:(NSDictionary*) fbinfo;

@end
