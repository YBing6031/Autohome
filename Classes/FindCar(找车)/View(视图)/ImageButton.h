//
//  ImageButton.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Image;
@interface ImageButton : UIButton


@property (nonatomic, strong) Image *image;

/**"id": "2963009",*/
@property (nonatomic, assign) NSInteger id;

/**"isuserup": 0,*/
@property (nonatomic, assign) BOOL isuserup;
/**"membername": "",*/
@property (nonatomic, copy) NSString *membername;
/**"smallpic": "http://car0.autoimg.cn/car/upload/2015/4/20/t_201504202203395054178110.jpg",*/
@property (nonatomic, copy) NSString *smallpic;
/**"specid": "19830",*/
@property (nonatomic, assign) NSInteger specid;

/**"specname": "2015款 6.0L S",*/
@property (nonatomic, copy) NSString *specname;
/**"typeid": 1*/
@property (nonatomic, assign) NSInteger typeid;

@end
