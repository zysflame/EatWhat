//
//  YSBreakfast.m
//  吃啥
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSBreakfastModel.h"

#import "YSMenuModel.h"

@implementation YSBreakfastModel

+ (instancetype)breakfastModelWithDictionary:(NSDictionary *)dicData{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    YSBreakfastModel *breskdastModel = [YSBreakfastModel new];
    breskdastModel.result = dicData[@"result"];
    breskdastModel.allPage = dicData[@"allPage"];
    breskdastModel.materialName = dicData[@"materialName"];
    NSArray *arrTemp = dicData[@"data"];
    breskdastModel.data = [NSMutableArray arrayWithCapacity:arrTemp.count];
    for (NSDictionary *dic in arrTemp) {
        YSMenuModel *menuModel = [YSMenuModel menuModelWithDictionary:dic];
        [breskdastModel.data addObject:menuModel];
    }
    return breskdastModel;
}

@end
