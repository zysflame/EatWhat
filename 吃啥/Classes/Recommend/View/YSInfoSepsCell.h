//
//  YSRecommandInfoCell.h
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSInfoStepsModel.h"

@interface YSInfoSepsCell : UITableViewCell

@property (nonatomic,strong) YSInfoStepsModel *stepModel;

/** 创建cell的类方法*/
+ (instancetype) sepsCellWithTableView:(UITableView *)tableView;

@end
