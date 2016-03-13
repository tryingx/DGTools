//
//  UIColor+Hex.m
//  DGTools
//
//  Created by Gavin on 16/3/14.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

@end
