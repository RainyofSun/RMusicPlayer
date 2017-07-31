//
//  AppDelegate.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/20.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "R_MianTabbarController.h"

/**
 * 这里只做调用，具体实现放在AppDelegate+AppService中 或者Manager中，防止代码过多不清晰
 */

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**<#object#>*/
@property (nonatomic,strong) R_MianTabbarController *mainTabBar;

@end

