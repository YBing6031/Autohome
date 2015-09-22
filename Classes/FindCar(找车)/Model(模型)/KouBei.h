//
//  KouBei.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KouBei : NSObject

/**"grade": "4.12",*/
@property (nonatomic, copy) NSString *grade;
/**"peoplenum": 3955,*/
@property (nonatomic, assign) NSInteger peoplenum;

/**"selllist":[]*/
@property (nonatomic, strong) NSArray *selllist;
/**stoplist*/
@property (nonatomic, strong) NSArray *stoplist;
@end
