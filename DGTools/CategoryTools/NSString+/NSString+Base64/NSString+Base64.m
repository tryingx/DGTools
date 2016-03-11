//
//  NSString+Base64.m
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx All rights reserved.
//

#import "NSString+Base64.h"
#import "GTMBase64.h"

@implementation NSString (Base64)

- (NSString *) stringFromBase64
{
    NSData * data = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString * output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}

@end
