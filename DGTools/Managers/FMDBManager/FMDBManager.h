//
//  FMDBManager.h
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FMDBManager : NSObject

/*1
 *
 */
+ (BOOL)execUpdataWithSQl:(NSString *)sqlStr;

/*
 * 2
 */

// 1,2 功能相同
+ (BOOL)execUpdata:(NSString *)nameStr andSQl:(NSString *)sqlStr;

/*
 * 创建表
 * 创建表的方法有得修改
 *
 */

+ (BOOL)execCreateSql:(NSString *)tableName
            andUserId:(NSString *)userId
              andTime:(NSString *)timeStr
           andMessage:(NSString *)message
         andAvatarURL:(NSString *)string;

/* 创建一个个人设置的表
 *
 *
 */
+ (BOOL)execCreateSql:(NSString *)tableName
            andUserId:(NSString *)userId
          andPhoneNum:(NSString *)phoneNum
         andFirstPage:(NSString *)firstPage
         andTopRoomId:(NSString *)topRoomId
          andRoomName:(NSString *)roomName;

/*
 * 刷新数据库
 * @parameter tableName 表名
 * @parameter value_map
 *
 */

+ (void)executeUpdate:(NSString *)tableName
              andDict:(NSDictionary *)value_map
          andCondDict:(NSDictionary *)condition_map;

/*
 * 插入数据
 * @parameter tableName 表名
 * @parameter dict 数据结构
 *
 */
+ (void)executeInsert:(NSString *)tableName
              andDict:(NSDictionary *)dict;


/*
 * 通过某一字段查询表
 * tableName 表名
 * keyName 键名
 * valueName 值名
 */

+ (NSMutableArray *)executeSelectTable:(NSString *)tableName
                            andKeyName:(NSString *)keyName
                          andValueName:(NSString *)valueName;
/*
 * 分页查询
 * @parameter tableName 表名
 * @parameter limit 查询多少条结果
 * @parameter offset 分的页数
 */
+ (NSMutableArray *)executeSelet:(NSString *)tableName
                        andLimit:(NSInteger)limit
                       andOffset:(NSInteger)offset;



/*
 * 更新数据库 根据某一字段
 *
 */

+ (BOOL)excuteUpdateSql:(NSString *)tableName
                 setKey:(NSString *)setkey
               setValue:(NSString *)setValue
         setKeyRoomName:(NSString *)keyRoomName
          valueRoomName:(NSString *)valueRoomName
                  byKey:(NSString *)byKey
                byValue:(NSString *)byValue;

/*
 * 删除数据
 * @parameter tableName 表明
 * @parameter dict 表参数
 *
 */
+ (BOOL)executeDelete:(NSString *)tableName
              andDict:(NSDictionary *)dict;
@end
