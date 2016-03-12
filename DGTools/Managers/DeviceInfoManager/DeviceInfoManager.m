//
//  DeviceInfoManager.m
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "DeviceInfoManager.h"

#include <sys/socket.h>

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

@end
