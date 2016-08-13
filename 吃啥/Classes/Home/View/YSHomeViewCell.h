//
//  YSSearchViewCell.h
//  吃啥
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSHomeListModel.h"

@interface YSHomeViewCell : UITableViewCell

@property (nonatomic,strong) YSHomeListModel *homeListModel;

/** 创建cell的类方法*/
+ (instancetype)homeCellWithTableView:(UITableView *)tableView;

@end
