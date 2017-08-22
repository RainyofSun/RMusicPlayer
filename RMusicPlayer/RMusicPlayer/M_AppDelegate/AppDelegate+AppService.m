//
//  AppDelegate+AppService.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/24.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import <UMSocialCore/UMSocialCore.h>
#import "M_LoginVc.h"

@implementation AppDelegate (AppService)

#pragma mark - 初始化服务
-(void)initService{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStatusChange:)
                                                 name:KNotificationLoginStateChange object:nil];
    
    //注册网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange object:nil];
}

#pragma mark - 初始化window
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class],nil].color = KWhiteColor;
}

#pragma mark - 初始化用户系统
-(void)initUserManager{
    DLog(@"设备IMEI:%@",[OpenUDID value]);
    if ([userManager loadUserInfo]) {
        //如果有本地数据 先展示tabBar 随后异步进行登录的操作
        self.mainTabBar = [R_MianTabbarController new];
        self.window.rootViewController = self.mainTabBar;
        
        //自动登录
        [userManager autoLoginToServer:^(BOOL sucess, NSString *des) {
            if (sucess) {
                DLog(@"自动登录成功");
                KPostNotification(KNotificationAutoLoginSuccess, nil);
            } else {
                [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败: %@",des)];
            }
        }];
    } else {
        //没有登录过。展示登录页面
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
}

#pragma mark - 登录状态处理
-(void)loginStatusChange:(NSNotification*)notification{
    BOOL loginSucess = [notification.object boolValue];
    if (loginSucess) {
        //登录成功加载主窗口
        if (self.mainTabBar || ![self.window.rootViewController isKindOfClass:[R_MianTabbarController class]]) {
            self.mainTabBar = [R_MianTabbarController new];
            
            CATransition* anima = [CATransition animation];
            //设置动画类型
            anima.type = @"cube";
            //设置动画方向
            anima.subtype = kCATransitionFromRight;
            anima.duration = 0.5f;
            
            self.window.rootViewController = self.mainTabBar;
            
            [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
        }
    } else {
        //登录失败加载登录页面控制器
        self.mainTabBar = nil;
        M_LoginVc* login = [[M_LoginVc alloc] init];
        //隐藏导航栏
        login.R_IsHideNavBar = YES;
        R_RootNavController* loginNav = [[R_RootNavController alloc] initWithRootViewController:login];
        self.window.rootViewController = loginNav;
    }
    //展示FPS
    [M_AppManager showFPS];
}

#pragma mark - 网络状态的变化
-(void)netWorkStateChange:(NSNotification*)notification{
    BOOL isNetWork = [notification.object boolValue];
    
    if (isNetWork) {
        //有网络
        if ([userManager loadUserInfo] && !isLogin) {
            //有用户数据 并且 未登录成功  重新来一次自动登录
            [userManager autoLoginToServer:^(BOOL sucess, NSString *des) {
                if (sucess) {
                    DLog(@"网络改变后重新登录成功");
                    KPostNotification(KNotificationAutoLoginSuccess, nil);
                } else {
                    [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登里失败:%@",des)];
                }
            }];
        }
    } else {
        //登录失败加载登录页面控制器
        [MBProgressHUD showTopTipMessage:@"网络状态不佳" isWindow:YES];
    }
}

#pragma mark - 友盟初始化
-(void)initUMeng{
    /**打开调试日志*/
    [[UMSocialManager defaultManager] openLog:YES];
    /**设置友盟的appKey*/
    [[UMSocialManager defaultManager]setUmSocialAppkey:UMengKey];
    [self configUSharePlatforms];
}

#pragma mark - 配置第三方
-(void)configUSharePlatforms{
    /**设置微信*/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppKey_Wechat appSecret:kSecret_Wechat redirectURL:nil];
    /**移除相应平台的分享 如微信收藏*/
//    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[UMSPlatformNameWechatFavorite]];
    /**
     设置分享到QQ互联的appId
     U-Share SDK 为了兼容大部分平台命名，统一用appkey和appSecret进行参数配置，而QQ平台仅需将appID作为U-share的appkey参数传进即可
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kAppKey_Tencent appSecret:nil redirectURL:nil];
}

#pragma markl - OpenUrl回调
//支持所有iOS系统
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        //其他如支付SDK的回调
    }
    return result;
}

#pragma mark - 网络状态监听
-(void)monitorNetWorkStatus{

}

+(AppDelegate *)shareAppDelegate{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

-(UIViewController *)getCurrentVC{
    UIViewController* result = nil;
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray* windows = [[UIApplication sharedApplication] windows];
        for (UIWindow* tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView* frontView = [[window subviews] objectAtIndex:0];
    id nextRespinser = [frontView nextResponder];
    
    if ([nextRespinser isKindOfClass:[UIViewController class]]) {
        result = nextRespinser;
    } else {
        result = window.rootViewController;
    }
    return result;
}

-(UIViewController *)getCurrentUIVC{
    UIViewController* superVC = [self getCurrentVC];
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController* tavSelectVC = ((UITabBarController*)superVC).selectedViewController;
        if ([tavSelectVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)tavSelectVC).viewControllers.lastObject;
        }
        return tavSelectVC;
    } else {
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
        return superVC;
    }
}

@end
