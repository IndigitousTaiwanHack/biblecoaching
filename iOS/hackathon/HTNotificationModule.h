//
//  HTNotificationModule.h
//  hackathon
//
//  Created by Ｗill on 2016/11/5.
//  Copyright © 2016年 hippocolors. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NotificationKey        @"NotificationKey"

@interface HTNotificationModule : NSObject

+ (NSMutableArray *) GetNotificationList;

+ (void) scheduleNotificationForDate : (NSDate *) date
             WithNotificationMessage : (NSString *) MessageString;
@end
