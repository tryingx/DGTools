//
//  DocumentManager.h
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentManager : NSObject

//  Get Document Path
+(NSString *)getDocumentPath;
//  获取Document目录下filename文件路径
+ (NSString *)getPathForDocuments:(NSString *)filename;

//  Get Cache Path
+ (NSString *)getCachePath;
//  获取Cache目录下filename文件路径
+ (NSString *)getPathForCache:(NSString *)filename;

//  根据路径检查文件是否存在
+(BOOL)isFileExists:(NSString *)filepath;

//  删除指定路径下的文件
+ (void)deleteLibCacheFile:(NSString *)filepath;

@end
