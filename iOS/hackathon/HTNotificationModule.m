//
//  HTNotificationModule.m
//  hackathon
//
//  Created by Ｗill on 2016/11/5.
//  Copyright © 2016年 hippocolors. All rights reserved.
//

#import "HTNotificationModule.h"

@implementation HTNotificationModule

+ (NSMutableArray *) GetNotificationList{
    
    [self setNotification];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults valueForKey:NotificationKey]) {
        return [userDefaults valueForKey:NotificationKey];
    }
    return nil;
}

+ (void) setNotification{
    
    NSMutableArray *list = [[NSMutableArray alloc]init];
    
    [list addObject:@{@"Date":@"2016-12-01",@"Bible":@"1-1"}];
    [list addObject:@{@"Date":@"2016-12-02",@"Bible":@"40-2"}];
    [list addObject:@{@"Date":@"2016-12-03",@"Bible":@"2-4"}];
    [list addObject:@{@"Date":@"2016-12-04",@"Bible":@"45-4"}];
    [list addObject:@{@"Date":@"2016-11-05",@"Bible":@"18-2"}];
    [list addObject:@{@"Date":@"2016-11-06",@"Bible":@"49-3"}];
    [list addObject:@{@"Date":@"2016-11-07",@"Bible":@"57-1"}];
    [list addObject:@{@"Date":@"2016-11-08",@"Bible":@"66-19"}];
    [list addObject:@{@"Date":@"2016-11-09",@"Bible":@"19-23"}];
    [list addObject:@{@"Date":@"2016-11-10",@"Bible":@"23-12"}];
    [list addObject:@{@"Date":@"2016-11-11",@"Bible":@"21-12"}];
    [list addObject:@{@"Date":@"2016-11-12",@"Bible":@"22-1"}];
    [list addObject:@{@"Date":@"2016-11-13",@"Bible":@"46-3"}];
    [list addObject:@{@"Date":@"2016-11-14",@"Bible":@"47-4"}];
    [list addObject:@{@"Date":@"2016-11-15",@"Bible":@"50-3"}];
    [list addObject:@{@"Date":@"2016-11-16",@"Bible":@"51-3"}];
    [list addObject:@{@"Date":@"2016-11-17",@"Bible":@"54-2"}];
    [list addObject:@{@"Date":@"2016-11-18",@"Bible":@"55-3"}];
    [list addObject:@{@"Date":@"2016-11-19",@"Bible":@"27-3"}];
    [list addObject:@{@"Date":@"2016-11-20",@"Bible":@"26-22"}];
    [list addObject:@{@"Date":@"2016-11-21",@"Bible":@"24-18"}];
    [list addObject:@{@"Date":@"2016-11-22",@"Bible":@"6-2"}];
    [list addObject:@{@"Date":@"2016-11-23",@"Bible":@"8-1"}];
    [list addObject:@{@"Date":@"2016-11-24",@"Bible":@"7-2"}];
    [list addObject:@{@"Date":@"2016-11-25",@"Bible":@"25-5"}];
    [list addObject:@{@"Date":@"2016-11-26",@"Bible":@"30-1"}];
    [list addObject:@{@"Date":@"2016-11-27",@"Bible":@"31-1"}];
    [list addObject:@{@"Date":@"2016-11-28",@"Bible":@"32-4"}];
    [list addObject:@{@"Date":@"2016-11-29",@"Bible":@"35-1"}];
    [list addObject:@{@"Date":@"2016-11-30",@"Bible":@"37-2"}];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:list forKey:NotificationKey];
}

+ (void) scheduleNotificationForDate : (NSDate *) date
             WithNotificationMessage : (NSString *) MessageString
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.fireDate = date;
    localNotification.alertBody = MessageString;
    localNotification.repeatInterval = NSCalendarUnitWeekOfYear;
    
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
