//
//  M_ShowMusicView.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol M_ShowMusicViewDelegate <NSObject>

/**
 * 音乐图片的点击
 */
-(void)touchMusic:(id)sender;
/**
 * 播放音乐
 */
-(void)startPlayMusic:(id)sender;
/**
 * 展示本地音乐的播放列表
 */
-(void)showLocalMusicList:(id)sender;

@end
/**
 * 点击弹起音乐界面
 */
@interface M_ShowMusicView : UIView

/** delegate */
@property (nonatomic,weak) id<M_ShowMusicViewDelegate> delegate;

/**
 * 底部音乐播放界面
 */
+(instancetype)showMusicView:(UIView*)view delegate:(id<M_ShowMusicViewDelegate>)delegate;


@end
