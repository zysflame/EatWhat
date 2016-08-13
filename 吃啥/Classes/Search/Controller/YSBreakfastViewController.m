//
//  YSRenQiViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSBreakfastViewController.h"
#import "YSSearchViewCell.h"

#import "YSResultModel.h"

#import "YSBreakfastModel.h"
#import "YSInformationViewController.h"
static NSInteger page = 1;

@interface YSBreakfastViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

/** 标题视图*/
@property (nonatomic,weak) UIImageView *headerIMV;
/** 存放模型的数组*/
@property (nonatomic,copy) NSMutableArray *arrMenuModels;

@end

@implementation YSBreakfastViewController


- (void)viewWillAppear:(BOOL)animated{
//     [self loadNewData];
    [self requestInformation];
    [self sendRequest];
}

#pragma mark  > 发送网络请求 <
- (void)sendRequest{
    // 推荐
    NSString *strURL = @"http://14.215.177.67/mobileui/strategy/v1/mainpage?resid=1001&from=na-android&os=4.4.4&sv=4.0.0&cuid=7BB58804E580050AC1DFC61CDBFB6B6D%7C486828320138768&model=MI4LTE&screen=1080*1920&channel=com.xiaomi&loc_lat=4115513.692114&loc_lng=1.2642806444422E7&city_id=268&aoi_id=13638730612458242555&address=%E6%96%B0%E5%BC%80%E6%99%AE%E7%94%B5%E5%AD%90%E8%82%A1%E4%BB%BD%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8&net_type=wifi&isp=46002&request_time=1470223963280";
    NSDictionary *dicPrograme = @{@"bduss":@"lXflpOd0M5TURYNFA3T1VEcUZON1VMZmQ5b3U1RFlEM1VVU0xNVWphTXQxLVpXQVFBQUFBJCQAAAAAAAAAAAEAAACplUsdWte5wuS3srO-WgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC1Kv1YtSr9WN3",@"stoken":@"295004617b5d76a4ea392a88b73617bb9fd0817ff3f9814f9fd2f03bd89be3fd",@"lng":@"1.2642806444422E7",@"lat":@"4115513.692114"};
    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicPrograme andRequestSuccess:^(id responseObject) {
        NSDictionary *dic = responseObject;
        YSResultModel *resultModel = [YSResultModel resultModelWithDictionary:dic[@"result"]];
        YSRecommandModel *recommandModel = resultModel.recommandModel;
        
        NSString *strheadPic = recommandModel.head_pic;
        NSURL *headerImvUrl = [NSURL URLWithString:strheadPic];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.headerIMV sd_setImageWithURL:headerImvUrl];
            [weakSelf.tableView reloadData];
        });
    } andRequestFailure:^(NSError *error) {
        NSLog(@">>>>失败%@",error);
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"网络不好，请耐心等待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *alertDengLuAction = [UIAlertAction actionWithTitle:@"刷新试试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf loadNewData];
        }];
        [alertContorller addAction:alertDengLuAction];
        [alertContorller addAction:alertAction];
        [self presentViewController:alertContorller animated:YES completion:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = YSColorRandom;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 100;
    
    tableView.contentInset = UIEdgeInsetsMake(self.numItemHeight + YSNavigationBarHeight, 0, self.numItemHeight, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    __weak typeof(self) weakSelf = self;
    [self.tableView addGifRefreshHeaderWithClosure:^{
        [weakSelf loadNewData];
    }];
    [self.tableView addGifRefreshFooterWithClosure:^{
        [weakSelf loadNewData];
    }];
    
    UIImageView *headerIMV = [UIImageView new];
    headerIMV.bounds = CGRectMake(0, 0, 0, 80);
    headerIMV.image = [UIImage imageNamed:@"welcom"];
    self.headerIMV = headerIMV;
    tableView.tableHeaderView = headerIMV;
    //    NSString *strHeaderIMVURL = @"http://img.waimai.bdimg.com/pb/8e1ca59548f5762f22f8cd8dd1124cb3a0";
    //    NSURL *headerImvUrl = [NSURL URLWithString:self.strHeaderIMVURL];
    //    [self.headerIMV sd_setImageWithURL:headerImvUrl];
    
    UILabel *lblTitle = [UILabel new];
    lblTitle.bounds = CGRectMake(0, 0, 100, 45);
    lblTitle.center = headerIMV.center;
    //    lblTitle.text = self.strTitle;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.font = [UIFont systemFontOfSize:20 weight:0.8];
    lblTitle.textColor = [UIColor blueColor];
    [headerIMV addSubview:lblTitle];
}

#pragma mark  > 下拉刷新时触发的方法 <
- (void)loadNewData{
    page += 1;
//    [self sendRequest];
    [self requestInformation];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView endRefreshing];
        [weakSelf.tableView reloadData];
    });
}

#pragma mark  > 发送网络请求 <
- (void)requestInformation{
    NSString *strURL = @"http://115.231.110.203/appapi/searchBytag.asp";
    NSDictionary *dicPrograme = @{@"appName":@"味他",@"keyCode":@"9CF79B0613B7FB19258B19196C6D5559",@"timeStamp":@"1470468928486",@"materialId":@"1223",@"page":@(page),@"pageSize":@"10",@"insideCode":@"10013",@"appType":@"1",@"ipAddress":@"115.231.110.203",@"version":@"2.1.1"};
    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicPrograme andRequestSuccess:^(id responseObject) {
        //        NSLog(@"请求成功>>>>%@",responseObject);
        NSDictionary *dic = responseObject;
        YSBreakfastModel *breakfastModel = [YSBreakfastModel breakfastModelWithDictionary:dic];
        //注:在block块中实现ui的操作,都要在主线程中操作
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *strMateriaName = breakfastModel.materialName;
            weakSelf.strTitle = strMateriaName;
            weakSelf.arrMenuModels = breakfastModel.data;
            [weakSelf.tableView reloadData];
        });
    } andRequestFailure:^(NSError *error) {
        NSLog(@">>>>失败%@",error);
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"网络不好，请耐心等待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *alertDengLuAction = [UIAlertAction actionWithTitle:@"刷新试试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf loadNewData];
        }];
        [alertContorller addAction:alertDengLuAction];
        [alertContorller addAction:alertAction];
        [self presentViewController:alertContorller animated:YES completion:nil];
    }];
}

#pragma mark  > UITableViewDataSource  <
/** 设置组数*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrMenuModels.count;
}

/** 设置行数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

/** 设置每组的cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSSearchViewCell *cell = [YSSearchViewCell searchCellWithTableView:tableView];
    cell.menuModel = self.arrMenuModels[indexPath.section];
    return cell;
}

#pragma mark  > 设置每个section的header <
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 0,50 );
    view.backgroundColor = [UIColor orangeColor];
    return view;
}

#pragma mark  > UITableViewDelegate  <
/** 选中的row进行的操作*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YSInformationViewController *inforVC = [YSInformationViewController new];
    YSMenuModel *menuModel = self.arrMenuModels[indexPath.section];
    inforVC.strID = menuModel.menuId;
    [self.navigationController pushViewController:inforVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
