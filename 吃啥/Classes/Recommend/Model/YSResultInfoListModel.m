//
//  YSResultInfoListModel.m
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSResultInfoListModel.h"

@implementation YSResultInfoListModel

+ (instancetype)infoListModelWithDictionary:(NSDictionary *)dicData{
    YSResultInfoListModel *infoListModel = [YSResultInfoListModel new];
    infoListModel.Cover = dicData[@"Cover"];
    infoListModel.Title = dicData[@"Title"];
    infoListModel.RecipeId = dicData[@"RecipeId"];
    return infoListModel;
}

@end
