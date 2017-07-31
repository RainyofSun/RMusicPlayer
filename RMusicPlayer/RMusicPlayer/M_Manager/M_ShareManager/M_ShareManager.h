//
//  M_ShareManager.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsMacros.h"

/**
 * 分享 相关服务
 */
@interface M_ShareManager : NSObject

//单利
SINGLETON_FOR_HEADER(M_ShareManager);

/**
 * 展示分享页面
 */
-(void)showShareView;

@end
