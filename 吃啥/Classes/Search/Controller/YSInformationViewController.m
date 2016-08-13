//
//  YSInformationViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSInformationViewController.h"

#import "YSInfoTableHeaderView.h"
#import "YSRecommandInfoStuffCell.h"
#import "YSInfoSepsCell.h"


#import "YSResultInfoModel.h"

@interface YSInformationViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UIWebView *webView;


@property (nonatomic, weak) UITableView *tableView;

/**  存放材料的数组*/
@property (nonatomic,copy) NSArray *arrStuff;
/**  存放操作步骤的数组 */
@property (nonatomic,copy) NSArray *arrSteps;


/** 制作时间*/
@property (nonatomic,copy) NSString *strCookTime;
/** Tips 小贴士*/
@property (nonatomic,copy) NSString *strTips;
/** intro 介绍*/
@property (nonatomic,copy) NSString *strIntro;
/** cover 图片*/
@property (nonatomic,copy) NSString *strCover;
/** title 食物名字*/
@property (nonatomic,copy) NSString *strTitle;

@property (nonatomic,weak) UIImageView *imvHeader;

@end

@implementation YSInformationViewController

- (void)loadView {
    UIWebView *webView = [[UIWebView alloc] init];
    //webView.frame = self.view.bounds;
    self.view = webView;
    self.webView = webView;
}

//- (void)viewWillAppear:(BOOL)animated{
//    [self requestInformation];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    NSString *str = [NSString stringWithFormat:@"http://www.chufang001.com/menu/show/%@.html",self.strID];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
//    self.title = self.strTitle;
//    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.estimatedRowHeight = 50;
//    tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
//    [self.view addSubview:tableView];
//    self.tableView = tableView;
//    
//    //    YSInfoTableHeaderView *headerView = [YSInfoTableHeaderView new];
//    UIImageView *imvHeader = [UIImageView new];
//    imvHeader.bounds = CGRectMake(0, 0, 0, 250);
//    tableView.tableHeaderView = imvHeader;
//    self.imvHeader = imvHeader;
    
}

- (void)requestInformation{
    NSString *str = [NSString stringWithFormat:@"http://www.chufang001.com/menu/show/%@.html",self.strID];
    [[YSHTTPRequest sharedHTTPRequest] GETWithURL:str withParam:nil andRequestSuccess:^(id responseObject) {
        NSLog(@">>>>%@",responseObject);
    } andRequestFailure:^(NSError *error) {
        NSLog(@"请求失败");
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"网络不好，请耐心等待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *alertDengLuAction = [UIAlertAction actionWithTitle:@"刷新试试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf requestInformation];
        }];
        [alertContorller addAction:alertDengLuAction];
        [alertContorller addAction:alertAction];
        [self presentViewController:alertContorller animated:YES completion:nil];
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num = 0;
    if (section == 0) {
        num = self.arrStuff.count;
    }
    if(section == 1){
        num = self.arrSteps.count;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *strID = @"StuffCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:strID];
        }
        YSInfoStuffModel *stuffModel = self.arrStuff[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",stuffModel.name];
        cell.detailTextLabel.text = stuffModel.weight;
        return cell;
        
        //        YSRecommandInfoStuffCell *stuffCell = [YSRecommandInfoStuffCell infoStuffCellWithTableView:tableView];
        //        return stuffCell;
    }
    
    static NSString *strID = @"SepsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    YSInfoStepsModel *stepsModel = self.arrSteps[indexPath.row];
    NSURL *imvURL = [NSURL URLWithString:stepsModel.StepPhoto];
    [cell.imageView sd_setImageWithURL:imvURL];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld %@",indexPath.row + 1,stepsModel.Intro];
    return cell;
    //    YSInfoSepsCell *cell = [YSInfoSepsCell sepsCellWithTableView:tableView];
    //    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"食材";
    }else{
        return @"步骤";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return self.strCookTime;
    }else{
        return self.strTips;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return 130;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
