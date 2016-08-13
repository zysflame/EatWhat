//
//  YSRecommandModel.h
//  吃啥
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSFoodModel : NSObject

/** item_id 食物的ID */
@property (nonatomic,copy) NSString *item_id;
/** name 食物的名字*/
@property (nonatomic,copy) NSString *name;
/** shop_id 商店的id*/
@property (nonatomic,copy) NSString *shop_id;
/** url 网址*/
@property (nonatomic,copy) NSString *url;
/** saled 出售*/
@property (nonatomic,copy) NSString *saled;
/** current_price 当前的价格*/
@property (nonatomic,copy) NSString *current_price;
/** origin_price 原来的价格*/
@property (nonatomic,copy) NSString *origin_price;
/** category_id 类别的id*/
@property (nonatomic,copy) NSString *category_id;
/** recommand_reason 推荐原因 */
@property (nonatomic,copy) NSString *recommand_reason;
/** strategy_source */
@property (nonatomic,copy) NSString *strategy_source;
/** left_num  */
@property (nonatomic,copy) NSString *left_num;
/** specialmarkchain  */
@property (nonatomic,copy) NSString *specialmarkchain;


+ (instancetype)foodModelWiyhDictionary:(NSDictionary *)dicData;

@end
