//
//  YSRecommendInformationViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSRecommendInformationViewController.h"

#import "YSInfoTableHeaderView.h"
#import "YSRecommandInfoStuffCell.h"
#import "YSInfoSepsCell.h"


#import "YSResultInfoModel.h"

@interface YSRecommendInformationViewController () <UITableViewDelegate,UITableViewDataSource>

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

@implementation YSRecommendInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}


#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.title = self.strTitle;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 50;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, self.numItemHeight, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
//    YSInfoTableHeaderView *headerView = [YSInfoTableHeaderView new];
    UIImageView *imvHeader = [UIImageView new];
    imvHeader.bounds = CGRectMake(0, 0, 0, 250);
    
    tableView.tableHeaderView = imvHeader;
    self.imvHeader = imvHeader;
}

- (void)viewWillAppear:(BOOL)animated{
    [self requestInformation];
}

- (void)requestInformation{
    NSString *strURL = @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1470618310965&vc=101&vn=6.1.4&loguid=0&deviceid=haodou867831023828684&uuid=c576aad9383186b5652abee64784b12d&channel=xiaomi_v614&method=Info.getInfo&virtual=&signmethod=md5&v=3&timestamp=1470618511&nonce=0.6625423477147042&appsign=296ec6806458edc7a2e86342df544a3a";
    NSDictionary *dicProgramma = @{@"sign":@"",@"return_request_id":@"",@"uuid":@"c576aad9383186b5652abee64784b12d",@"rid":[NSString stringWithFormat:@"%@",self.strRecipeId]};
    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicProgramma andRequestSuccess:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSDictionary *dicTemp = dic[@"result"];
        YSResultInfoModel *resultInfoModel = [YSResultInfoModel resultInfoWithDictionary:dicTemp[@"info"]];
        //            NSLog(@">>>>%@",resultInfoModel);
        
        NSURL *headerImvURL = [NSURL URLWithString:resultInfoModel.Cover];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.imvHeader sd_setImageWithURL:headerImvURL];
            
            weakSelf.strTitle = resultInfoModel.Title;
            weakSelf.strIntro = resultInfoModel.Intro;
            weakSelf.strCookTime = resultInfoModel.CookTime;
            weakSelf.strTips = resultInfoModel.Tips;
            
            weakSelf.arrStuff = resultInfoModel.Stuff;
            weakSelf.arrSteps = resultInfoModel.Steps;
            [weakSelf.tableView reloadData];
        });
        
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
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
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
//    NSURL *imvURL = [NSURL URLWithString:stepsModel.StepPhoto];
//    [cell.imageView sd_setImageWithURL:imvURL];
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
