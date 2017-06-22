//
//  CalendarView.h
//  OneTwoRent
//
//  Created by Ekaterina Nesterova on 15.06.17.
//  Copyright © 2017 OneTwoRent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDateRange.h"

@interface CalendarView : UIView

//IBOutlet
@property (weak, nonatomic) IBOutlet UIView *monthView;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *monthNameLabel;
@property (weak, nonatomic) IBOutlet UIView *weekDaysView;
@property (weak, nonatomic) IBOutlet UICollectionView *daysCollectionView;

//other
@property (nonatomic, readonly) NSCalendar *calendar;
@property (nonatomic, strong) NSMutableArray *ranges;

- (void)addRange:(CalendarDateRange *)range;
- (void)removeRange:(CalendarDateRange *)range;

@end
