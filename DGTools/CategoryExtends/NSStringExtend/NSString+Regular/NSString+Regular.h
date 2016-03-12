//
//  NSString+Regular.h
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)

/**
 *  检查是否是（中国）手机号
 *
 *  @return BOOL
 */
- (BOOL)isMobileNumber;

/**
 *  检查是否是Email Address
 *
 *  @return BOOL
 */
- (BOOL)isEmailAddress;

@end
