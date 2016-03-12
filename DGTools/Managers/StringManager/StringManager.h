//
//  StringManager.h
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

//  汉字转拼音
#import "HanziToPinyin.h"

@interface StringManager : NSObject

//  解析文本首字母
+ (NSString *)catchNameFirst:(NSString *)userName;

@end
