//
//  NSString+Trim.m
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

#pragma mark - Common Method
+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet {
    NSString *returnVal = @"";
    if (val) {
        returnVal = [val stringByTrimmingCharactersInSet:characterSet];
    }
    return returnVal;
}

#pragma mark - 去掉前后空格
+ (NSString *)trimWhitespace:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
}
#pragma mark - 去掉前后回车符
+ (NSString *)trimNewline:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet newlineCharacterSet]];
}
#pragma mark - 去掉前后空格和回车符
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end




