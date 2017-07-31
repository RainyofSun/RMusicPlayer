//
//  R_RootNavController.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_WebViewNavController.h"
#import "R_WebViewNavController.h"

/**
 * 导航控制器类
 */

@interface R_RootNavController : R_WebViewNavController

/**
 * 返回指定的类视图
 * @param ClassName     类名
 * @param animated      是否动画
 */
-(BOOL)popToAppointViewController:(NSString*)ClassName  animationed:(BOOL)animated;


@end
