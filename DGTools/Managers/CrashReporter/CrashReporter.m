//
//  CrashReporter.m
//  DGTools
//
//  Created by Gavin on 16/3/14.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "CrashReporter.h"
#import <CrashReporter/CrashReporter.h>
#import <AFNetworking/AFNetworking.h>
#import "DeviceInfoManager.h"
//#import "TNAUser.h"

//获取磁盘剩余空间

#include <sys/param.h>
#include <sys/mount.h>
#import <CoreLocation/CoreLocation.h>

@interface CrashReporter()

//  其他需要写入文件的字段
@property (nonatomic,strong)NSDictionary * dict;

@end

@implementation CrashReporter

#pragma mark - 单例实例化
+ (CrashReporter *)defaultTools{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)start{
    
#ifdef DEBUG
    NSLog(@"Debug模式  关闭crash检测");
#else
    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc]
                                     initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeMach
                                     symbolicationStrategy: PLCrashReporterSymbolicationStrategyNone];
    PLCrashReporter *crashReporter = [[PLCrashReporter alloc]initWithConfiguration:config];
    NSError *error;
    if ([crashReporter hasPendingCrashReport]) {
        [self handleCrashReport];
    }
    
    if (![crashReporter enableCrashReporterAndReturnError:&error]) {
        NSLog(@"Warning: Could not enable crash reporter: %@", error);
    }
    
    [self postData];
    
#endif
}


-(void)handleCrashReport {
    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType: PLCrashReporterSignalHandlerTypeMach
                                                                       symbolicationStrategy: PLCrashReporterSymbolicationStrategyAll];
    PLCrashReporter *crashReporter = [[PLCrashReporter alloc]initWithConfiguration:config];
    NSData *crashData;
    NSError *error;
    
    crashData = [crashReporter loadPendingCrashReportDataAndReturnError:&error];
    if(error){
    }
    if (crashData == nil) {
        NSLog(@"Could not load crash report: %@", error);
        [crashReporter purgePendingCrashReport];
        return;
    }
    PLCrashReport *report = [[PLCrashReport alloc] initWithData: crashData error: &error];
    /* CrashData 还需要用 PLCrashReporter 的工具 crashutil 解析，也可以直接保存成字符串*/
    NSString * crashInfo = [PLCrashReportTextFormatter stringValueForCrashReport:report withTextFormat:PLCrashReportTextFormatiOS];
    
    //    记录其他需要保存的数据
    [self loadInfo];
    //     将所有的值存到数据中
    NSString *infos = @"";
    for(NSString *key in [self.infoDict allKeys]){
        NSString *str = [NSString stringWithFormat:@"\n%@   %@",key,self.infoDict[key]];
        infos = [infos stringByAppendingString:str];
    }
    NSString *crashInfos = [crashInfo stringByAppendingString:infos];
    NSData *crashDatas = [crashInfos dataUsingEncoding:NSUTF8StringEncoding];
    /* CrashData 可以直接上传到服务器上，下面的代码是保存到 Document 中 */
    NSArray *docPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [docPathArray firstObject];
    NSString *path = [docPath stringByAppendingString:@"/crashdata.crash"];
    [crashDatas writeToFile:path atomically:YES];
    [crashReporter purgePendingCrashReport];
    
}
#pragma mark 发送数据
- (void)postData{
    
    NSData *data;
    //转码成UTF-8  否则可能会出现错误
    NSString *filePath = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/crashdata.crash"];
    data = [NSData dataWithContentsOfFile:filePath];
    if(data){
        //上传
        NSString *URLTmp = @"http://192.168.0.1:8080/upLoadserver";
        NSString *URLTmps = [URLTmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        URLTmp = URLTmps;
        NSDictionary * body = [NSDictionary dictionary];
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLTmp parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            [formData appendPartWithFileData:data name:@"headerImg" fileName:@"crash.crash" mimeType:@"image/png"];
            
        } error:nil];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSProgress *progress = nil;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            if (error) {
                //上传失败
                NSLog(@"Error: %@", error);
            }else{
                //上传成功，删除崩溃日志
                NSFileManager *fileManager = [NSFileManager defaultManager];
                BOOL bRet = [fileManager fileExistsAtPath:filePath];
                if (bRet) {
                    //
                    NSError *err;
                    [fileManager removeItemAtPath:filePath error:&err];
                }
            }
        }];
        [uploadTask resume];
    }
}

#pragma mark 记录需要保存的数据
- (void)loadInfo{
    
    self.infoDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *batteryQuantity = [NSString stringWithFormat:@"%lf",[DeviceInfoManager getBatteryQuantity]];
    //  设备标示
    NSString * deviceToken = [DeviceInfoManager UUID];
    //  APP版本
    NSString *appVersion = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleVersion"];
    //  所有的磁盘
    NSString *totalDiskSpaceInBytes = [NSString stringWithFormat:@"%lf",[DeviceInfoManager getTotalDiskSpaceInBytes]];
    //  磁盘剩余
    NSString *diskSurplus =[NSString stringWithFormat:@"%lld",[DeviceInfoManager freeSpace]];
    //  总内存大小
    NSString *totalMemoerySize = [NSString stringWithFormat:@"%lld",[DeviceInfoManager getTotalMemorySize]];
    //  内存剩余
    NSString *internalMemorySurplus = [NSString stringWithFormat:@"%f",[DeviceInfoManager availableMemory]];
    //  获取crashID
    NSString *crashId = [DeviceInfoManager getUniqueStrByUUID];
    //  用户ID
//    NSString *userId = [UserModel sharedInstance].userId;
    //  网络制式 （2G,3G,4G,LTE,WIFI）
    NSString * networktype = [DeviceInfoManager getNetworktype];
    
    NSString *ui_orientation = [DeviceInfoManager getOrientation];
    
/*-------------------------------------------------------------------------------------------------------------------------------*/
    [self.infoDict setValue:batteryQuantity forKey:@"batteryQuantity"];
    
    [self.infoDict setValue:deviceToken forKey:@"deviceToken"];
    
    [self.infoDict setValue:appVersion forKey:@"appVersion"];
    
    [self.infoDict setValue:diskSurplus forKey:@"diskSurplus"];
    
    [self.infoDict setValue:totalDiskSpaceInBytes forKey:@"totalDiskSpaceInBytes"];
    
    [self.infoDict setValue:internalMemorySurplus forKey:@"internalMemorySurplus"];
    
    [self.infoDict setValue:totalMemoerySize forKey:@"totalMemoerySize"];
    
    [self.infoDict setValue:crashId forKey:@"crashId"];
    
//    [self.infoDict setValue:userId forKey:@"userId"];
    
    [self.infoDict setValue:networktype forKey:@"networktype"];
    
    [self.infoDict setValue:ui_orientation forKey:@"ui_orientation"];
}

@end
