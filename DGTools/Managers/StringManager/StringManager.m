//
//  StringManager.m
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "StringManager.h"

@implementation StringManager

#pragma mark - 解析文本首字母
+ (NSString *)catchNameFirst:(NSString *)userName
{
    NSString *pinYinResult = [NSString string];
    NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",[HanziToPinyin getPinyin:[userName characterAtIndex:0]]]uppercaseString];
    
    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
    
    return pinYinResult;
}

@end
