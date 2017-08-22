//
//  M_LoginAVManager.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/1.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_LoginAVManager.h"
#import <AVFoundation/AVFoundation.h>

static M_LoginAVManager* manager = nil;

@interface M_LoginAVManager ()

/** 播放器 */
@property (nonatomic,strong) AVPlayer *loginPlayer;
/** 播放图层 */
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
/** 加载播放器的view */
@property (nonatomic,strong) UIView *playerView;

@end

@implementation M_LoginAVManager

+(instancetype)loginManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[M_LoginAVManager alloc] init];
    });
    return manager;
}

-(void)loginGiudeRes:(NSString *)url superView:(UIView *)view{
    manager.playerView = view;
    //创建一个播放的item
    AVPlayerItem* playItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:url]];
    //播放的设置
    self.loginPlayer = [AVPlayer playerWithPlayerItem:playItem];
    self.loginPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;//永不暂停
    //将播放器嵌入到播放层
    manager.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.loginPlayer];
    manager.playerLayer.frame = view.bounds;
    [view.layer insertSublayer:manager.playerLayer atIndex:0];
    //循环播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self.loginPlayer play];
}

-(void)playToEnd{
    [self.loginPlayer seekToTime:kCMTimeZero];
}

-(void)destroyAVPlayer{
    [manager.playerLayer removeFromSuperlayer];
    manager.playerLayer = nil;
    manager.loginPlayer = nil;
}

@end
