//
//  DocumentManager.m
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "DocumentManager.h"

@implementation DocumentManager

#pragma mark - Get Document Path
+(NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

#pragma mark 获取Document目录下filename文件路径
+ (NSString *)getPathForDocuments:(NSString *)filename
{
    return [[self getDocumentPath] stringByAppendingPathComponent:filename];
}
#pragma mark - Get Cache Path
+ (NSString *)getCachePath
{
    NSArray * fileArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [fileArr objectAtIndex:0];
    return cachePath;
}

#pragma mark 获取Cache目录下filename文件路径
+ (NSString *)getPathForCache:(NSString *)filename
{
    NSString *tmpStr = [NSString stringWithFormat:@"/%@",filename];
    return [[self getCachePath] stringByAppendingPathComponent:tmpStr];
}

#pragma mark - 根据路径检查文件是否存在
+(BOOL)isFileExists:(NSString *)filepath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}

#pragma mark - 删除指定路径下的文件
+ (void)deleteLibCacheFile:(NSString *)filepath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filepath];
    if (!blHave) {
        NSLog(@"no have");
        return ;
    }else {
        NSLog(@"have");
        BOOL blDele= [fileManager removeItemAtPath:filepath error:nil];
        if (blDele) {
            NSLog(@"delete success");
        }else {
            NSLog(@"delete fail");
        }
    }
}

@end
