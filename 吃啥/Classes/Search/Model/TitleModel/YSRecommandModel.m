//
//  YSRecommandModel.m
//  吃啥
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSRecommandModel.h"

@interface YSRecommandModel ()

@end

@implementation YSRecommandModel

+ (instancetype)recommandModelWithDictionary:(NSDictionary *)dicRecommand{
    if (dicRecommand == nil || [dicRecommand isKindOfClass:[NSNull class]]) return nil;
    YSRecommandModel *recommandModel = [self new];
    recommandModel.head_pic = dicRecommand[@"head_pic"];
    recommandModel.head_text = dicRecommand[@"head_text"];
    recommandModel.dish_list = dicRecommand[@"dish_list"];
    return recommandModel;
}

@end
