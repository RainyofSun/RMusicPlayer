//
//  M_PlayerManager.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_PlayerManager.h"

@interface M_PlayerManager ()<EZAudioPlayerDelegate,EZAudioFileDelegate>

/** 播放器 */
@property (nonatomic,strong) EZAudioPlayer *musicPlayer;
/** 音乐文件 */
@property (nonatomic,strong) EZAudioFile *audioFile;
/** 波形展示的view */
@property(nonatomic,strong)EZPlot* pot;

@end

static M_PlayerManager* manager = nil;

@implementation M_PlayerManager

+(M_PlayerManager *)sharedM_PlayerManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[M_PlayerManager alloc] init];
        manager.musicPlayer = [EZAudioPlayer audioPlayerWithDelegate:manager];
        manager.audioFile.delegate = manager;
    });
    return manager;
}

-(void)startPlayWithUrl:(NSString *)address potView:(UIView *)potView{
    self.pot = [[EZAudioPlot alloc] initWithFrame:potView.bounds];
    self.pot.backgroundColor = [UIColor orangeColor];//背景颜色
    self.pot.color = [UIColor yellowColor];//波浪线颜色
    self.pot.plotType = EZPlotTypeBuffer;
    self.pot.shouldFill = YES;
    self.pot.shouldMirror = YES;
    [potView addSubview:self.pot];
    
    NSURL* musicUrl = [[NSBundle mainBundle] URLForResource:@"love.mp3" withExtension:Nil];
    self.audioFile = [EZAudioFile audioFileWithURL:musicUrl];
    [self.musicPlayer playAudioFile:self.audioFile];
    self.musicPlayer.shouldLoop = YES;
}

#pragma mark - EZAudioFileDelegate
-(void)microphone:(EZMicrophone*)microphone hasAudioReceived:(float **)buffer withBufferSize:(UInt32)bufferSize withNumberOfChannels:(UInt32)numberOfChannels{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.pot updateBuffer:buffer[0] withBufferSize:bufferSize];
    });
}

#pragma mark - EZAudioPlayerDelegate
-(void)audioPlayer:(EZAudioPlayer *)audioPlayer updatedPosition:(SInt64)framePosition inAudioFile:(EZAudioFile *)audioFile{
    
}

-(void)audioPlayer:(EZAudioPlayer *)audioPlayer playedAudio:(float **)buffer withBufferSize:(UInt32)bufferSize withNumberOfChannels:(UInt32)numberOfChannels inAudioFile:(EZAudioFile *)audioFile{
    
}

-(void)audioPlayer:(EZAudioPlayer *)audioPlayer reachedEndOfAudioFile:(EZAudioFile *)audioFile{
    
}
@end
