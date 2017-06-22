//
//  CalendarDateRange.h
//  OneTwoRent
//
//  Created by Ekaterina Nesterova on 15.06.17.
//  Copyright © 2017 OneTwoRent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CalendarDayCell;

@interface CalendarDateRange : NSObject

@property (nonatomic, copy) NSDate *beginDate;
@property (nonatomic, copy) NSDate *endDate;;

+ (instancetype)rangeWithBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate;

- (BOOL)containsDate:(NSDate *)date;

@end
