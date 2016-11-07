//
//  HTFBModule.m
//  hackathon
//
//  Created by Ｗill on 2016/11/4.
//  Copyright © 2016年 hippocolors. All rights reserved.
//

#import "HTFBModule.h"

@implementation HTFBModule

// get FB info
+ (NSDictionary*) GetFBInfo{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults valueForKey:FBInfoKey]) {
        return [userDefaults valueForKey:FBInfoKey];
    }
    
    return nil;
}

// save FB info
+ (void) SaveFBInfo:(NSDictionary*) fbinfo{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:fbinfo forKey:FBInfoKey];
}

+ (NSString *) GetImageUrl{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[userDefaults valueForKey:FBInfoKey] valueForKey:@"url"]) {
        return [[userDefaults valueForKey:FBInfoKey] valueForKey:@"url"];
    }
    return nil;
}

// get FB name
+ (NSString *) GetFBName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[userDefaults valueForKey:FBInfoKey] valueForKey:@"name"]) {
        return [[userDefaults valueForKey:FBInfoKey] valueForKey:@"name"];
    }
    return nil;
}

// get FB ID
+ (NSString *) GetFBID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[userDefaults valueForKey:FBInfoKey] valueForKey:@"uid"]) {
        return [[userDefaults valueForKey:FBInfoKey] valueForKey:@"uid"];
    }
    return nil;
}

@end
