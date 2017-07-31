//
//  M_AppManager.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 包含应用层的相关服务
 */

@interface M_AppManager : NSObject

#pragma mark - App启动接口
+(void)appStart;

#pragma mark - FPS 监测
+(void)showFPS;


@end
