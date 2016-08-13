//
//  YSInfoTableHeaderView.h
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSInfoTableHeaderView : UIView

/** 制作时间*/
@property (nonatomic,copy) NSString *strCookTime;
/** Tips 小贴士*/
@property (nonatomic,copy) NSString *strTips;
/** intro 介绍*/
@property (nonatomic,copy) NSString *strIntro;
/** cover 图片*/
@property (nonatomic,copy) NSString *strCover;
/** title 食物名字*/
@property (nonatomic,copy) NSString *strTitle;


@end
