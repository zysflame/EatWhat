//
//  YSRenQiViewController.h
//  吃啥
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSBreakfastViewController : UIViewController

/** itemHeight 按钮的高度*/
@property (nonatomic,assign) CGFloat numItemHeight;

/** 标题*/
@property (nonatomic,copy) NSString *strTitle;

///** 标题视图的网址*/
@property (nonatomic,copy) NSString *strheadPic;

/** HeaderIMVURL 网址*/
@property (nonatomic,copy) NSString *strHeaderIMVURL;


@end
