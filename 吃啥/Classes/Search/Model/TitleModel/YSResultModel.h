//
//  YSResultModel.h
//  吃啥
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSRecommandModel.h"
#import "YSCardListModel.h"

@interface YSResultModel : NSObject

/** carousel_recommand 推荐*/
@property (nonatomic,strong) YSRecommandModel *recommandModel;

@property (nonatomic,strong) NSMutableArray *carousel_recommand;
/** 卡片列表 card_list*/
@property (nonatomic,strong) NSMutableArray *card_list;

+ (instancetype)resultModelWithDictionary:(NSDictionary *)dicData;

@end
