//
//  CalendarView.m
//  OneTwoRent
//
//  Created by Ekaterina Nesterova on 15.06.17.
//  Copyright © 2017 OneTwoRent. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarDayCell.h"
#import "DateUtils.h"
#import "UIColor+Constants.h"
#import "UIFont+Constants.h"
#import "NSDate+Utils.h"

static NSString * const CELL_REUSE_IDENTIFIER = @"DayCell";

#define DEFAULT_PADDING 4;
#define DEFAULT_ROW_HEIGHT 44;

@interface CalendarView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, readwrite) NSCalendar *calendar;
@property (assign, nonatomic) NSInteger minSpace;
@property (assign, nonatomic) NSUInteger curMonth;
@property (assign, nonatomic) NSUInteger curYear;
@property (assign, nonatomic) NSUInteger firstWD;
@property (assign, nonatomic) NSUInteger monthDays;

@end

@implementation CalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self load];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self load];
    }
    return self;
}

- (void)load
{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    view.frame = self.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.minSpace = (self.bounds.size.width - 308)/8.0;
    [self addSubview:view];
    [self setup];
}

- (void)setup
{
    self.daysCollectionView.dataSource = self;
    self.daysCollectionView.delegate = self;
    [self.daysCollectionView registerNib:[UINib nibWithNibName:@"CalendarDayCell" bundle:[NSBundle bundleForClass:self.class]] forCellWithReuseIdentifier:CELL_REUSE_IDENTIFIER];
    
    self.ranges = [NSMutableArray array];
    
    self.calendar = [DateUtils calendar];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"MM"];
    self.curMonth = [[df stringFromDate:[NSDate date]] integerValue];
    
    [df setDateFormat:@"yyyy"];
    self.curYear = [[df stringFromDate:[NSDate date]] integerValue];
    
    [self updateValues];

    UISwipeGestureRecognizer *imageSwipedRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousMonth)];
    [imageSwipedRight setDirection:UISwipeGestureRecognizerDirectionRight];
    UISwipeGestureRecognizer *imageSwipedLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextMonth)];
    [imageSwipedLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:imageSwipedLeft];
    [self addGestureRecognizer:imageSwipedRight];
    
    [self loadAppearance];
}

-(void) updateValues {
    
    NSDateComponents *components = [self.calendar components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:[NSDate date]];
    components.day = 1;
    components.month = self.curMonth;
    components.year = self.curYear;
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [components setTimeZone:zone];
    
    NSDate *firstDay = [self.calendar dateFromComponents:components];
    self.firstWD = [DateUtils weekDayForDate:firstDay];
    if (self.firstWD == 1) {
        self.firstWD = 6;
    }
    else
        self.firstWD = self.firstWD - 2;
    
    self.monthDays = [DateUtils numberOfdaysinMonth:(int)self.curMonth WithDate:firstDay];

}
# pragma mark - appearance

- (void)loadAppearance
{
    //monthView;
    [_monthView setBackgroundColor:[UIColor backgroundColor]];
    
    //prevButton;
    UIImage *prevImage = [[UIImage imageNamed:@"prev_month"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_prevButton setImage:prevImage forState:UIControlStateNormal];
    _prevButton.tintColor = [UIColor monthTextColor];
    
    //nextButton;
    UIImage *nextImage = [[UIImage imageNamed:@"next_month"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_nextButton setImage:nextImage forState:UIControlStateNormal];
    _nextButton.tintColor = [UIColor monthTextColor];
    
    //monthNameLabel;
    [_monthNameLabel setFont:[UIFont mainFontOfSize:15.0]];
    [_monthNameLabel setTextColor:[UIColor monthTextColor]];
    [_monthNameLabel setText:[NSString stringWithFormat:@"%@ %ld",[DateUtils monthText:self.curMonth], (unsigned long)self.curYear]];
    
    //weekDaysView;
    [self setupWeekDayView];
    
    //daysCollectionView;
}
- (void)setupWeekDayView
{
    
    //firstWDButton;
    NSArray *titles = self.calendar.veryShortStandaloneWeekdaySymbols;
    NSInteger firstWeekDayIdx = [self.calendar firstWeekday] - 1;  // Sunday == 1
    if (firstWeekDayIdx > 0) {
        NSArray *post = [titles subarrayWithRange:NSMakeRange(firstWeekDayIdx, 7 - firstWeekDayIdx)];
        NSArray *pre = [titles subarrayWithRange:NSMakeRange(0, firstWeekDayIdx)];
        titles = [post arrayByAddingObjectsFromArray:pre];
    }


    CGFloat buttonSize = DEFAULT_ROW_HEIGHT;
    
    for (int i = 0; i < titles.count; i++) {
        CGRect buttonFrame = CGRectMake(self.minSpace*(i+1) + buttonSize * i, 0, buttonSize, buttonSize);

        UIButton *wdButton = [[UIButton alloc] initWithFrame:buttonFrame];
        [wdButton setTitleColor:[UIColor weekdayTextColor] forState:UIControlStateNormal];
        [wdButton.titleLabel setFont:[UIFont mainFontOfSize:13]];
        [wdButton setTitle:titles[i] forState:UIControlStateNormal];

        [self.weekDaysView addSubview:wdButton];
    }

}


#pragma mark - public api

- (void)addRange:(CalendarDateRange *)range
{
    [self.ranges addObject:range];
    [self.daysCollectionView reloadData];
}

- (void)removeRange:(CalendarDateRange *)range
{
    [self.ranges removeObject:range];
    [self.daysCollectionView reloadData];
}

#pragma mark - UICollectionView data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarDayCell *cell = (CalendarDayCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    [cell loadAppearance];

    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];
    NSString *day;
    if ((indexPath.item < self.firstWD) || (indexPath.item >= self.monthDays + self.firstWD)) {
        day = @"";
    }
    else
    {
        day = [NSString stringWithFormat:@"%lu",indexPath.item + 1 - self.firstWD];
        for (CalendarDateRange *range in self.ranges) {
            if ([range containsDate:cellDate]) {
                [cell setSingleRange];
                break;
            }
        }
        if ([DateUtils date:[NSDate date] isSameDayAsDate:cellDate]) {
            [cell setCurrentDate];
        }

    }
    [cell.dayLabel setText:day];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];
    for (CalendarDateRange *range in self.ranges) {
        if ([range containsDate:cellDate]) {
            [self removeRange:range];
            return;
        }
    }
    CalendarDateRange *newRange = [CalendarDateRange rangeWithBeginDate:cellDate endDate:cellDate];
    [self addRange:newRange];

}

#pragma mark - Collection view layout things
// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize mElementSize = CGSizeMake(44, 44);
    return mElementSize;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.minSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,self.minSpace,0,self.minSpace);  // top, left, bottom, right
}

#pragma mark - Actions

- (IBAction)PreviousPressed:(id)sender {
    
    [self previousMonth];
}

- (IBAction)NextPressed:(id)sender {
    
    [self nextMonth];
}

#pragma mark - Month Navigation

- (void) nextMonth {
    
    if (self.curMonth < 12) {
        self.curMonth += 1;
    }
    else
    {
        self.curMonth = 1;
        self.curYear += 1;
    }
    [self updateValues];
    [self loadAppearance];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.daysCollectionView reloadData];
    });

    
}


-(void) previousMonth {
    
    if (self.curMonth > 1) {
        self.curMonth -= 1;
    }
    else
    {
        self.curMonth = 12;
        self.curYear -= 1;
    }
    [self updateValues];
    [self loadAppearance];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.daysCollectionView reloadData];
    });

}

#pragma mark - Auxilary
-(NSDate*) dateForCellAtIndexPath:(NSIndexPath*)indexPath {
    
    NSDateComponents *components = [self.calendar components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:[NSDate date]];
    components.day = indexPath.item + 1 - self.firstWD;
    components.month = self.curMonth;
    components.year = self.curYear;
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [components setTimeZone:zone];
    
    NSDate *cellDate = [[self.calendar dateFromComponents:components] toLocalTime];
    return cellDate;

}
@end
