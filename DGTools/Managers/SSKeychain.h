//
//  SSKeychain.h
//  MXMobile
//
//  Created by tianfeng on 14-3-12.
//  Copyright (c) 2014年 Wandusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

typedef enum {
	SSKeychainErrorNone = noErr,
	SSKeychainErrorBadArguments = -1001,
	SSKeychainErrorNoPassword = -1002,
	SSKeychainErrorInvalidParameter = errSecParam,
	SSKeychainErrorFailedToAllocated = errSecAllocate,
	SSKeychainErrorNotAvailable = errSecNotAvailable,
	SSKeychainErrorAuthorizationFailed = errSecAuthFailed,
	SSKeychainErrorDuplicatedItem = errSecDuplicateItem,
	SSKeychainErrorNotFound = errSecItemNotFound,
	SSKeychainErrorInteractionNotAllowed = errSecInteractionNotAllowed,
	SSKeychainErrorFailedToDecode = errSecDecode
} SSKeychainErrorCode;

extern NSString *const kSSKeychainErrorDomain;
extern NSString *const kSSKeychainAccountKey;
extern NSString *const kSSKeychainCreatedAtKey;
extern NSString *const kSSKeychainClassKey;
extern NSString *const kSSKeychainDescriptionKey;
extern NSString *const kSSKeychainLabelKey;
extern NSString *const kSSKeychainLastModifiedKey;
extern NSString *const kSSKeychainWhereKey;
@interface SSKeychain : NSObject
+ (NSArray *)allAccounts;
+ (NSArray *)allAccounts:(NSError **)error;
+ (NSArray *)accountsForService:(NSString *)serviceName;
+ (NSArray *)accountsForService:(NSString *)serviceName error:(NSError **)error;
+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account;
+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error;
+ (NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account;
+ (NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error;
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account;
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error;
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account;
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error;
+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account;
+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error;
#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType;
+ (void)setAccessibilityType:(CFTypeRef)accessibilityType;
#endif

@end
