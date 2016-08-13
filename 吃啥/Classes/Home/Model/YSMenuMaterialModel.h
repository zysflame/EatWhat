//
//  YSMenuMaterialModel.h
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSMenuMaterialModel : NSObject

/** materialName 食材名称*/
@property (nonatomic,copy) NSString *materialName;
/** materialWeight 重量*/
@property (nonatomic,copy) NSString *materialWeight;

+ (instancetype)materialModelWithDictionary:(NSDictionary *)dicData;
@end
