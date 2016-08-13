//
//  YSInfoStuffModel.m
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSInfoStuffModel.h"

@implementation YSInfoStuffModel

+ (instancetype)stuffModelWithDictionary:(NSDictionary *)dicData{
    YSInfoStuffModel *stuffModel = [YSInfoStuffModel new];
    stuffModel.name = dicData[@"name"];
    stuffModel.weight = dicData[@"weight"];
    return stuffModel;
}

@end
