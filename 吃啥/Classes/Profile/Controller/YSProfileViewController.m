//
//  YSProfileViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSProfileViewController.h"

#import "YSHelpViewController.h"
#import "YSFunctionViewController.h"
#import "YSImprintViewController.h"

@interface YSProfileViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
/** 存放标题的数组*/
@property (nonatomic,copy) NSArray *arrTitles;
@end

@implementation YSProfileViewController

- (NSArray *)arrTitles{
    if (!_arrTitles) {
        _arrTitles = @[@"帮助",@"功能介绍",@"退出"];
    }
    return _arrTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.rowHeight = 230;
//    tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;

}

#pragma mark  > UITableViewDataSource  <
/** 设置组数*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

/** 设置行数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.arrTitles.count -1;
    }else{
        return 1;
    }
}

/** 设置每组的cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strID = @"strIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.text = self.arrTitles[indexPath.row];
    }else{
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
        cell.textLabel.text = [self.arrTitles lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self helpViewController];
                break;
            case 1:
                [self functionViewController];
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 1){
        // 退出程序的操作
        exit(0);
//        [UIView animateWithDuration:1 animations:^{
//            self.view.frame = CGRectMake(-(self.view.frame.size.width),-(self.view.frame.size.height), self.view.frame.size.height,self.view.frame.size.width);
//        } completion:^(BOOL finished) {
//            exit(0);
//        }];
    }
}

#pragma mark  > 帮助控制器 <
- (void)helpViewController{
//    YSHelpViewController *helpVC = [YSHelpViewController new];
//    [self.navigationController pushViewController:helpVC animated:YES];

    UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"帮助" message:@"1、首页是推荐的\n2、随便看看是随机推荐的\n3、推荐是对早中晚三餐的推荐\n4、我的是一些基本设置" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
    
    [alertContorller addAction:alertAction];
    [self presentViewController:alertContorller animated:YES completion:nil];
}

#pragma mark  > 功能介绍 <
- (void)functionViewController{
//    YSFunctionViewController *functionVC = [YSFunctionViewController new];
//    [self.navigationController pushViewController:functionVC animated:YES];
    UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"功能介绍" message:@"1、首页是推荐的\n2、随便看看是随机推荐的\n3、推荐是对早中晚三餐的推荐\n4、我的是一些基本设置" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
    
    [alertContorller addAction:alertAction];
    [self presentViewController:alertContorller animated:YES completion:nil];
}
#pragma mark  > 版本信息 <
- (void)imprinyViewController{
//    YSImprintViewController *imprintVC = [YSImprintViewController new];
//    [self.navigationController pushViewController:imprintVC animated:YES];
    UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"版本提示" message:@"当前版本为1.0" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
    
    [alertContorller addAction:alertAction];
    [self presentViewController:alertContorller animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
