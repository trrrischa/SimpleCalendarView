//
//  CalendarDateRange.m
//  OneTwoRent
//
//  Created by Ekaterina Nesterova on 15.06.17.
//  Copyright © 2017 OneTwoRent. All rights reserved.
//

#import "CalendarDateRange.h"
#import "DateUtils.h"

@implementation CalendarDateRange

- (instancetype)initWithBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate
{
    self = [super init];
    if (self) {
        _beginDate = [DateUtils cutDate:beginDate];
        _endDate = [DateUtils cutDate:endDate];
    }
    return self;
}

+ (instancetype)rangeWithBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate
{
    return [[CalendarDateRange alloc] initWithBeginDate:beginDate endDate:endDate];
}

- (void)setBeginDate:(NSDate *)beginDate
{
    _beginDate = [DateUtils cutDate:beginDate];
}

- (void)setEndDate:(NSDate *)endDate
{
    _endDate = [DateUtils cutDate:endDate];
}

- (BOOL)containsDate:(NSDate *)date
{
    NSDate *d = [DateUtils cutDate:date];
    
    if ([d compare:self.beginDate] == NSOrderedAscending) {
        return NO;
    }
    if ([d compare:self.endDate] == NSOrderedDescending) {
        return NO;
    }
    return YES;
}

@end
