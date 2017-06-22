//
//  DateUtils.m
//  OneTwoRent
//
//  Created by Ekaterina Nesterova on 15.06.17.
//  Copyright © 2017 OneTwoRent. All rights reserved.
//

#import "DateUtils.h"

#define CALENDAR_COMPONENTS NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay


@implementation DateUtils

+ (BOOL)date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2 {
    if (date1 == nil || date2 == nil) {
        return NO;
    }
    
    NSCalendar *calendar = [DateUtils calendar];
    
    NSDateComponents *day1 = [calendar components:CALENDAR_COMPONENTS fromDate:date1];
    NSDateComponents *day2 = [calendar components:CALENDAR_COMPONENTS fromDate:date2];
    return ([day2 day] == [day1 day] &&
            [day2 month] == [day1 month] &&
            [day2 year] == [day1 year]);
}

+ (NSCalendar *)calendar {
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSCalendar *cal = [threadDictionary objectForKey:@"GLCalendar"];
    if (!cal) {
        cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        cal.locale = [NSLocale currentLocale];
        [threadDictionary setObject:cal forKey:@"GLCalendar"];
    }
    return cal;
}

+ (NSDate *)cutDate:(NSDate *)date
{
    NSCalendar *calendar = [DateUtils calendar];
    NSDateComponents *components = [calendar components:CALENDAR_COMPONENTS fromDate:date];
    return [calendar dateFromComponents:components];
}

static NSArray *months;
+ (NSString *)monthText:(NSInteger)month {
    if (!months) {
        months = [[[NSDateFormatter alloc] init] shortStandaloneMonthSymbols];
    }
    return [months objectAtIndex:(month - 1)];
}

+ (long)weekDayForDate:(NSDate *)date
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* comp = [cal components:NSCalendarUnitWeekday fromDate:date];
    return [comp weekday];
    
}

+ (int)numberOfdaysinMonth:(int)selectedMonthNumber WithDate:(NSDate *)selectedDate
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    // Set your month here
    [comps setMonth:selectedMonthNumber];
    
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay
                              inUnit:NSCalendarUnitMonth
                             forDate:selectedDate];
    NSLog(@"%lu", (unsigned long)range.length);
    return (int)range.length;
}

@end
