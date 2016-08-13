//
//  ViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "YSNavigationViewController.h"
#import "HomeMainViewController.h"
#import "YSRecommendViewController.h"
#import "YSProfileViewController.h"
#import "YSSearchViewController.h"


/** 按钮的高度*/
static CGFloat const itemHeight = 50;

@interface MainTabBarViewController () 

/** 创建存放控制器的数组*/
@property (nonatomic,copy)NSArray *arrControllers;

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    [self loadNavigationSetting];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadTabBarController];
}

- (void)loadTabBarController{
    HomeMainViewController *HomeVC = [HomeMainViewController new];
    HomeVC.numItemHeight = itemHeight;
    [self addViewController:HomeVC WithImageName:@"tabbar_home" Title:@"首页"];
    
    YSRecommendViewController *recommendVC = [YSRecommendViewController new];
    [self addViewController:recommendVC WithImageName:@"tabbar_random" Title:@"随便看看"];
    recommendVC.numItemHeight = itemHeight;
    
    YSSearchViewController *SearchVC = [[YSSearchViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self addViewController:SearchVC WithImageName:@"tabbar_discover" Title:@"推荐"];
    
    YSProfileViewController *profileVC = [YSProfileViewController new];
    profileVC.numItemHeight = itemHeight;
    [self addViewController:profileVC WithImageName:@"tabbar_profile" Title:@"我的"];
}

#pragma mark 加载导航栏设置
- (void)loadNavigationSetting{
//    self.title = @"首页";
    
}

- (void)addViewController:(UIViewController *)viewCotroller WithImageName:(NSString *)imageName Title:(NSString *)title{
    viewCotroller.tabBarItem.image = [UIImage imageNamed:imageName];
    viewCotroller.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]];
    viewCotroller.title = title;
    viewCotroller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    self.tabBar.tintColor = [UIColor orangeColor];
    self.tabBar.barTintColor = [UIColor lightTextColor];
    YSNavigationViewController *navigationVC = [[YSNavigationViewController alloc] initWithRootViewController:viewCotroller];
    [self addChildViewController:navigationVC];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
