//
//  UIColor+RGB.m
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)

+ (UIColor *)colorWithRGB:(NSInteger)RGBValue alpha:(CGFloat)alpha;
{
    return [UIColor colorWithRed:((float)((RGBValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((RGBValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(RGBValue & 0xFF))/255.0
                           alpha:alpha];
}

@end
