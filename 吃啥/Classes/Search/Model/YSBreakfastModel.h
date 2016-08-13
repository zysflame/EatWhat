//
//  YSBreakfast.h
//  吃啥
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSBreakfastModel : NSObject

/** result  结果*/
@property (nonatomic,copy) NSString *result;
/** allPage 总页数*/
@property (nonatomic,copy) NSString *allPage;
/** materialName 物质名字 */
@property (nonatomic,copy) NSString *materialName;
/** data 的数组*/
@property (nonatomic,strong) NSMutableArray *data;

+ (instancetype)breakfastModelWithDictionary:(NSDictionary *)dicData;


@end
