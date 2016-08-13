//
//  YSCardListModel.m
//  吃啥
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSCardListModel.h"


@implementation YSCardListModel

+ (instancetype)cardListModelWithDictionary:(NSDictionary *)dicData{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    YSCardListModel *cardListModel = [YSCardListModel new];
    cardListModel.card_name = dicData[@"card_name"];
    cardListModel.card_title = dicData[@"card_title"];
    cardListModel.card_icon = dicData[@"card_icon"];
    NSDictionary *dicTemp = dicData[@"card_data"];
    cardListModel.card_data = [YSCardDataModel cardDataModelWithDictionary:dicTemp ];
    return cardListModel;
}

@end
