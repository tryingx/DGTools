//
//  NSString+Regular.h
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "NSString+Regular.h"

@implementation NSString (Regular)

#pragma mark - 判断是否是手机号
- (BOOL)isMobileNumber
{
  NSString *regex = @"^(13[0-9]|15[0-35-9]|18[0-9]|14[57])[0-9]{8}$";
  return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}

#pragma mark - 判断是否是Email地址
- (BOOL)isEmailAddress
{
  NSString *regex = @"^([a-z0-9]+[_|-|.]?)*[a-z0-9]+@([a-z0-9]+[_|-|.]?)*[a-z0-9]+.[a-z]{2,3}$";
  return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex]
          evaluateWithObject:[self lowercaseString]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////

@end
