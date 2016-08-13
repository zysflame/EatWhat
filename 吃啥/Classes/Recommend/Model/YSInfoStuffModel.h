//
//  YSInfoStuffModel.h
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSInfoStuffModel : NSObject

/** name 食材名字*/
@property (nonatomic,copy) NSString *name;
/** weight 数量 */
@property (nonatomic,copy) NSString *weight;

+ (instancetype)stuffModelWithDictionary:(NSDictionary *)dicData;

@end
