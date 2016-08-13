//
//  YSRecommandModel.m
//  吃啥
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSFoodModel.h"

@implementation YSFoodModel

+ (instancetype)foodModelWiyhDictionary:(NSDictionary *)dicData{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    YSFoodModel *foodModel = [YSFoodModel new];
    foodModel.item_id = dicData[@"item_id"];
    foodModel.name = dicData[@"name"];
    foodModel.shop_id = dicData[@"shop_id"];
    foodModel.saled = dicData[@"saled"];
    foodModel.current_price = dicData[@"current_price"];
    foodModel.origin_price = dicData[@"origin_price"];
    foodModel.category_id = dicData[@"category_id"];
    foodModel.left_num  = dicData[@"left_num"];
    foodModel.recommand_reason = dicData[@"recommand_reason"];
    foodModel.strategy_source = dicData[@"strategy_source"];
    foodModel.specialmarkchain = dicData[@"specialmarkchain"];
    foodModel.url = dicData[@"url"];
//    NSRange range = [strURL rangeOfString:@"@s_2"];
//    if (range.location != NSNotFound) {
//        NSString *strTemp = [strURL substringToIndex:range.location];
//        foodModel.url = strTemp;
//    }
    return foodModel;
}

@end
