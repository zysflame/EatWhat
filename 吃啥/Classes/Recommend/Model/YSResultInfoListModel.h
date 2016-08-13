//
//  YSResultInfoListModel.h
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSResultInfoListModel : NSObject

/** Cover 图片网址*/
@property (nonatomic,copy) NSString *Cover;
/** Title  标题*/
@property (nonatomic,copy) NSString *Title;
/** RecipeId 食物ID*/
@property (nonatomic,copy) NSString *RecipeId;

+ (instancetype)infoListModelWithDictionary:(NSDictionary *)dicData;

@end
