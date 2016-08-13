//
//  YSMenuViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSRecommendViewController.h"
#import "YSRecommendInformationViewController.h"


//#import "YSResultModel.h"

#import "YSResultInfoListModel.h"

@interface YSRecommendViewController ()

/** 随机产生的随机数*/
@property (nonatomic ,assign) NSUInteger numArc;

/** 存放信息的数组*/
@property (nonatomic,copy) NSArray *arrDatas;
/** 保存随机后产生的模型*/
@property (nonatomic,strong) YSResultInfoListModel *infoListModel;
/** 设置定时器*/
@property (nonatomic,strong) NSTimer *timer;

/** 存放背景图的数组*/
@property (nonatomic,copy) NSArray *arrImageViews;
/** 图片*/
@property (nonatomic,weak) UIImageView *imageViewBack;
/** 食物名字*/
@property (nonatomic,weak) UILabel *lblTitle;

@end

@implementation YSRecommendViewController

- (NSArray *)arrImageViews{
    if (!_arrImageViews) {
        NSUInteger count = self.arrDatas.count;
        NSMutableArray *arrMImages = [NSMutableArray arrayWithCapacity:count];
        for (NSUInteger index = 0; index < count; index ++) {
            YSResultInfoListModel *infoListModel = self.arrDatas[index];
            NSString *strURL = infoListModel.Cover;
            NSURL *imageURL = [NSURL URLWithString:strURL];
            NSData *dataImage = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:dataImage scale:1];
            [arrMImages addObject:image];
        }
        _arrImageViews = [arrMImages copy];
    }
    return _arrImageViews;
}

//- (NSArray *)arrImageViews{
//    if (!_arrImageViews) {
//        NSUInteger count = self.arrDatas.count;
//        NSMutableArray *arrMImages = [NSMutableArray arrayWithCapacity:count];
//        for (NSUInteger index = 0; index < count; index ++) {
//            YSFoodModel *foodModel = self.arrDatas[index];
//            NSString *strModelURL = foodModel.url;
//            NSRange range = [strModelURL rangeOfString:@"@s_2"];
//            if (range.location != NSNotFound) {
//                NSString *strTemp = [strModelURL substringToIndex:range.location];
//                NSString *strURL = strTemp;
//                NSURL *urlName = [NSURL URLWithString:strURL];
//                NSData *dataImage = [NSData dataWithContentsOfURL:urlName];
//                UIImage *image = [UIImage imageWithData:dataImage scale:1.0];
//                [arrMImages addObject:image];
//            }
//        }
//        _arrImageViews = [arrMImages copy];
//    }
//    return _arrImageViews;
//}

- (void)viewWillAppear:(BOOL)animated{
    [self sendRequest];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark  > 发送网络请求 <
- (void)sendRequest{
    
    // 好豆菜单的数据请求
    NSString *strURL = @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1470618310965&vc=101&vn=6.1.4&loguid=0&deviceid=haodou867831023828684&uuid=c576aad9383186b5652abee64784b12d&channel=xiaomi_v614&method=Recipe.getCollectRecomment&virtual=&signmethod=md5&v=3&timestamp=1470704186&nonce=0.8400518335401737&appsign=123ed558a4f5dd17fc34b81b173c4053";
    NSDictionary *dicPrograme = @{@"limit":@"10",@"sign":@"",@"uid":@"0",@"uuid":@"c576aad9383186b5652abee64784b12d",@"offset":@"0",@"appqs":@"haodourecipe%3A%2F%2Fhaodou.com%2Frecommend%2Frecipe%2F%3Fkeyword%3D%25E7%2583%25AD%25E9%2597%25A8%25E8%258F%259C%25E8%25B0%25B1%26title%3D%25E7%2583%25AD%25E9%2597%25A8%25E8%258F%259C%25E8%25B0%25B1%26tab%3D%25E5%2585%25A8%25E9%2583%25A8%253A%25E7%2583%25AD%25E9%2597%25A8%25E8%258F%259C%25E8%25B0%25B1%257C%25E7%25A7%2581%25E4%25BA%25BA%253A%25E7%25A7%2581%25E4%25BA%25BA%25E5%25AE%259A%25E5%2588%25B6%257C%25E6%2597%25B6%25E4%25BB%25A4%253A%25E6%2597%25B6%25E4%25BB%25A4%25E4%25BD%25B3%25E8%2582%25B4%257C%25E8%25BE%25BE%25E4%25BA%25BA%253A%25E8%25BE%25BE%25E4%25BA%25BA%25E8%258F%259C%25E8%25B0%25B1%257C%25E6%259C%2580%25E6%2596%25B0%253A%25E6%259C%2580%25E6%2596%25B0%25E8%258F%259C%25E8%25B0%25B1%257C%25E7%2583%2598%25E7%2584%2599%253A%25E5%25BF%25AB%25E4%25B9%2590%25E7%259A%2584%25E7%2583%2598%25E7%2584%2599",@"type":@"热门菜谱"};
    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicPrograme andRequestSuccess:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        //        NSLog(@">>>%@",dic);
        NSDictionary *dicResult = dic[@"result"];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *arrTemp = dicResult[@"list"];
            weakSelf.infoListModel = [YSResultInfoListModel infoListModelWithDictionary:arrTemp[0]];
            
            YSResultInfoListModel *infoListModelFirst = [YSResultInfoListModel infoListModelWithDictionary:arrTemp[0]];
            NSURL *imageURL = [NSURL URLWithString:infoListModelFirst.Cover];
            [weakSelf.imageViewBack sd_setImageWithURL:imageURL];
            weakSelf.lblTitle.text = infoListModelFirst.Title;
            NSMutableArray *arrMInfoLidtModels = [NSMutableArray arrayWithCapacity:arrTemp.count];
            for (NSDictionary *dicModel in arrTemp) {
                YSResultInfoListModel *infoListModel = [YSResultInfoListModel infoListModelWithDictionary:dicModel];
                if (!infoListModel) break;
                [arrMInfoLidtModels addObject:infoListModel];
            }
            weakSelf.arrDatas = [arrMInfoLidtModels copy];
        });
        
    } andRequestFailure:^(NSError *error) {
        NSLog(@"请求失败");
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"网络不好，请耐心等待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *alertDengLuAction = [UIAlertAction actionWithTitle:@"刷新试试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf sendRequest];
        }];
        [alertContorller addAction:alertDengLuAction];
        [alertContorller addAction:alertAction];
        [self presentViewController:alertContorller animated:YES completion:nil];
    }];
    
    // 推荐的数据请求
    //NSString *strURL = @"http://14.215.177.67/mobileui/strategy/v1/mainpage?resid=1001&from=na-android&os=4.4.4&sv=4.0.0&cuid=7BB58804E580050AC1DFC61CDBFB6B6D%7C486828320138768&model=MI4LTE&screen=1080*1920&channel=com.xiaomi&loc_lat=4115513.692114&loc_lng=1.2642806444422E7&city_id=268&aoi_id=13638730612458242555&address=%E6%96%B0%E5%BC%80%E6%99%AE%E7%94%B5%E5%AD%90%E8%82%A1%E4%BB%BD%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8&net_type=wifi&isp=46002&request_time=1470223963280";
    //    NSDictionary *dicPrograme = @{@"bduss":@"lXflpOd0M5TURYNFA3T1VEcUZON1VMZmQ5b3U1RFlEM1VVU0xNVWphTXQxLVpXQVFBQUFBJCQAAAAAAAAAAAEAAACplUsdWte5wuS3srO-WgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC1Kv1YtSr9WN3",@"stoken":@"295004617b5d76a4ea392a88b73617bb9fd0817ff3f9814f9fd2f03bd89be3fd",@"lng":@"1.2642806444422E7",@"lat":@"4115513.692114"};
    //    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicPrograme andRequestSuccess:^(id responseObject) {
    //        NSDictionary *dic = responseObject;
    //        YSResultModel *resultModel = [YSResultModel resultModelWithDictionary:dic[@"result"]];
    //        YSRecommandModel *recommandModel = resultModel.recommandModel;
    //
    //        //注:在block块中实现ui的操作,都要在主线程中操作
    //        __weak typeof(self) weakSelf = self;
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            NSArray *arrTemp = [NSArray new];
    //            arrTemp = recommandModel.dish_list;
    //            NSMutableArray *arrMFoodModels = [NSMutableArray arrayWithCapacity:arrTemp.count];
    //            for (NSDictionary *dic in arrTemp) {
    //                YSFoodModel *foodModel = [YSFoodModel foodModelWiyhDictionary:dic];
    //                if (!foodModel) break;
    //                [arrMFoodModels addObject:foodModel];
    //            }
    //            weakSelf.arrDatas = [arrMFoodModels copy];
    //        });
    //    } andRequestFailure:^(NSError *error) {
    //        NSLog(@">>>>失败%@",error);
    //    }];
    
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    UIImageView *imvBack = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imvBack.image =[UIImage imageNamed:@"beiJngIMage_5"];
    [self.view addSubview:imvBack];
    
    UIImageView *imageViewBack = [UIImageView new];
    [self.view addSubview:imageViewBack];
    imageViewBack.image = [UIImage imageNamed:@"image_please1"];
    self.imageViewBack = imageViewBack;
    
    //    imageViewBack.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *clickTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheImageViewBack:)];
    //    clickTap.numberOfTapsRequired = 1;
    //    [imageViewBack addGestureRecognizer:clickTap];
    
    [imageViewBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(80);
        make.trailing.mas_equalTo(-80);
        make.top.mas_equalTo(75);
        make.bottom.mas_equalTo(- 200);
    }];
    
    UILabel *lblTitle = [UILabel new];
    lblTitle.numberOfLines = 0;
    [self.view addSubview:lblTitle];
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(imageViewBack);
        make.top.equalTo(imageViewBack.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    lblTitle.textColor = [UIColor blackColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle = lblTitle;
    /** 产生随机事件的按钮*/
    UIButton *btnShake = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnShake];
    [btnShake mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lblTitle);
        make.top.equalTo(lblTitle.mas_bottom).offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(45);
    }];
    
    [btnShake setTitle:@"点一下" forState:UIControlStateNormal];
    [btnShake setTitle:@"就它了" forState:UIControlStateSelected];
    [btnShake setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnShake.backgroundColor = [UIColor orangeColor];
    [btnShake addTarget:self action:@selector(clickTheShakeBtn:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark 图片动画
- (void)imageViewAnimate{
    self.lblTitle.hidden = YES;
    self.imageViewBack.animationImages = self.arrImageViews;
    self.imageViewBack.animationDuration = self.arrImageViews.count * 0.2;
    self.imageViewBack.animationRepeatCount = INFINITY;
    [self.imageViewBack startAnimating];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.获取手势
    UITouch *touch=[touches anyObject];
    //2.获取当前光标所在点
    CGPoint point=[touch locationInView:self.view];
    //判断当前点是否在imageView区域内
    if (CGRectContainsPoint(self.imageViewBack.frame, point)) {
        YSRecommendInformationViewController *inforVC = [YSRecommendInformationViewController new];
        inforVC.numItemHeight = self.numItemHeight;
        inforVC.strRecipeId = self.infoListModel.RecipeId;
        [self.navigationController pushViewController:inforVC animated:YES];
    }
}

//#pragma mark  > 点击图片的手势触发的方法 <
//- (void)clickTheImageViewBack:(UIGestureRecognizer *)tap{
//    YSRecommendInformationViewController *inforVC = [[YSRecommendInformationViewController alloc] init];
//    [self.navigationController pushViewController:inforVC animated:YES];
//}

#pragma mark 点击按钮后触发的事件
- (void)clickTheShakeBtn:(UIButton *) button{
    
    button.selected = !button.isSelected;
    if (button.selected) {
        [self imageViewAnimate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(stopImageView:) userInfo:button repeats:NO];
    }else{
        [self.imageViewBack stopAnimating];
        [self.timer invalidate];
    }
    int count = (int)self.arrDatas.count;
    self.numArc = arc4random_uniform(count);
    [self loadInformation];
}

#pragma  amrk 计时器停止触发的事件
- (void)stopImageView:(NSTimer *)time{
    NSLog(@">>>>%@",time.userInfo);
    UIButton *btnTemp = time.userInfo;
    btnTemp.selected = NO;
    [time invalidate];
    [self.imageViewBack stopAnimating];
    [self loadInformation];
}

#pragma mark  > 加载图片与标题信息 <
- (void)loadInformation{
    if (!self.timer.valid) {
        self.lblTitle.hidden = NO;
        self.infoListModel = self.arrDatas[self.numArc];
        UIImage *image = self.arrImageViews[self.numArc];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.imageViewBack.image = image;
            weakSelf.lblTitle.text = weakSelf.infoListModel.Title;
        });
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
