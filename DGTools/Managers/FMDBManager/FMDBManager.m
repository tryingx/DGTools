//
//  FMDBManager.m
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx All rights reserved.
//

#define dbName @"DGToolsdb.sqlite"

#import "FMDBManager.h"

NSString *fileDBName(NSString *dbNameStr);

//  查询 填充数组
void execQuery(NSString *dbname, NSString *sql ,NSMutableArray **results);

NSString *createInsertSQL(NSString *tableNameStr,NSDictionary *dict);

//  查表 (limit 表明查询多少条结果 ,offset 表示从多少条之后开始查)
NSString *sqliteSelect(NSString *tableName, NSInteger limit, NSInteger offset);

//  通过某一字段查表
NSString *sqliteSelectOneTable(NSString *tableName, NSString *keyName, NSString *valueName);

//  删除表内数据
NSString *createDeleteSQL(NSString *tablename,NSDictionary *condition_map);

BOOL execUpdate(NSString *dbname, NSString *sql);

@implementation FMDBManager

#pragma mark - privateMethod
NSString *fileDBName(NSString *dbNameStr)
{
    NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *string = doc[0];
    NSString *fileName=[string stringByAppendingPathComponent:dbName];
    NSLog(@" -->> 文件名:%@",fileName);
    return fileName;
}

void execQuery(NSString *dbname, NSString *sql ,NSMutableArray **results)
{
    NSString *filePath = fileDBName(dbname);
    FMDatabase *database = [FMDatabase databaseWithPath:filePath];
    
    if (![database open]) {
        return;
    }
    FMResultSet *resultSet = [database executeQuery:sql];
    while ([resultSet next]) {
        NSMutableDictionary *record = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        for (int i =0 ; i<[resultSet columnCount]; i++) {
            NSString *key = [resultSet columnNameForIndex:i];
            NSString *value = [resultSet stringForColumn:key];
            if(value == nil){
                value = @"";
            }
            [record setObject:value forKey:key];
        }
        
        [*results addObject:record];
    }
}


BOOL execUpdate(NSString *dbname, NSString *sql)
{
    NSString *filePath = fileDBName(dbname);
    FMDatabase *database = [FMDatabase databaseWithPath:filePath];
    
    if (![database open]) {
        return false;
    }
    
    if (![database executeUpdate:sql]) {
        return false;
    }
    return true;
}

#pragma mark - 查表 通过字典查表
NSString *createSelectSQL(NSString *tablename,NSArray *column_list,NSDictionary *condition_map)
{
    if (tablename == nil) {
        return nil;
    }
    NSString *sqlString = @"select";
    
    NSString *fields = @"";
    
    if (column_list == nil || [column_list count]<1) {
        fields = @" * ";
    } else {
        for (int i = 0; i<[column_list count]; i++) {
            NSString *seperator = [fields length]<1?@" ":@",";
            fields = [[fields stringByAppendingString:seperator] stringByAppendingString:[column_list objectAtIndex:i]];
        }
        
        fields = [fields stringByAppendingString:@" "];
    }
    
    sqlString = [sqlString stringByAppendingString:fields];
    sqlString = [sqlString stringByAppendingString:@"from "];
    sqlString = [sqlString stringByAppendingString:tablename];
    
    if (condition_map == nil || [condition_map count]<1) {
        return sqlString;
    }
    sqlString = [sqlString stringByAppendingString:@" where "];
    
    NSString *conditions = @"";
    
    
    for (int j =0; j < [[condition_map allKeys] count]; j++) {
        
        NSString *key = [[condition_map allKeys] objectAtIndex:j];
        NSString *value = [condition_map objectForKey:key];
        
        NSString *seperator = [conditions length]<1?@"":@" and ";
        
        conditions = [[[[conditions stringByAppendingString:seperator] stringByAppendingString:key] stringByAppendingString:@"="] stringByAppendingString:value];
    }
    
    sqlString = [sqlString stringByAppendingString:conditions];
    
    return sqlString;
}


#pragma mark - 查表(通过条数) (limit 表明查询多少条结果 ,offset 表示从多少条之后开始查)
NSString *sqliteSelect(NSString *tableName, NSInteger limit, NSInteger offset)
{
    if(tableName == nil){
        return nil;
    }
    NSString *sqlString = @"select * from ";
    sqlString = [sqlString stringByAppendingString:tableName];
    if(limit != 0){
        
        NSString *limitStr = [NSString stringWithFormat:@" limit %ld",(long)limit];
        sqlString = [sqlString stringByAppendingString:limitStr];
        
        
        NSString * offsetStr = [NSString stringWithFormat:@" offset %d", limit * offset];
        sqlString = [sqlString stringByAppendingString:offsetStr];
        
        return sqlString;
    }else
        
        return sqlString;
}


#pragma mark - 通过某一个字段查表
NSString *sqliteSelectOneTable(NSString *tableName, NSString *keyName, NSString *valueName)
{
    if(tableName == nil){
        return nil;
    }
    NSString *sqlString = @"select * from ";
    sqlString = [sqlString stringByAppendingString:tableName];
    if(keyName == nil && valueName == nil){
        return sqlString;
    }
    
    sqlString = [sqlString stringByAppendingString:@" where"];
    sqlString = [NSString stringWithFormat:@" %@ %@ = \'%@\'",sqlString,keyName,valueName];
    
    return sqlString;
}


#pragma mark - 删除表内数据
NSString *createDeleteSQL(NSString *tablename,NSDictionary *condition_map)
{
    if (tablename == nil) {
        return nil;
    }
    NSString *sqlString = @"delete from ";
    sqlString = [sqlString stringByAppendingString:tablename];
    
    if (condition_map == nil || [condition_map count]<1) {
        return sqlString;
    }
    sqlString = [sqlString stringByAppendingString:@" where "];
    
    NSString *conditions = @"";
    
    for (int j =0; j < [[condition_map allKeys] count]; j++) {
        
        NSString *key = [[condition_map allKeys] objectAtIndex:j];
        NSString *value = [condition_map objectForKey:key];
        
        NSString *seperator = [conditions length]<1?@"":@" and ";
        
        conditions = [[[[conditions stringByAppendingString:seperator] stringByAppendingString:key] stringByAppendingString:@"="] stringByAppendingString:value];
    }
    
    sqlString = [sqlString stringByAppendingString:conditions];
    
    return sqlString;
    
}




//1,
+ (BOOL)execUpdataWithSQl:(NSString *)sqlStr
{
    BOOL isTrue = execUpdate(@"", sqlStr);
    return isTrue;
}

//2,
+ (BOOL)execUpdata:(NSString *)nameStr andSQl:(NSString *)sqlStr
{
    BOOL isTrue = execUpdate(nameStr, sqlStr);
    return isTrue;
}



//更新
NSString *createUpdateSQL(NSString *tablename, NSDictionary *value_map, NSDictionary *condition_map)
{
    if (tablename == nil || value_map == nil) {
        return nil;
    }
    NSString *sqlString = @"update ";
    
    sqlString = [sqlString stringByAppendingString:tablename];
    
    sqlString = [sqlString stringByAppendingString:@" set"];
    
    NSString *updateFields = @"";
    
    for (int i = 0; i<[[value_map allKeys] count]; i++) {
        
        NSString *seperator = [updateFields length]<1?@" ":@",";
        NSString *key = [[value_map allKeys] objectAtIndex:i];
        NSString *value = [value_map objectForKey:key];
        value = [NSString stringWithFormat:@"\"%@\"",value];
        
        updateFields = [[[[updateFields stringByAppendingString:seperator] stringByAppendingString:key] stringByAppendingString:@"="] stringByAppendingString:value];
    }
    
    sqlString = [sqlString stringByAppendingString:updateFields];
    
    if (condition_map == nil || [condition_map count]<1) {
        return sqlString;
    }
    sqlString = [sqlString stringByAppendingString:@" where "];
    
    NSString *conditions = @"";
    
    for (int j =0; j < [[condition_map allKeys] count]; j++) {
        
        NSString *key = [[condition_map allKeys] objectAtIndex:j];
        NSString *value = [condition_map objectForKey:key];
        
        NSString *seperator = [conditions length]<1?@"":@" and ";
        
        conditions = [[[[conditions stringByAppendingString:seperator] stringByAppendingString:key] stringByAppendingString:@"="] stringByAppendingString:value];
    }
    
    sqlString = [sqlString stringByAppendingString:conditions];
    
    return sqlString;
}


NSString *createInsertSQL(NSString *tablename,NSDictionary *value_map)
{
    if (tablename == nil || value_map == nil) {
        return nil;
    }
    NSString *sqlString = @"insert into ";
    sqlString = [sqlString stringByAppendingString:tablename];
    sqlString = [sqlString stringByAppendingString:@" ("];
    
    NSString *keyString = @"";
    
    for (int i = 0 ; i<[[value_map allKeys] count]; i++) {
        NSString *seperator = [keyString length]<1?@"":@",";
        NSString *key = [[value_map allKeys] objectAtIndex:i];
        keyString = [[keyString stringByAppendingString:seperator] stringByAppendingString:key];
    }
    sqlString = [sqlString stringByAppendingString:keyString];
    sqlString = [sqlString stringByAppendingString:@") values ("];
    
    NSString *valueString = @"";
    for (int j = 0 ; j<[[value_map allKeys] count]; j++) {
        
        NSString *seperator = [valueString length]<1?@"\"":@",\"";
        NSString *key = [[value_map allKeys] objectAtIndex:j];
        valueString = [[valueString stringByAppendingString:seperator] stringByAppendingString:[value_map objectForKey:key]];
        valueString = [valueString stringByAppendingString:@"\""];
    }
    
    sqlString = [sqlString stringByAppendingString:valueString];
    sqlString = [sqlString stringByAppendingString:@")"];
    
    return sqlString;
}



#pragma mark - 开放接口

+ (BOOL)execCreateSql:(NSString *)tableName
            andUserId:(NSString *)userId
              andTime:(NSString *)timeStr
           andMessage:(NSString *)message
         andAvatarURL:(NSString *)string
{
    NSString *filePath = fileDBName(@"");
    FMDatabase *database = [FMDatabase databaseWithPath:filePath];
    
    if([database open]){
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (ID INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT,'%@' TEXT, '%@' TEXT, '%@' TEXT)",tableName,userId,timeStr,message,string];
        BOOL res = [database executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
        [database close];
    }
    
    return YES;
}

+ (BOOL)execCreateSql:(NSString *)tableName
            andUserId:(NSString *)userId
          andPhoneNum:(NSString *)phoneNum
         andFirstPage:(NSString *)firstPage
         andTopRoomId:(NSString *)topRoomId
          andRoomName:(NSString *)roomName
{
    NSString *filePath = fileDBName(@"");
    FMDatabase *database = [FMDatabase databaseWithPath:filePath];
    
    if([database open]){
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (id INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT,'%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT)",tableName,userId,phoneNum,firstPage,topRoomId,roomName];
        BOOL res = [database executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
        [database close];
    }
    
    return YES;
}
#pragma mark - 通过表名刷新
+ (void)executeUpdate:(NSString *)tableName
              andDict:(NSDictionary *)value_map
          andCondDict:(NSDictionary *)condition_map
{
    NSString *sql = createUpdateSQL(tableName, value_map, condition_map);
    bool isyes = execUpdate(dbName,sql);
    NSLog(@"%d",isyes);
}

#pragma mark - 插入数据表
+ (void)executeInsert:(NSString *)tableName
              andDict:(NSDictionary *)dict
{
    NSString *sql = createInsertSQL(tableName, dict);
    bool isyes = execUpdate(@"",sql);
    NSLog(@"是否插入成功%d",isyes);
}


#pragma mark - 分页查询
+ (NSMutableArray *)executeSelet:(NSString *)tableName
                        andLimit:(NSInteger)limit
                       andOffset:(NSInteger)offset
{
    NSString *sqlStr = sqliteSelect(tableName, limit, offset * limit);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    execQuery(tableName, sqlStr, &arr);
    return arr;
}

#pragma mark - 通过某一字段查询表
+ (NSMutableArray *)executeSelectTable:(NSString *)tableName
                            andKeyName:(NSString *)keyName
                          andValueName:(NSString *)valueName
{
    NSString *sqlStr = sqliteSelectOneTable(tableName, keyName, valueName);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    execQuery(tableName, sqlStr, &arr);
    
    return arr;
}

#pragma mark - 更新数据库 根据某一字段
+ (BOOL)excuteUpdateSql:(NSString *)tableName
                 setKey:(NSString *)setkey
               setValue:(NSString *)setValue
         setKeyRoomName:(NSString *)keyRoomName
          valueRoomName:(NSString *)valueRoomName
                  byKey:(NSString *)byKey
                byValue:(NSString *)byValue

{
    
    bool isyes = NO;
    NSString *updateSql;
    NSString *filePath = fileDBName(@"");
    FMDatabase *database = [FMDatabase databaseWithPath:filePath];
    
    if([database open]){
        if([keyRoomName isEqualToString:@""] || [valueRoomName isEqualToString:@""]){
            updateSql = [NSString stringWithFormat:@"update %@ set %@ ='%@' where %@='%@'",tableName,setkey,setValue,byKey,byValue];
        }else{
            updateSql = [NSString stringWithFormat:@"update %@ set %@ ='%@',%@ = '%@' where %@='%@'",tableName,keyRoomName,valueRoomName,setkey,setValue,byKey,byValue];
        }
        isyes = execUpdate(@"",updateSql);
        if (isyes) {
            NSLog(@"error when insert db table");
        } else {
            NSLog(@"success to insert db table");
        }
        [database close];
    }
    
    return isyes;
}

#pragma mark - 删除某条数据
+ (BOOL)executeDelete:(NSString *)tableName andDict:(NSDictionary *)dict
{
    NSString *sql = createDeleteSQL(tableName, dict);
    BOOL isyes = execUpdate(@"",sql);
    NSLog(@"是否删除成功 %d ",isyes);
    return isyes;
}

@end
