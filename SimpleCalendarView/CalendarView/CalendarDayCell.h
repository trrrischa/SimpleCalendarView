//
//  CalendarDayCell.h
//  OneTwoRent
//
//  Created by Ekaterina Nesterova on 15.06.17.
//  Copyright © 2017 OneTwoRent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarDayCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *rangeSingle;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIView *today;

-(void) setCurrentDate;
-(void) setSingleRange;
-(void) loadAppearance;

@end
