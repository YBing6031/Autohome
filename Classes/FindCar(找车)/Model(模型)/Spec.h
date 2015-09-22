//
//  Spec.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Spec : NSObject

/**"description": "前置前驱 5挡手动",*/
@property (nonatomic, copy) NSString *description1;
/**"id": 17198,*/
@property (nonatomic, assign) NSInteger id;

/**"minprice": "4.58万起",*/
@property (nonatomic, copy) NSString *minprice;
/**"name": "2014款 1.3L 手动超值版",*/
@property (nonatomic, copy) NSString *name;
/**"paramisshow": "1",*/
@property (nonatomic, copy) NSString *paramisshow;
/**"price": "6.98万",*/
@property (nonatomic, copy) NSString *price;
/**"state": 20,*/
@property (nonatomic, assign) NSInteger state;

/**"structure": ""*/
@property (nonatomic, copy) NSString *structure;


/**"piccount": 0*/
@property (nonatomic, assign) NSInteger piccount;



/**"displacement": 1.4,*/
@property (nonatomic, assign) CGFloat displacement;

/**"enginepower": "90",*/
@property (nonatomic, copy) NSString *enginepower;
/**"flowmodename": "自然吸气",*/
@property (nonatomic, copy) NSString *flowmodename;
/**"grade": "4.22",*/
@property (nonatomic, copy) NSString *grade;
/**"peoplenum": 92,*/
@property (nonatomic, assign) NSInteger peoplenum;

/**"specid": 19251,*/
@property (nonatomic, assign) NSInteger specid;

/**"specname": "2014款 1.4L 手动舒适版",*/
@property (nonatomic, copy) NSString *specname;
/**"year": "2014"*/
@property (nonatomic, copy) NSString *year;



@end
