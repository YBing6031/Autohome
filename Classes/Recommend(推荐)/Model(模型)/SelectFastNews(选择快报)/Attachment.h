//
//  Attachment.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attachment : NSObject

/**"attachtype": 0,*/
@property (nonatomic, assign) NSInteger attachtype;
/**"height": 524,*/
@property (nonatomic, assign) CGFloat height;
/**"ordernum": 0,*/
@property (nonatomic, assign) NSInteger ordernum;
/**"picurl": "http://app0.autoimg.cn/zx/newspic/2015/6/7/2015060714534021628.jpg",*/
@property (nonatomic, copy) NSString *picurl;
/**"videourl": "",*/
@property (nonatomic, copy) NSString *videourl;
/**"width": 700*/
@property (nonatomic, assign) CGFloat width;

@end
