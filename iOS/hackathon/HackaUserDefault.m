//
//  HackaUserDefault.m
//  hackathon
//
//  Created by GIGIGUN on 03/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HackaUserDefault.h"

@implementation HackaUserDefault

+(void) setReadTutor
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:isReadTutorKey];
}

+(BOOL) isReadTutor
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults valueForKey:isReadTutorKey]) {
        return YES;
    }
    return NO;
    
}


@end
