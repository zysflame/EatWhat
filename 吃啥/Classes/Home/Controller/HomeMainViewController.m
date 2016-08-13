//
//  HomeMainViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HomeMainViewController.h"
#import "YSHomeViewCell.h"

#import "YSHomeInfoViewController.h"

#import "YSResultModel.h"
#import "YSHomeListModel.h"
@interface HomeMainViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

/** 标题视图*/
@property (nonatomic,weak) UIImageView *headerIMV;
/** 存放模型的数组*/
//@property (nonatomic,copy) NSMutableArray *arrFoodModels;
/** 存放card_name 为shoprecommend除外的数组*/
@property (nonatomic,strong) NSMutableArray *arrMData;
/** 请求下来后对应的数组的编号*/
@property (nonatomic,assign) NSUInteger numCurrent;

@end

@implementation HomeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadDefaultSetting];
    //    [self loadNavigationSetting];
}

- (void)viewWillAppear:(BOOL)animated{
    //    [self sendRequest];
    [self requestInformation];
}

#pragma mark  > 发送网络请求 <
- (void)requestInformation{
    
    NSString *strURL = @"http://www.chufang001.com/appapi/homePage.asp";
    NSDictionary *dicPrograme = @{@"appName":@"味他",@"keyCode":@"30822BE8F9A3BF917830CABAF1FE3AA1",@"insideCode":@"10013",@"timeStamp":@"1470713267687",@"appType":@"1",@"ipAddress":@"www.chufang001.com",@"version":@"2.1.1"};
    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicPrograme andRequestSuccess:^(id responseObject) {
        //        NSLog(@"请求成功>>>>%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSDictionary *dicData = dic[@"data"];
        NSArray *arrTemp = dicData[@"list"];
        //注:在block块中实现ui的操作,都要在主线程中操作
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.arrMData = [NSMutableArray arrayWithCapacity:arrTemp.count];
            for (NSDictionary *dicList in arrTemp) {
                YSHomeListModel *homeListModel = [YSHomeListModel homeListModelWithDictionary:dicList];
                if (!homeListModel) break;
                [weakSelf.arrMData addObject:homeListModel];
            }
            [weakSelf.tableView reloadData];
        });
    } andRequestFailure:^(NSError *error) {
        NSLog(@">>>>请求失败");
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"网络不好，请耐心等待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *alertDengLuAction = [UIAlertAction actionWithTitle:@"刷新试试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf requestInformation];
        }];
        [alertContorller addAction:alertDengLuAction];
        [alertContorller addAction:alertAction];
        [self presentViewController:alertContorller animated:YES completion:nil];
    }];
}

#pragma mark  > 发送网络请求 <
- (void)sendRequest{
    
    // 推荐
    //    NSString *strURL = @"http://14.215.177.67/mobileui/strategy/v1/mainpage?resid=1001&from=na-android&os=4.4.4&sv=4.0.0&cuid=7BB58804E580050AC1DFC61CDBFB6B6D%7C486828320138768&model=MI4LTE&screen=1080*1920&channel=com.xiaomi&loc_lat=4115513.692114&loc_lng=1.2642806444422E7&city_id=268&aoi_id=13638730612458242555&address=%E6%96%B0%E5%BC%80%E6%99%AE%E7%94%B5%E5%AD%90%E8%82%A1%E4%BB%BD%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8&net_type=wifi&isp=46002&request_time=1470223963280";
    //    NSDictionary *dicPrograme = @{@"bduss":@"lXflpOd0M5TURYNFA3T1VEcUZON1VMZmQ5b3U1RFlEM1VVU0xNVWphTXQxLVpXQVFBQUFBJCQAAAAAAAAAAAEAAACplUsdWte5wuS3srO-WgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC1Kv1YtSr9WN3",@"stoken":@"295004617b5d76a4ea392a88b73617bb9fd0817ff3f9814f9fd2f03bd89be3fd",@"lng":@"1.2642806444422E7",@"lat":@"4115513.692114"};
    //    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicPrograme andRequestSuccess:^(id responseObject) {
    //        NSDictionary *dic = responseObject;
    //        YSResultModel *resultModel = [YSResultModel resultModelWithDictionary:dic[@"result"]];
    ////        YSRecommandModel *recommandModel = resultModel.recommandModel;
    //        NSArray *arrCardList = resultModel.card_list;
    //
    //        __weak typeof(self) weakSelf = self;
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //
    //            weakSelf.arrMData = [NSMutableArray array];
    //            for (YSCardListModel *cardListModel in arrCardList) {
    //                NSString *strCard = cardListModel.card_name;
    //                if ([strCard isEqualToString:@"shoprecommand"]) {
    //                    break;
    //                }else{
    //                    [self.arrMData addObject:cardListModel];
    //                }
    //            }
    ////            NSLog(@"%ld",weakSelf.arrMData.count);
    //            YSCardListModel *cardListModel = weakSelf.arrMData[weakSelf.numCurrent];
    //            weakSelf.arrFoodModels = cardListModel.card_data.dish_list;
    //            [weakSelf.tableView reloadData];
    //        });
    //    } andRequestFailure:^(NSError *error) {
    //        NSLog(@">>>>失败%@",error);
    //    }];
}


#pragma mark 加载导航栏设置
- (void)loadNavigationSetting{
    UIBarButtonItem *itemProfile = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_user"] style:UIBarButtonItemStylePlain target:self action:@selector(clickTheUserAction)];
    self.navigationItem.rightBarButtonItem = itemProfile;
}

- (void)clickTheUserAction{
    //    YSLoginViewController *loginVC = [YSLoginViewController new];
    //    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    //    self.view.backgroundColor = YSColorRandom;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 130;
    tableView.contentInset = UIEdgeInsetsMake(YSNavigationBarHeight, 0, self.numItemHeight, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //     __weak typeof(self) weakSelf = self;
    //    [self.tableView addGifRefreshHeaderWithClosure:^{
    //        [weakSelf loadNewData];
    //    }];
    //    [self.tableView addGifRefreshFooterWithClosure:^{
    //        [weakSelf loadNewData];
    //    }];
    //    NSLog(@"%lu",self.arrMData.count);
}

//- (void)loadNewData{
//    self.numCurrent += 1;
//    if (self.numCurrent >= self.arrMData.count) {
//        self.numCurrent = 0;
//    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        YSCardListModel *cardListModel = self.arrMData[self.numCurrent];
//        self.arrFoodModels = cardListModel.card_data.dish_list;
//        [self.tableView endRefreshing];
//        [self.tableView reloadData];
//    });
//}


#pragma mark  > UITableViewDataSource  <
/** 设置组数*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/** 设置行数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrMData.count;
}

/** 设置每组的cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSHomeViewCell *homeListCell = [YSHomeViewCell homeCellWithTableView:tableView];
    YSHomeListModel *homeListModel = self.arrMData[indexPath.row];
    homeListCell.homeListModel = homeListModel;
    //    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //     __weak typeof(self) weakSelf = self;
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        NSString *strURL = homeListModel.pic;
    //        NSURL *picURL = [NSURL URLWithString:strURL];
    //        [cell.imageView sd_setImageWithURL:picURL];
    //        [weakSelf.tableView reloadData];
    //    });
    //    cell.textLabel.text = [NSString stringWithFormat:@"%@",homeListModel.title];
    return homeListCell;
}

#pragma mark  > UITableViewDelegate  <
/** 选中的row进行的操作*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YSHomeInfoViewController *homeInfoVC = [YSHomeInfoViewController new];
    YSHomeListModel *homeListModel = self.arrMData[indexPath.row];
    homeInfoVC.strMenuId = homeListModel.strID;
    [self.navigationController pushViewController:homeInfoVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
