//
//  TextBoundsManager.h
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextBoundsManager : NSObject

/**
 *  求单行宽度
 *
 *  @param text 文本
 *  @param font 字体
 *
 *  @return Width CGFloat
 */
+ (CGFloat)getOneLineText:(NSString *)text andFont:(UIFont *)font;

/**
 *  求多行高度
 *
 *  @param text  文本
 *  @param width 边界宽度
 *  @param font  字体
 *
 *  @return Height CGFloat
 */
+ (CGFloat)getNumLinesText:(NSString *)text
                   andWith:(CGFloat)width
                   andFont:(UIFont *)font;

@end
