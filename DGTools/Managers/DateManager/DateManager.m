//
//  DateManager.m
//  DGTools
//
//  Created by Gavin on 16/3/12.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "DateManager.h"

@implementation DateManager

+(NSString *)currentDate{
    
    NSDate * date = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * dateStr = [df stringFromDate:date];
    
    return [NSString stringWithFormat:@"reloadFlowTable%@",dateStr];
}

@end
