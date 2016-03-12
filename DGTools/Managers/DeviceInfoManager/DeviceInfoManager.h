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

@end
