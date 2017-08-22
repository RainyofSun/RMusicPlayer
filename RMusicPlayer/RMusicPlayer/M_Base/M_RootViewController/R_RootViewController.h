//
//  R_RootViewController.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/22.
//  Copyright © 2017年 刘冉. All rights reserved.
/**
 基类VC
 */

#import <UIKit/UIKit.h>
#import "UtilsMacros.h"
#import "CommonMacros.h"
#import <YYKit.h>

@interface R_RootViewController : UIViewController

/** 修改状态栏颜色 */
@property (nonatomic,assign) UIStatusBarStyle statusBarStyle;

/**<#object#>*/
@property (nonatomic,strong) UITableView *rootTabView;
/**<#object#>*/
@property (nonatomic,strong) UICollectionView *rootCollectionView;

/** 是否需要返回按钮 */
@property (nonatomic,assign) BOOL R_IsShowLiftBack;
/** 是否隐藏导航栏 */
@property (nonatomic,assign) BOOL R_IsHideNavBar;
/** 是否需要显示tabbar */
@property (nonatomic,assign) BOOL R_IsHideTabBar;

/**
 * 登录跳转
 */
-(void)R_GoLogin;
-(void)R_GoLoginWithPush;

/**
 * 显示没有数据页面
 */
-(void)R_ShowNoDataImage;

/**
 * 移除没有数据的页面
 */
-(void)R_RemoveNoDataImage;

/**
 * 需要登录
 */
-(void)R_ShowShouldLoginPoint;

/**
 * 加载视图
 */
-(void)R_ShowLoadingAnimation;

/**
 * 停止加载
 */
-(void)R_StopLoadingAnimation;

/**
 * 导航栏添加文本按钮
 * @param titles    文本数组
 * @param isLeft    是否是左边 非左即右
 * @param target    目标
 * @param action    点击方法
 * @param tags      tags数组  回调区分用
 */
-(void)R_AddNavigationItemWithTitles:(NSArray*)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray*) tags;

/**
 * 导航栏添加图标按钮
 * @param imageNames    图标数组
 * @param isLeft        是否是左边 非左即右
 * @param target        目标
 * @param action        动作
 * @param tags          tags 数组 回调区分用
 */
-(void)R_AddNavigationItemWithImageNames:(NSArray*)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray*)tags;

/**
 * 默认返回按钮的点击事件，默认是返回，子类可重写
 */
-(void)backBtnClicked;

/**
 * 取消网络请求
 */
-(void)cancelRequest;

@end
