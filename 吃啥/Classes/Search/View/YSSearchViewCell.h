//
//  YSHomeViewCell.h
//  吃啥
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSMenuModel.h"

@interface YSSearchViewCell : UITableViewCell

@property (nonatomic,strong) YSMenuModel *menuModel;

+ (instancetype)searchCellWithTableView:(UITableView *)tableView;

@end
