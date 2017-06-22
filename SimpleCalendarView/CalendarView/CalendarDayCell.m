//
//  CalendarDayCell.m
//  OneTwoRent
//
//  Created by Ekaterina Nesterova on 15.06.17.
//  Copyright © 2017 OneTwoRent. All rights reserved.
//

#import "CalendarDayCell.h"
#import "UIColor+Constants.h"
#import "UIFont+Constants.h"

@interface CalendarDayCell()

@property (nonatomic) BOOL isToday;
@property (nonatomic) BOOL isRange;

@end

@implementation CalendarDayCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self loadAppearance];
}

- (void)loadAppearance
{
    
    //rangeSingle;
    _isToday = false;
    _isRange = false;
    [self.rangeSingle setBackgroundColor:[UIColor selectedColor]];
    self.rangeSingle.layer.cornerRadius = 8.0;
    self.rangeSingle.clipsToBounds = YES;
    [self.rangeSingle setHidden:YES];
    
    //dayLabel;
    [self.dayLabel setFont:[UIFont mainFontOfSize:15.0]];
    [self.dayLabel setTextColor:[UIColor dayTextColor]];    

    //today
    self.today.layer.cornerRadius = 8.0;
    self.today.layer.borderWidth = 1.0;
    self.today.layer.borderColor = [UIColor todayColor].CGColor;
    [self.today setHidden:YES];
}

#pragma mark - Public API

-(void) setCurrentDate
{
    _isToday = true;
    if (_isRange) {
        self.today.layer.borderColor = [UIColor dayTextColor].CGColor;

    }
    [_today setHidden:NO];
    
}

-(void) setSingleRange
{
    _isRange = true;
    [self.rangeSingle setHidden:NO];

}

@end
