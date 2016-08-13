//
//  YSMenuModel.m
//  吃啥
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSMenuModel.h"

@implementation YSMenuModel

+ (instancetype)menuModelWithDictionary:(NSDictionary *)dicData{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    YSMenuModel *menuModel = [YSMenuModel new];
    menuModel.menuPic = dicData[@"menuPic"];
    menuModel.menuTitle = dicData[@"menuTitle"];
    menuModel.menuMaterial = dicData[@"menuMaterial"];
    menuModel.userName = dicData[@"userName"];
    menuModel.menuTimer = dicData[@"menuTimer"];
    menuModel.collectNum = dicData[@"collectNum"];
    menuModel.isCollect = dicData[@"isCollect"];
    menuModel.makeNum = dicData[@"makeNum"];
    menuModel.menuId = dicData[@"menuId"];
    return menuModel;
}

@end
