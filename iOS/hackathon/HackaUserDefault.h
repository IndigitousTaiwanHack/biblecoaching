//
//  HackaUserDefault.h
//  hackathon
//
//  Created by GIGIGUN on 03/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import <Foundation/Foundation.h>
#define isReadTutorKey              @"isReadTutorKey"

@interface HackaUserDefault : NSObject

+(BOOL) isReadTutor;
+(void) setReadTutor;


@end
