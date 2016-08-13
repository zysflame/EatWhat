//
//  YSCardData.h
//  吃啥
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSCardDataModel : NSObject

/** total 数量*/
@property (nonatomic,copy) NSString *total;
/** dish_list 数组*/
@property (nonatomic,strong) NSMutableArray *dish_list;
/** shop_list 数组*/
@property (nonatomic,strong) NSMutableArray *shop_list;

+ (instancetype)cardDataModelWithDictionary:(NSDictionary *)dicData;

@end
