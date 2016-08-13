//
//  YSHomeListModel.h
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSHomeListModel : NSObject

/** id  */
@property (nonatomic,copy) NSString *strID;
/** pic 图片*/
@property (nonatomic,copy) NSString *pic;
/** title 标题*/
@property (nonatomic,copy) NSString *title;

+ (instancetype)homeListModelWithDictionary:(NSDictionary *)dicData;

@end
