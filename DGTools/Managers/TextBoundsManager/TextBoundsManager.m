//
//  TextBoundsManager.m
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "TextBoundsManager.h"

@implementation TextBoundsManager

#pragma mark - 求单行宽度
+ (CGFloat)getOneLineText:(NSString *)text andFont:(UIFont *)font
{
    CGSize size =[text sizeWithAttributes:@{NSFontAttributeName:font}];
    return size.width;
}

#pragma mark - 多行高度
+ (CGFloat)getNumLinesText:(NSString *)text
                   andWith:(CGFloat)width
                   andFont:(UIFont *)font
{
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil].size;
    return titleSize.height;
}

@end
