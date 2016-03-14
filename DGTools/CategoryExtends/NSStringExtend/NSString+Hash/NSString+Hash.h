//
//  NSString+Hash.h
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

- (NSString *)MD5Hash;

+ (NSString *)fileMD5:(NSString*)path;

+ (NSString *)dataMD5:(NSData*)data;

@end
