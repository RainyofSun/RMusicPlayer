//
//  R_MianTabbarController.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/21.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "R_TabBar.h"

/**
 * 底部 TabBar 控制器
 */
@interface R_MianTabbarController : UITabBarController

/** TabBar */
@property (nonatomic,strong) R_TabBar *TabBar;

/** tabbar 图片占比 默认0.7f 如果是1 就没有文字*/
@property (nonatomic,assign) CGFloat itemImageRatio;

/**
 *  System will display the original controls so you should call this line when you change any tabBar item, like: `- popToRootViewController`, `someViewController.tabBarItem.title = xx`, etc.
 *  Remove origin controls
 */
-(void)removeOriginControls;

@end
