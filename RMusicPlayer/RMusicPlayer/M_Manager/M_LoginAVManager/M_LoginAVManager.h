//
//  M_LoginAVManager.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/1.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 登录动画播放管理类
 */

@interface M_LoginAVManager : NSObject

/**
 * 登录动画单例
 */
+(instancetype)loginManager;

/**
 * 传入播放动画的Url
 * @param url   NSString    本地动画
 * @param playView  UIView      动画的播放层
 */
-(void)loginGiudeRes:(NSString*)url superView:(UIView*)playView;

/**
 * 登陆成功之后销毁登陆页面播放的动画
 */
-(void)destroyAVPlayer;

@end
