//
//  R_RootWebViewController.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_RootWebViewController.h"
#import <WebKit/WebKit.h>

@interface R_RootWebViewController ()<WKNavigationDelegate,WKUIDelegate>
{
    WKUserContentController* userContentController;
}

/**<#object#>*/
@property (nonatomic,strong) WKWebView *wkWebView;
/** 加载页面的进度条 */
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation R_RootWebViewController

-(instancetype)initWithUrl:(NSString *)url{
    if (self = [super init]) {
        self.url = url;
        _progressViewColor = [UIColor colorWithRed:119.0/255.0 green:228.0/255.0 blue:115.0/255.0 alpha:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWKWebView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initProgressView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
}

#pragma mark - 初始化wkwebView
-(void)initWKWebView{
    //实例化配置类
    WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
    //注册供JS调用的方法
    userContentController = [[WKUserContentController alloc] init];
//    //弹出登录
//    [userContentController addScriptMessageHandler:self name:@"loginVC"];
//    //加载首页
//    [userContentController addScriptMessageHandler:self name:@"gotoFirstVC"];
//    //进入详情页
//    [userContentController addScriptMessageHandler:self name:@"gotoDetailVC"];
    configuration.userContentController = userContentController;
    //打开js交互
    configuration.preferences.javaScriptEnabled = YES;
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) configuration:configuration];
    [self.view addSubview:_wkWebView];
    
    _wkWebView.backgroundColor = [UIColor clearColor];
    //打开网页间的滑动返回
    _wkWebView.allowsBackForwardNavigationGestures = YES;
    _wkWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    if (kiOS9Later) {
        //允许预览链接
        _wkWebView.allowsLinkPreview = YES;
    }
    
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    //注册监听拿到加载进度
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_wkWebView loadRequest:request];
}

#pragma mark - 设置加载进度
-(void)initProgressView{
    CGFloat progressBarHeight = 3.0f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height, navigationBarBounds.size.width, progressBarHeight);
    
    if (!_progressView || _progressView.superview) {
        _progressView = [[UIProgressView alloc] initWithFrame:barFrame];
        _progressView.tintColor = [UIColor colorWithHexString:@"0485d1"];
        _progressView.trackTintColor = [UIColor clearColor];
        [self.navigationController.navigationBar addSubview:self.progressView];
    }
}

#pragma mark - 检测进度条完成之后就将进度条隐藏
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }
}

#pragma mark - WKNavigationDelegate
//页面加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

//页面加载完毕之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.title = webView.title;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItem];
}

//页面加载失败时的调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

#pragma mark - update nav item
-(void)updateNavigationItem{
    if (self.wkWebView.canGoBack) {
        UIBarButtonItem* spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        [self R_AddNavigationItemWithTitles:@[@"返回",@"关闭"] isLeft:YES target:self action:@selector(leftBtnClick:) tags:@[@2000,@2001]];
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
        /*
         iOS8.0系统下发现的问题：在导航栏侧滑过程中，执行添加导航栏按钮操作，会出现按钮重复，导致导航栏一系列错乱问题。
         解决方案：每个vc显示时，遍历self.navigationController.navigationbar.subviews 根据tag值进行去重。
         现在先把iOS 9.0 以下的不适用动态添加按钮 --->参照微信的处理方法
         */
        if (kiOS9Later) {
            [self R_AddNavigationItemWithTitles:@[@""] isLeft:YES target:self action:@selector(leftBtnClick:) tags:@[@2001]];
        }
    }
}

-(void)leftBtnClick:(UIButton*)sender{
    switch (sender.tag) {
        case 2000:
            [self.wkWebView goBack];
            break;
        case 2001:
            [self backBtnClicked];
            break;
        default:
            break;
    }
}

-(void)reloadWebView{
    [self.wkWebView reload];
}

-(void)dealloc{
    [self clean];
}

#pragma mark - 清理释放
-(void)clean{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.wkWebView.UIDelegate = nil;
    self.wkWebView.navigationDelegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
