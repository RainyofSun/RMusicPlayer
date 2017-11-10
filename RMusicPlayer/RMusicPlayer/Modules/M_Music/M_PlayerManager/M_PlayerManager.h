//
//  M_PlayerManager.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 二次封装播放器
 */
@interface M_PlayerManager : NSObject

/**
 * 单例管理播放器
 */
SINGLETON_FOR_HEADER(M_PlayerManager);

/**
 * 开始播放
 */
-(void)startPlayWithUrl:(NSString*)address potView:(UIView*)potView;

@end
