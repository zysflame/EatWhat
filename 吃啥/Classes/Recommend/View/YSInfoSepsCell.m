//
//  YSRecommandInfoCell.m
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSInfoSepsCell.h"

@interface YSInfoSepsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imvHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblDsc;

@end

@implementation YSInfoSepsCell

#pragma mark  > 创建时使用的类方法 <
+ (instancetype)sepsCellWithTableView:(UITableView *)tableView{
    static NSString *strId = @"YSInfoSepsCell";
    YSInfoSepsCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSInfoSepsCell" owner:self options:nil] firstObject];
    }
    return cell;
}

- (void)setStepModel:(YSInfoStepsModel *)stepModel{
    _stepModel = stepModel;
    
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
