//
//  YSSearchViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSSearchViewController.h"
#import "YSBreakfastViewController.h"
#import "YSLunchViewController.h"
#import "YSEveningViewController.h"

#import "YSMainMangerView.h"

#import "YSResultModel.h"
/** 按钮的高度*/
static CGFloat const itemHeight = 50;

@interface YSSearchViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

/** 存放控制器的数组*/
@property (nonatomic,copy)NSArray *arrControllers;
/** 控制器的索引 */
@property (nonatomic, assign) NSInteger indexController;
/** 存放标题题目的数组*/
@property (nonatomic, copy) NSArray *arrTitles;
/** 标题的滑动按钮*/
@property (nonatomic, weak) YSMainMangerView *itemView;

///** 存放card_name 为shoprecommend的数组*/
//@property (nonatomic,strong) NSMutableArray *arrMShopRecommand;
/** 存放card_name 为dishrecommend的数组 */
//@property (nonatomic,strong) NSMutableArray *arrMDishRecommand;
///** 存放card_name 为其他的数组*/
//@property (nonatomic,strong) NSMutableArray *arrMOther;
/** HeaderIMVURL 网址*/
@property (nonatomic,copy) NSString *strHeaderIMVURL;

@end

@implementation YSSearchViewController

#pragma mark  > 懒加载控制器标题 <
- (NSArray *)arrTitles{
    if (!_arrTitles) {
        _arrTitles = @[@"营养早餐",@"午餐推荐",@"晚餐推荐"];
    }
    return _arrTitles;
}

#pragma mark  > 懒加载控制器数组 <
- (NSArray *)arrControllers{
    if (!_arrControllers) {
        YSBreakfastViewController *breakfastVC = [YSBreakfastViewController new];
        breakfastVC.numItemHeight = itemHeight;
        breakfastVC.strTitle = self.arrTitles[0];
        breakfastVC.strHeaderIMVURL = self.strHeaderIMVURL;
        
        YSLunchViewController *lunchVC = [YSLunchViewController new];
        lunchVC.numItemHeight = itemHeight;
        lunchVC.strTitle = self.arrTitles[1];
        lunchVC.strHeaderIMVURL = self.strHeaderIMVURL;
        
        YSEveningViewController *eveningVC = [YSEveningViewController new];
        eveningVC.numItemHeight = itemHeight;
        eveningVC.strTitle = self.arrTitles[2];
        eveningVC.strHeaderIMVURL = self.strHeaderIMVURL;
 
        _arrControllers = @[breakfastVC,lunchVC,eveningVC];
    }
    return _arrControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = YSColorRandom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataSource = self;
    self.delegate = self;
    
    YSMainMangerView *itemView = [YSMainMangerView new];
    itemView.frame = CGRectMake(0, 64, self.view.bounds.size.width, itemHeight);
    [self.view addSubview: itemView];
    itemView.arrTitles = self.arrTitles;
    self.itemView = itemView;
    __weak typeof(self) selfWeak = self;
    [itemView setBlkDidChooseButtonAtIndex:^(NSUInteger index){
        // 把index对应的控制器从_arrControllers取出来
        [selfWeak chooseViewControllerAtIndex:index];
    }];
}

#pragma mark 点击标题选择 对应的控制器
- (void)chooseViewControllerAtIndex:(NSInteger)index {
    UIPageViewControllerNavigationDirection direction;
    if (index > self.indexController) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    YSBreakfastViewController *shopRecommandVC = self.arrControllers[index];
    [self setViewControllers:@[shopRecommandVC] direction:direction animated:YES completion:nil];
    self.indexController = index;
}


#pragma mark - UIPageViewControllerDataSource, UIPageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    for (NSInteger index = 0; index < _arrControllers.count; index ++) {
        YSBreakfastViewController *renQiVC = _arrControllers[index];
        if (renQiVC == viewController) {
            if (index + 1 < _arrControllers.count) {
                return _arrControllers [index + 1];
            }
        }
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    for (NSInteger index = 0; index < _arrControllers.count; index ++) {
        YSBreakfastViewController *shopVC = _arrControllers[index];
        if (shopVC == viewController) {
            if (index - 1 >= 0) {
                return _arrControllers[index - 1];
            }
        }
    }
    return nil;
    
}

/** 完成动画的时候调用 */
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    // 获取当前的控制器
    YSBreakfastViewController *shopVC = self.viewControllers.firstObject;
    NSUInteger count = self.arrControllers.count;
    for (NSUInteger index = 0; index < count; index ++) {
        YSBreakfastViewController *vcTemp = self.arrControllers[index];
        if (vcTemp == shopVC) {
            [self.itemView chooseIndex:index];
            break;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
