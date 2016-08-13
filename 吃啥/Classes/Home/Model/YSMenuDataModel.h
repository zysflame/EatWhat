//
//  YSMenuDataModel.h
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSMenuStepModel.h"
#import "YSMenuMaterialModel.h"

@interface YSMenuDataModel : NSObject

/** menuName 食物名称*/
@property (nonatomic,copy) NSString *menuName;
/** menuPic 图片*/
@property (nonatomic,copy) NSString *menuPic;
/** menuState 描述*/
@property (nonatomic,copy) NSString *menuState;
/** 存放食材的数组*/
@property (nonatomic,strong) NSMutableArray *menuMaterial;
/** 存放步骤的数组*/
@property (nonatomic,strong) NSMutableArray *menuStep;

+ (instancetype)menuDataModelWithDictionary:(NSDictionary *)dicData;

@end
