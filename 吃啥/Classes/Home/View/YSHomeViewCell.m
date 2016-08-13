//
//  YSSearchViewCell.m
//  吃啥
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSHomeViewCell.h"

@interface YSHomeViewCell ()
{
    /** 标题图片*/
    __weak IBOutlet UIImageView *imvPic;
    /** 标题*/
    __weak IBOutlet UILabel *lblTitle;
}

@end

@implementation YSHomeViewCell

#pragma mark  > 创建时使用的类方法 <
+ (instancetype)homeCellWithTableView:(UITableView *)tableView{
    static NSString *strId = @"YSHomeViewCell";
    YSHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSHomeViewCell" owner:self options:nil] firstObject];
    }
    return cell;
}

- (void)setHomeListModel:(YSHomeListModel *)homeListModel{
    _homeListModel = homeListModel;
    
    NSString *strURL = _homeListModel.pic;
    NSURL *picURL = [NSURL URLWithString:strURL];
    [imvPic sd_setImageWithURL:picURL];
    
    lblTitle.text = _homeListModel.title;
}

#pragma 纯代码时会加载此方法
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self loadDefaultSetting];
    }
    return self;
}
#pragma mark 使用xib时会加载此方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadDefaultSetting];
    }
    return self;
}
#pragma mark 唤醒xib视图
- (void)awakeFromNib{
    [super awakeFromNib];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
