//
//  QYItemView.m
//  Demo04_QYNews
//
//  Created by qingyun on 16/7/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

/** Color Related */


#import "YSMainMangerView.h"

@implementation YSMainMangerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadItemSetting];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self loadItemSetting];
    }
    return self;
}

- (void)loadItemSetting {
    self.backgroundColor = [UIColor lightTextColor];
}

#pragma mark  > setter方法 <
- (void)setArrTitles:(NSArray *)arrTitles{
    _arrTitles = [arrTitles copy];
    CGFloat itemWidth = YSScreenWidth / _arrTitles.count;
    CGFloat itemHeight = self.bounds.size.height;
    NSUInteger count = _arrTitles.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btnItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnItem setTitle:_arrTitles[index] forState:UIControlStateNormal];
        [btnItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnItem setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        [btnItem addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchDown];
        btnItem.backgroundColor = [UIColor yellowColor];
        [btnItem setFrame:CGRectMake(index * itemWidth, 0, itemWidth, itemHeight)];
        btnItem.tag = index;
        [self addSubview:btnItem];
    }
    
    [self setContentSize:CGSizeMake(count * itemWidth, itemHeight)];

}


- (void)chooseAction:(UIButton *)button {
    // 把所有的UIButton置为未选中
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.enabled = YES;
        }
    }
    // 选中用户选中的按钮, 如果contentSize的大小有一个为0, 这个方法就不起作用
    button.enabled = NO;
    
    // 让指定的区域可见
    [self scrollRectToVisible:button.frame animated:YES];
    
    // 回调Block
    if (self.blkDidChooseButtonAtIndex) {
        self.blkDidChooseButtonAtIndex(button.tag);
    }
}

- (void)chooseIndex:(NSInteger)indexChoosed {
    NSUInteger count = self.arrTitles.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btnItem = self.subviews[index];
        if ([btnItem isKindOfClass:[UIButton class]] && btnItem.tag == indexChoosed) {
            [self chooseAction:btnItem];
            break;
        }
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    NSUInteger count = self.arrTitles.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btnItem = self.subviews[index];
        if ([btnItem isKindOfClass:[UIButton class]] && btnItem.tag == 0) {
            [self chooseAction:btnItem];
            break;
        }
    }
}

@end
