//
//  YSCardListModel.h
//  吃啥
//
//  Created by qingyun on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSCardDataModel.h"

@interface YSCardListModel : NSObject

/** card_name */
@property (nonatomic,copy) NSString *card_name;
/** card_title */
@property (nonatomic,copy) NSString *card_title;
/** card_icon  图片的网址*/
@property (nonatomic,copy) NSString *card_icon ;
/** card_data 数组 数据列表*/
@property (nonatomic,strong) YSCardDataModel *card_data;

+ (instancetype)cardListModelWithDictionary:(NSDictionary *)dicData;

@end
