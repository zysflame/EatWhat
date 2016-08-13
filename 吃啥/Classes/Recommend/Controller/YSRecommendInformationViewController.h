//
//  YSRecommendInformationViewController.h
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSRecommendInformationViewController : UIViewController
/** RecipeId  食物的ID*/
@property (nonatomic,copy) NSString *strRecipeId;

/** itemHeight 按钮的高度*/
@property (nonatomic,assign) CGFloat numItemHeight;
@end
