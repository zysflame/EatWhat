//
//  YSCardData.m
//  吃啥
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSCardDataModel.h"
#import "YSFoodModel.h"

@implementation YSCardDataModel

+ (instancetype)cardDataModelWithDictionary:(NSDictionary *)dicData{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    YSCardDataModel *cardDataModel = [YSCardDataModel new];
    cardDataModel.total = dicData[@"total"];
   
 
    NSArray *arrTemp = dicData[@"dish_list"];
    NSUInteger count = arrTemp.count;
    cardDataModel.dish_list = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index ++) {
        NSDictionary *dic = arrTemp[index];
        YSFoodModel *foodmodel = [YSFoodModel foodModelWiyhDictionary:dic];
        [cardDataModel.dish_list addObject:foodmodel];
    }
    
    NSArray *arrShopList = dicData[@"shop_list"];
    NSUInteger countShopList = arrShopList.count;
    if (countShopList) {
        cardDataModel.shop_list = [NSMutableArray arrayWithCapacity:countShopList];
        for (NSUInteger index = 0; index < count; index ++) {
            NSDictionary *dic = arrShopList[index];
            YSFoodModel *foodmodel = [YSFoodModel foodModelWiyhDictionary:dic];
            [cardDataModel.shop_list addObject:foodmodel];
        }
    }


    return cardDataModel;
}

@end
