//
//  YSMenuStepModel.m
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSMenuStepModel.h"

@implementation YSMenuStepModel

+ (instancetype)menuStepModelWithDictionary:(NSDictionary *)dicData{
    YSMenuStepModel *stepModel = [YSMenuStepModel new];
    stepModel.stepPic = dicData[@"stepPic"];
    stepModel.stepState = dicData[@"stepState"];
    return stepModel;
}

@end
