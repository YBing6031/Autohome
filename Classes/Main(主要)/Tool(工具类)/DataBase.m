//
//  DataBase.m
//  Sqlite
//
//  Created by aoyolo1 on 15/5/14.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "DataBase.h"
#import "FMDB.h"

@implementation DataBase

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"DataBase.db"];
        NSLog(@"%@", dbPath);
        _db = [FMDatabase databaseWithPath:dbPath];//创建数据库
        _db.logsErrors = YES;//错误信息自动打印
        //使用数据库之前打开数据库
        if ([_db open]) {
            NSLog(@"open database successed");
        }
        
        if (![_db executeUpdate:@"create table Collect(ID integer PRIMARY Key,SERIESID integer,NAME text not null,PRICE text, IMGURL text)"])
        {
            NSLog(@"create table failed!");
        }
    }
    return self;
}

+ (instancetype)shareDataBase
{
    static DataBase *database = nil;
    if (database == nil) {
        database = [[DataBase alloc] init];
    }
    return database;
}

- (void)insertCollectToDataBaseWithSeriesid:(NSInteger)seriesid name:(NSString *)name price:(NSString *)price imgurl:(NSString *)imgurl
{
    [_db executeUpdate:@"insert into Collect(SERIESID,NAME,PRICE,IMGURL)values(?,?,?,?)", @(seriesid), name, price, imgurl];
}

- (void)deleteCollectWithSeriesid:(NSInteger)seriesid
{
    [_db executeUpdate:@"delete from Collect where SERIESID=?", @(seriesid)];
}

- (void)selectCollect:(NSMutableArray *)collectArray
{
        FMResultSet *result = [_db executeQuery:@"select * from Collect"];//查找
        //[result next] 从结果集读取数据
        while ([result next]) {
            NSString *name = [result stringForColumn:@"NAME"];
            NSInteger sericesid = [result intForColumn:@"SERIESID"];
            NSString *price = [result stringForColumn:@"PRICE"];
            NSString *imgurl = [result stringForColumn:@"IMGURL"];
            [collectArray addObject:@{@"seriesid":@(sericesid),
                                      @"name":name,
                                      @"price":price,
                                      @"imgurl":imgurl}];
        }
}

- (BOOL)isCollectedWithSericesid:(NSInteger)seriesid
{
    FMResultSet *result = [_db executeQuery:@"select count(*) from Collect where SERIESID=?", @(seriesid)];//查找
    int count = 0;
    while ([result next]) {
        count = [result intForColumnIndex:0];
    }
    return count;
}

//- (void)updatePersonInfo:(Person *)person
//{
//    [_db executeUpdate:@"update Person set NAME=?,AGE=?,ICON=? where ID=?", person.name, @(person.age), person.icon, @(person.personID)];
//}

@end
