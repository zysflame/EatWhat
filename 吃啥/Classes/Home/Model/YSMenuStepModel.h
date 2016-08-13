//
//  YSMenuStepModel.h
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSMenuStepModel : NSObject

/** stepPic 图片*/
@property (nonatomic,copy) NSString *stepPic;
/** stepState 叙述*/
@property (nonatomic,copy) NSString *stepState;

+ (instancetype)menuStepModelWithDictionary:(NSDictionary *)dicData;
@end
