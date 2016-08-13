//
//  YSRecommandModel.h
//  吃啥
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSFoodModel.h"

@interface YSRecommandModel : NSObject

/** head_text 标题*/
@property (nonatomic,copy) NSString *head_text;
/** head_pic 标题的图片的网址*/
@property (nonatomic,copy) NSString *head_pic;
///** 食物模型*/
//@property (nonatomic,copy) YSFoodModel *foodModel;
/** 数组*/
@property (nonatomic,copy) NSArray *dish_list;

+ (instancetype)recommandModelWithDictionary:(NSDictionary *)dicRecommand;

@end
