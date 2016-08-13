//
//  YSInfoResult.h
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSInfoStuffModel.h"
#import "YSInfoStepsModel.h"

@interface YSResultInfoModel : NSObject

/** Cover 图片*/
@property (nonatomic,copy) NSString *Cover;
/** Title 标题*/
@property (nonatomic,copy) NSString *Title;
/** Intro 描述*/
@property (nonatomic,copy) NSString *Intro;
/** Tips 小贴士*/
@property (nonatomic,copy) NSString *Tips;
/** CookTime 制作时间*/
@property (nonatomic,copy) NSString *CookTime;
/** Steps 操作步骤*/
@property (nonatomic,strong) NSMutableArray *Steps;
/** 存放Stuff 材料的数组*/
@property (nonatomic,strong) NSMutableArray *Stuff;

+ (instancetype)resultInfoWithDictionary:(NSDictionary *)dicData;

@end
