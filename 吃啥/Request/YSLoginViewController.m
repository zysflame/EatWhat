//
//  YSLoginViewController.m
//  吃啥
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSLoginViewController.h"



@interface YSLoginViewController () <UIWebViewDelegate>

/** 网页View*/
@property (nonatomic,strong) UIWebView *webViewBack;

@end

@implementation YSLoginViewController

#pragma mark  > VebViewBack 的懒加载<
- (UIWebView *)webViewBack{
    if (!_webViewBack) {
        _webViewBack = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webViewBack.delegate = self;  // 设置代理
        _webViewBack.scalesPageToFit = YES; //  设置webView的页面尺寸填充
    }
    return _webViewBack;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    [self.view addSubview:self.webViewBack];
    [self sendRequest];
}
#pragma mark  > 1.发送请求 请求用户授权Token <


- (void)sendRequest{
    
    NSString *strURL = @"http://14.215.177.67/shopui/na/v1/startup?resid=1001&from=na-android&os=4.4.4&sv=4.0.0&cuid=7BB58804E580050AC1DFC61CDBFB6B6D%7C486828320138768&model=MI4LTE&screen=1080*1920&channel=com.xiaomi&loc_lat=4115513.692114&loc_lng=1.2642806444422E7&city_id=268&aoi_id=13638730612458242555&address=%E6%96%B0%E5%BC%80%E6%99%AE%E7%94%B5%E5%AD%90%E8%82%A1%E4%BB%BD%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8&net_type=wifi&isp=46002&request_time=1470222792460";
    NSDictionary *dicParam = @{@"lng":@"1.2642798799506E7",@"lat":@"4115498.142899",@"bduss":@"lXflpOd0M5TURYNFA3T1VEcUZON1VMZmQ5b3U1RFlEM1VVU0xNVWphTXQxLVpXQVFBQUFBJCQAAAAAAAAAAAEAAACplUsdWte5wuS3srO-WgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC1Kv1YtSr9WN3",@"stoken":@"295004617b5d76a4ea392a88b73617bb9fd0817ff3f9814f9fd2f03bd89be3fd",@"return_type":@"all"};
    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicParam andRequestSuccess:^(NSDictionary *dict) {
        NSLog(@">>>%@",dict);
    } andRequestFailure:^(NSError *error) {
        NSLog(@">>>>失败%@",error);
    }];
    
//    // 推荐
//    NSString *strURL = @"http://14.215.177.67/mobileui/strategy/v1/mainpage?resid=1001&from=na-android&os=4.4.4&sv=4.0.0&cuid=7BB58804E580050AC1DFC61CDBFB6B6D%7C486828320138768&model=MI4LTE&screen=1080*1920&channel=com.xiaomi&loc_lat=4115513.692114&loc_lng=1.2642806444422E7&city_id=268&aoi_id=13638730612458242555&address=%E6%96%B0%E5%BC%80%E6%99%AE%E7%94%B5%E5%AD%90%E8%82%A1%E4%BB%BD%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8&net_type=wifi&isp=46002&request_time=1470223963280";
//    NSDictionary *dicPrograme = @{@"bduss":@"lXflpOd0M5TURYNFA3T1VEcUZON1VMZmQ5b3U1RFlEM1VVU0xNVWphTXQxLVpXQVFBQUFBJCQAAAAAAAAAAAEAAACplUsdWte5wuS3srO-WgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC1Kv1YtSr9WN3",@"stoken":@"295004617b5d76a4ea392a88b73617bb9fd0817ff3f9814f9fd2f03bd89be3fd",@"lng":@"1.2642806444422E7",@"lat":@"4115513.692114"};
//    [[YSHTTPRequest sharedHTTPRequest] POSTWithURL:strURL withParam:dicPrograme andRequestSuccess:^(NSDictionary *dict) {
//        
//    } andRequestFailure:^(NSError *error) {
//        NSLog(@">>>>失败%@",error);
//    }];
//    
}

//#pragma mark  > 2.监听请求 -UIWebViewDelegate 内的方法 <
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSString *strURL = [request.URL absoluteString];
//   
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
