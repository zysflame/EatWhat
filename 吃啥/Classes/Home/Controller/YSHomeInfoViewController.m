//
//  YSHomeInfoViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSHomeInfoViewController.h"

#import "YSMenuDataModel.h"

@interface YSHomeInfoViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

/**  存放材料的数组*/
@property (nonatomic,copy) NSArray *arrMaterail;
/**  存放操作步骤的数组 */
@property (nonatomic,copy) NSArray *arrSteps;

/** intro 介绍*/
@property (nonatomic,copy) NSString *strMenuState;
/** cover 图片*/
//@property (nonatomic,copy) NSString *strMenuPic;
/** title 食物名字*/
@property (nonatomic,copy) NSString *strMenuName;

@property (nonatomic,weak) UIImageView *imvHeader;

@end

@implementation YSHomeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}


#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 60;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, -30, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //    YSInfoTableHeaderView *headerView = [YSInfoTableHeaderView new];
    UIImageView *imvHeader = [UIImageView new];
    imvHeader.bounds = CGRectMake(0, 0, 0, 250);
    
    tableView.tableHeaderView = imvHeader;
    self.imvHeader = imvHeader;
}

- (void)viewWillAppear:(BOOL)animated{
    //    [self sendRequest];
    [self requestInformation];
}

#pragma mark  > 发送网络请求 <
- (void)requestInformation{
    //    http://115.231.110.203/appapi/getMenuDetails.asp
    //    appName=%E5%91%B3%E4%BB%96&keyCode=4F8F092F7F6D0DB304341DE43AE9F92E&&
    NSString *strURL = @"http://115.231.110.203/appapi/getMenuDetails.asp";
    NSString *strID = self.strMenuId;
    NSDictionary *dicPrograme = @{@"appName":@"味他",@"keyCode":@"4F8F092F7F6D0DB304341DE43AE9F92E",@"timeStamp":@"1470713633495",@"menuId":strID,@"insideCode":@"10013",@"appType":@"1",@"ipAddress":@"115.231.110.203",@"version":@"2.1.1"};
//    NSLog(@"ID>>>>%@",strID);
    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicPrograme andRequestSuccess:^(id responseObject) {
//        NSLog(@"请求成功>>>>%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        YSMenuDataModel *menuDataModel = [YSMenuDataModel menuDataModelWithDictionary:dic[@"data"]];
        NSURL *headerImvURL = [NSURL URLWithString:menuDataModel.menuPic];
        //注:在block块中实现ui的操作,都要在主线程中操作
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.imvHeader sd_setImageWithURL:headerImvURL];
            weakSelf.title = menuDataModel.menuName;
            weakSelf.strMenuState = menuDataModel.menuState;
            
            weakSelf.arrMaterail = menuDataModel.menuMaterial;
            weakSelf.arrSteps = menuDataModel.menuStep;
            [weakSelf.tableView reloadData];
        });
    } andRequestFailure:^(NSError *error) {
        NSLog(@">>>>失败%@",error);
        // 提示框控制器
        
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
        num = self.arrMaterail.count;
    }
    if(section == 1){
        num = self.arrSteps.count;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *strID = @"MaterialCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:strID];
        }
        YSMenuMaterialModel *materialModel = self.arrMaterail[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.text = [NSString stringWithFormat:@"%@",materialModel.materialName];
        cell.detailTextLabel.text = materialModel.materialWeight;
        return cell;
        
    }

    static NSString *strID = @"SepsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    YSMenuStepModel *stepModel = self.arrSteps[indexPath.row];
//    NSURL *imvURL = [NSURL URLWithString:stepModel.stepPic];
//    [cell.imageView sd_setImageWithURL:imvURL];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row + 1,stepModel.stepState];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"食材";
    }else{
        return @"步骤";
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return self.strCookTime;
//    }else{
//        return self.strTips;
//    }
//}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
