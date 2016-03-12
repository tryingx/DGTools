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
+ (NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if(!documentsDirectory) {
        NSLog(@"Documents 目录未找到");
    }
    
    return documentsDirectory;
}

#pragma mark 获取Document目录下filename文件路径
+ (NSString *)getPathForDocuments:(NSString *)filename
{
    NSString * filePath = [[self getDocumentPath] stringByAppendingPathComponent:filename];
    
    if(!filePath) {
        NSLog(@"FilePath 目录未找到");
    }
    return filePath;
}

#pragma mark 将文件以FileName写入文件到DocumentPath下
+ (BOOL)writeFileToDocumentsPathForFileName:(NSString *)fileName File:(id)file
{
    NSString *filePath = [self getPathForDocuments:fileName];
    
    return [file writeToFile:filePath atomically:YES];
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

#pragma mark 将文件以FileName写入文件到CachePath下
+ (BOOL)writeFileToCachePathForFileName:(NSString *)fileName File:(id)file
{
    NSString *filePath = [self getPathForCache:fileName];
    
    return [file writeToFile:filePath atomically:YES];
}

#pragma mark - Get Temp Path
+ (NSString *)getTempPath
{
    NSString *tempPath = NSTemporaryDirectory();
    return tempPath;
}

#pragma mark 获取Temp目录下filename文件路径
+ (NSString *)getPathForTemp:(NSString *)filename
{
    NSString *tmpStr = [NSString stringWithFormat:@"/%@",filename];
    return [[self getTempPath] stringByAppendingPathComponent:tmpStr];
}

#pragma mark 将文件以FileName写入文件到TempPath下
+ (BOOL)writeFileToTempPathForFileName:(NSString *)fileName File:(id)file
{
    NSString *filePath = [self getPathForTemp:fileName];
    
    return [file writeToFile:filePath atomically:YES];
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
