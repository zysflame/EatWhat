//
//  YSMenuModel.h
//  吃啥
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSMenuModel : NSObject

/** menuPic 图片网址*/
@property (nonatomic,copy) NSString *menuPic;
/** menuTitle  标题*/
@property (nonatomic,copy) NSString *menuTitle;
/** menuMaterial 原料*/
@property (nonatomic,copy) NSString *menuMaterial;
/** userName */
@property (nonatomic,copy) NSString *userName;
/** menuTimer */
@property (nonatomic,copy) NSString *menuTimer;
/** collectNum 收藏数量*/
@property (nonatomic,copy) NSString *collectNum;
/** isCollect 是否收藏*/
@property (nonatomic,copy) NSString *isCollect;
/** makeNum 制作数量*/
@property (nonatomic,copy) NSString *makeNum;
/** menuId 食物ID */
@property (nonatomic,copy) NSString *menuId;

+ (instancetype)menuModelWithDictionary:(NSDictionary *)dicData;

@end
