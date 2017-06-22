//
//  DateUtils.h
//  OneTwoRent
//
//  Created by Ekaterina Nesterova on 15.06.17.
//  Copyright © 2017 OneTwoRent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject
+ (BOOL)date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2;
+ (NSDate *)cutDate:(NSDate *)date;
+ (NSCalendar *)calendar;
+ (NSString *)monthText:(NSInteger)month;
+ (long)weekDayForDate:(NSDate *)date;
+ (int)numberOfdaysinMonth:(int)selectedMonthNumber WithDate:(NSDate *)selectedDate;
@end
