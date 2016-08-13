//
//  YSInfoStepsModel.m
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSInfoStepsModel.h"

@implementation YSInfoStepsModel

+ (instancetype)stepsModelWithDictionary:(NSDictionary *)dicData{
    YSInfoStepsModel *stepModel = [YSInfoStepsModel new];
    stepModel.StepPhoto = dicData[@"StepPhoto"];
    stepModel.Intro = dicData[@"Intro"];
    return stepModel;
}

@end
