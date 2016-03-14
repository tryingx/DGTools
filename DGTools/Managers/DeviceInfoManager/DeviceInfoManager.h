//
//  DeviceInfoManager.h
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <Foundation/Foundation.h>
#import "KeychainManager.h"
#import "UIDevice+Identifier.h"

@interface DeviceInfoManager : NSObject

/**
 *  获取运行设备的Version
 *
 *  @return DIY 返回的Version信息
 */
+ (NSString *) MODEL;

/**
 *  获取运行设备的UUID
 *
 *  @return Device UUID
 */
+ (NSString *) UUID;

#pragma mark - 获取电池状态
+ (CGFloat)getBatteryQuantity;

#pragma mark - 磁盘剩余空间
+ (long long)freeSpace;

#pragma mark - 所有的磁盘
+ (float)getTotalDiskSpaceInBytes;

#pragma mark - 计算真机、模拟器剩余内存
+ (double)availableMemory;

#pragma mark - 总内存大小
+ (long long)getTotalMemorySize;

#pragma mark - 崩溃ID
+ (NSString *)getUniqueStrByUUID;

#pragma mark - 网络制式
+ (NSString *)getNetworktype;

#pragma mark - 获取屏幕方向
+ (NSString *)getOrientation;

#pragma mark - 获取GPS状态
+ (NSString *)getGpsStatus;

@end
