//
//  YSRecommandInfoStuffCell.h
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSInfoStuffModel.h"

@interface YSRecommandInfoStuffCell : UITableViewCell

@property (nonatomic,strong) YSInfoStuffModel *stuffModel;

/** 创建cell的类方法*/
+ (instancetype) infoStuffCellWithTableView:(UITableView *)tableView;

@end
