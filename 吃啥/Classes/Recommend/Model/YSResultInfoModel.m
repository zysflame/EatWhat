//
//  YSInfoResult.m
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSResultInfoModel.h"


@implementation YSResultInfoModel

+ (instancetype)resultInfoWithDictionary:(NSDictionary *)dicData{
    YSResultInfoModel *resultInfo = [YSResultInfoModel new];
    resultInfo.Cover = dicData[@"Cover"];
    resultInfo.Title = dicData[@"Title"];
    resultInfo.Intro = dicData[@"Intro"];
    resultInfo.CookTime = dicData[@"CookTime"];
    resultInfo.Tips = dicData[@"Tips"];
    NSArray *arrStep = dicData[@"Steps"];
    resultInfo.Steps = [NSMutableArray arrayWithCapacity:arrStep.count];
    for (NSDictionary *dic in arrStep) {
        YSInfoStepsModel *stepModel = [YSInfoStepsModel stepsModelWithDictionary:dic];
        [resultInfo.Steps addObject:stepModel];
    }
    
    NSArray *arrStuff = dicData[@"Stuff"];
    resultInfo.Stuff = [NSMutableArray arrayWithCapacity:arrStuff.count];
    for (NSDictionary *dicSuff in arrStuff) {
        YSInfoStuffModel *stuffModel = [YSInfoStuffModel stuffModelWithDictionary:dicSuff];
        [resultInfo.Stuff addObject:stuffModel];
    }
    return resultInfo;
}

@end
