//
//  AppDelegate+AppService.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/24.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "AppDelegate.h"
/**
 * 包含第三方 和应用内业务的实现。减轻入口处的代码压力
 */
@interface AppDelegate (AppService)

/**
 * 初始化服务
 */
-(void)initService;

/**
 * 初始化window窗口
 */
-(void)initWindow;

/**
 * 初始化友盟
 */
-(void)initUMeng;

/**
 * 初始化用户系统
 */
-(void)initUserManager;

/**
 * 监听网络状态
 */
-(void)monitorNetWorkStatus;

/**
 * 单利
 */
+(AppDelegate*)shareAppDelegate;

/**
 * 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;
-(UIViewController*) getCurrentUIVC;


@end
