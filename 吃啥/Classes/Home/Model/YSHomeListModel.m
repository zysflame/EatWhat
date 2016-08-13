//
//  YSHomeListModel.m
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSHomeListModel.h"

@implementation YSHomeListModel

+ (instancetype)homeListModelWithDictionary:(NSDictionary *)dicData{
    YSHomeListModel *homeListModel = [YSHomeListModel new];
    homeListModel.strID = dicData[@"id"];
    homeListModel.pic = dicData[@"pic"];
    homeListModel.title = dicData[@"title"];
    return homeListModel;
}

@end
