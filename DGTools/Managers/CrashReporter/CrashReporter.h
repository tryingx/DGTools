//
//  CrashReporter.h
//  DGTools
//
//  Created by Gavin on 16/3/14.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

/**
 *  崩溃检测
 *
 *  @param 使用方法 在main.m中
 
 int main(int argc, char * argv[]) {
 @autoreleasepool {
 
 [[SYSCrashReporter defaultTools] start];
 }
 }
 *  @param
 *
 *  @return
 */

#import <Foundation/Foundation.h>

@interface CrashReporter : NSObject

/**
 *  其他需要存入的数据 可选
 */
@property (nonatomic,strong)NSMutableDictionary * infoDict;
/**
 *  单例
 *
 *  @return
 */
+ (CrashReporter *)defaultTools;

/**
 *  初始化  必须实现
 */

- (void)start;

@end
