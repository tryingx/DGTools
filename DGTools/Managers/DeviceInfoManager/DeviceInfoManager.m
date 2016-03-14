//
//  DeviceInfoManager.m
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "DeviceInfoManager.h"

#include <sys/param.h>
#include <sys/mount.h>
#import <CoreLocation/CoreLocation.h>
#import <CrashReporter/CrashReporter.h>

@implementation DeviceInfoManager

+ (NSString *) MODEL
{
    //return [[UIDevice currentDevice] localizedModel];
    return [self platformString];
}
+ (NSString*)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}
+ (NSString *) platformString{
    NSString *platform = [self getDeviceVersion];
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])   return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])   return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])   return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])   return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])   return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])   return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone 4s";
    if ([platform isEqualToString:@"iPhone4,2"])   return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,1"])   return @"iPhone 5 (GSM/WCDMA)";
    if ([platform isEqualToString:@"iPhone5,2"])   return @"iPhone 5 (GSM/WCDMA/CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])   return @"iPhone 5C (CDMA)";
    if ([platform isEqualToString:@"iPhone5,4"])   return @"iPhone 5C (GSM)";
    if ([platform isEqualToString:@"iPhone6,1"])   return @"iPhone 5s (CDMA)";
    if ([platform isEqualToString:@"iPhone6,2"])   return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,3"])   return @"iPhone 5s (GSM/4G)";
    
    //iPot Touch
    if ([platform isEqualToString:@"iPod1,1"])     return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])     return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])     return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])     return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])     return @"iPod Touch 5G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])     return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])     return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])     return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])     return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])     return @"iPad 2 New";
    if ([platform isEqualToString:@"iPad2,5"])     return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])     return @"iPad Mini (WiFi/GSM/3G/4G)";
    if ([platform isEqualToString:@"iPad2,7"])     return @"iPad Mini (WiFi/GSM/CDMA/3G/4G)";
    
    if ([platform isEqualToString:@"iPad3,1"])     return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])     return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])     return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])     return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])     return @"iPad 4 (WiFi/GSM/3G/4G)";
    if ([platform isEqualToString:@"iPad3,6"])     return @"iPad 4 (WiFi/GSM/CDMA/3G/4G)";
    
    if ([platform isEqualToString:@"iPad4,1"])     return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])     return @"iPad Air (WiFi/4G)";
    if ([platform isEqualToString:@"iPad4,4"])     return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,4"])     return @"iPad Mini Retina (Wifi/4G)";
    
    // 虚拟机
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])        return@"Simulator";
    
    return platform;
}

+ (NSString*) UUID
{
    NSString *uuid = nil;
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if ( version >= 7.0){
        NSString *load_udid = [KeychainManager passwordForService:@"com.tryingx.app" account:@"DGID"];
        if (load_udid && ![load_udid isEqual:@""]){
            return load_udid;
        }else{
            CFUUIDRef puuid = CFUUIDCreate(nil);
            CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
            uuid = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
            CFRelease(puuid);
            CFRelease(uuidString);
            uuid = [[uuid stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
            [KeychainManager setPassword: [NSString stringWithFormat:@"%@", uuid] forService:@"com.tryingx.app" account:@"DGID"];
        }
    }else if (version >= 6.0 || version >= 5.0){
        uuid = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    }
    return [uuid lowercaseString];
}

#pragma mark - 获取电池状态
+ (CGFloat)getBatteryQuantity
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [[UIDevice currentDevice] batteryLevel];
}
#pragma mark - 磁盘剩余空间
+ (long long)freeSpace {
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/", &buf) >= 0){
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    
    return freespace;
}
#pragma mark - 所有的磁盘
+ (float)getTotalDiskSpaceInBytes {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    struct statfs tStats;
    statfs([[paths lastObject] cString], &tStats);
    float totalSpace = (float)(tStats.f_blocks * tStats.f_bsize);
    return totalSpace;
}
#pragma mark - 计算真机、模拟器剩余内存
+ (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn
    = host_statistics(mach_host_self(),
                      HOST_VM_INFO,
                      (host_info_t)&vmStats,
                      &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return vm_page_size * vmStats.free_count;
}
 
#pragma mark - 总内存大小
+ (long long)getTotalMemorySize
{
    return [NSProcessInfo processInfo].physicalMemory;
}

#pragma mark - 崩溃ID
+ (NSString *)getUniqueStrByUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    return retStr;
}

#pragma mark - 网络制式
+ (NSString *)getNetworktype{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    NSString * workType =@"";
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            NSLog(@"No wifi or cellular");
            workType = @"无服务";
            
            break;
            
        case 1:
            NSLog(@"2G");
            workType=@"2G";
            break;
            
        case 2:
            NSLog(@"3G");
            workType=@"3G";
            break;
            
        case 3:
            NSLog(@"4G");
            workType=@"4G";
            break;
            
        case 4:
            NSLog(@"LTE");
            workType=@"LTE";
            break;
            
        case 5:
            NSLog(@"Wifi");
            workType=@"Wifi";
            break;
            
            
        default:
            break;
    }
    return workType;
}

#pragma mark - 获取屏幕方向
+ (NSString *)getOrientation{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    return [NSString stringWithFormat:@"%ld",(long)orientation];
}

#pragma mark - 获取GPS状态
+ (NSString *)getGpsStatus{
    BOOL isGpsOpen = [CLLocationManager locationServicesEnabled];
    return isGpsOpen?@"1":@"0";
}

@end
