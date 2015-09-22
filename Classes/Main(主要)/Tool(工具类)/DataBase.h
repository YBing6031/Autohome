//
//  DataBase.h
//  Sqlite
//
//  Created by aoyolo1 on 15/5/14.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;
@interface DataBase : NSObject
@property(nonatomic, strong)FMDatabase *db;
+ (instancetype)shareDataBase;

- (void)insertCollectToDataBaseWithSeriesid:(NSInteger)seriesid name:(NSString *)name price:(NSString *)price imgurl:(NSString *)imgurl;
- (void)deleteCollectWithSeriesid:(NSInteger)seriesid;
- (void)selectCollect:(NSMutableArray *)collectArray;
- (BOOL)isCollectedWithSericesid:(NSInteger)seriesid;
@end
