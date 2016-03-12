//
//  NSString+Trim.h
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)

//  Common Method
+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet;


//  去掉前后空格
+ (NSString *)trimWhitespace:(NSString *)val;

//  去掉前后回车符
+ (NSString *)trimNewline:(NSString *)val;

//  去掉前后空格和回车符
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;

@end
