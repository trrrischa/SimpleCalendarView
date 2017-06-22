//
//  UIColor+Constants.m
//  OneTwoRent
//
//  Created by Ekaterina Nesterova on 11.05.17.
//  Copyright © 2017 OneTwoRent. All rights reserved.
//

#import "UIColor+Constants.h"
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]


@implementation UIColor (Constants)

//Cell Colors
+(UIColor *) selectedColor{
    
    return UIColorFromRGB(0x88B04B);
}

+(UIColor *) dayTextColor{
    
    return UIColorFromRGB(0x9C7E41);
}

+(UIColor *) todayColor{
    
    return UIColorFromRGB(0xA6594C);
}

//Calendar Colors
+(UIColor *) backgroundColor{
    
    return UIColorFromRGB(0xA9BDB1);
}

+(UIColor *) monthTextColor{
    
    return UIColorFromRGB(0x9C7E41);
}

+(UIColor *) weekdayTextColor{
    
    return UIColorFromRGB(0xA6594C);
}



@end
