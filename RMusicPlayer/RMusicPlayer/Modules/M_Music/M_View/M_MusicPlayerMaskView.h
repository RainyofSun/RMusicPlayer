//
//  M_MusicPlayerMaskView.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol M_MusicPlayerMaskViewDelegate <NSObject>

/**
 * 开始播放
 */
-(void)startPlaySong:(id)sender;

@end

/**
 * 音乐播放器控制层
 */
@interface M_MusicPlayerMaskView : UIView

/** delegate */
@property (nonatomic,weak) id<M_MusicPlayerMaskViewDelegate> delegate;
/** 波形区域 */
@property (nonatomic,strong) UIView *waveLineView;

/**
 * 创建播放器蒙层
 */
+(instancetype)setupPlayerMaskView:(UIView*)view delegate:(id<M_MusicPlayerMaskViewDelegate>)delegate;

@end
