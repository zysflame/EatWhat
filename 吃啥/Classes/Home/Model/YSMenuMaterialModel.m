//
//  YSMenuMaterialModel.m
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSMenuMaterialModel.h"

@implementation YSMenuMaterialModel

+ (instancetype)materialModelWithDictionary:(NSDictionary *)dicData{
    YSMenuMaterialModel *materialModel = [YSMenuMaterialModel new];
    materialModel.materialName = dicData[@"materialName"];
    materialModel.materialWeight = dicData[@"materialWeight"];
    return materialModel;
}

@end
