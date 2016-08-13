//
//  YSHomeViewCell.m
//  吃啥
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSSearchViewCell.h"
#import "YSMenuModel.h"

@interface YSSearchViewCell ()
{
    /** 菜品的图片*/
    __weak IBOutlet UIImageView *_imvHeader;
    /** 菜名*/
    __weak IBOutlet UILabel *lblMenuTitle;
    /** 原料*/
    __weak IBOutlet UILabel *lblMaterial;
}

@end

@implementation YSSearchViewCell

+ (instancetype)searchCellWithTableView:(UITableView *)tableView{
    // 创建一个cell
    static NSString *strId = @"YSSearchViewCell";
    YSSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSSearchViewCell" owner:self options:nil] firstObject];
    }
    return cell;
}

- (void)setMenuModel:(YSMenuModel *)menuModel{
    _menuModel = menuModel;
    NSURL *imvURL = [NSURL URLWithString:_menuModel.menuPic];
    [_imvHeader sd_setImageWithURL:imvURL];
    lblMenuTitle.text = [NSString stringWithFormat:@"名称：%@",_menuModel.menuTitle];
    lblMaterial.text = [NSString stringWithFormat:@"材料：%@", _menuModel.menuMaterial ];
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
