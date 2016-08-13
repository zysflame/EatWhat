//
//  YSMenuDataModel.m
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSMenuDataModel.h"

@implementation YSMenuDataModel

+ (instancetype)menuDataModelWithDictionary:(NSDictionary *)dicData{
    YSMenuDataModel *menuDataModel = [YSMenuDataModel new];
    
    menuDataModel.menuName = dicData[@"menuName"];
    menuDataModel.menuPic = dicData[@"menuPic"];
    menuDataModel.menuState = dicData[@"menuState"];
    
    NSArray *arrStep = dicData[@"menuStep"];
    menuDataModel.menuStep = [NSMutableArray arrayWithCapacity:arrStep.count];
    for (NSDictionary *dic in arrStep) {
        YSMenuStepModel *stepModel = [YSMenuStepModel menuStepModelWithDictionary:dic];
        [menuDataModel.menuStep addObject:stepModel];
    }
    
    NSArray *arrStuff = dicData[@"menuMaterial"];
    menuDataModel.menuMaterial = [NSMutableArray arrayWithCapacity:arrStuff.count];
    for (NSDictionary *dicMaterial in arrStuff) {
        YSMenuMaterialModel *stuffModel = [YSMenuMaterialModel materialModelWithDictionary:dicMaterial];
        [menuDataModel.menuMaterial addObject:stuffModel];
    }

    return menuDataModel;
}

@end
