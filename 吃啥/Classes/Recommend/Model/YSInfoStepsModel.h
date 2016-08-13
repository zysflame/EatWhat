//
//  YSInfoStepsModel.h
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSInfoStepsModel : NSObject

/** StepPhoto 图片*/
@property (nonatomic,copy) NSString *StepPhoto;

/** Intro 操作*/
@property (nonatomic,copy) NSString *Intro;

+ (instancetype)stepsModelWithDictionary:(NSDictionary *)dicData;

@end
