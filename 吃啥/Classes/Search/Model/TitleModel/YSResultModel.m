//
//  YSResultModel.m
//  吃啥
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSResultModel.h"


@implementation YSResultModel

+ (instancetype)resultModelWithDictionary:(NSDictionary *)dicData{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    YSResultModel *resultModel = [self new];
    resultModel.recommandModel = [YSRecommandModel recommandModelWithDictionary:dicData[@"carousel_recommand"]];
    NSDictionary *dicTemp = dicData[@"carousel_recommand"];
    NSArray *arrRecommand = dicTemp[@"dish_list"];
    for (NSDictionary *dicRecom in arrRecommand) {
        YSFoodModel *foodModel = [YSFoodModel foodModelWiyhDictionary:dicRecom];
        [resultModel.carousel_recommand addObject:foodModel];
    }
    
    
    NSArray *arrTemp = dicData[@"card_list"];
    NSUInteger count = arrTemp.count;
    resultModel.card_list = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index ++) {
        NSDictionary *dic = arrTemp[index];
        YSCardListModel *cardListModel = [YSCardListModel cardListModelWithDictionary:dic];
        [resultModel.card_list addObject:cardListModel];
    }

    return resultModel;
}

@end
