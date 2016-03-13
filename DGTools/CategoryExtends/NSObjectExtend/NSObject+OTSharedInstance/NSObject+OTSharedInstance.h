//
//  NSObject+OTSharedInstance.h
//  DGTools
//
//  创建单例时可以直接继承自该类目
//
//  Created by Gavin on 16/3/13.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OTSharedInstance)
/**
 *  获得单例
 *
 *  @return id
 */
+ (id)sharedInstance;

/**
 *  释放单例子
 */
+ (void)freeSharedInstance;

@end
