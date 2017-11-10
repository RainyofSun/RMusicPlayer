//
//  M_MusicVC.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_MusicVC.h"
#import "M_MusicPlayerMaskView.h"
#import "M_PlayerManager.h"

@interface M_MusicVC ()<M_MusicPlayerMaskViewDelegate>

/** 播放器控制层 */
@property (nonatomic,strong) M_MusicPlayerMaskView *controlView;

@end

@implementation M_MusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self controlView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:1 animations:^{
        [UIView animateWithDuration:2 animations:^{
            self.controlView.mj_y = 0;
        }];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.25 animations:^{
            self.controlView.hidden = NO;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1 animations:^{
                    self.controlView.mj_y = KScreenHeight/3 + 50;
                } completion:^(BOOL finished) {
                    self.controlView.hidden = YES;
                }];
            });
        }];
    }];
}

#pragma M_MusicPlayerMaskViewDelegate
-(void)startPlaySong:(id)sender{
    [[M_PlayerManager sharedM_PlayerManager] startPlayWithUrl:@"" potView:self.controlView.waveLineView];
}

-(M_MusicPlayerMaskView *)controlView{
    if (!_controlView) {
        _controlView = [M_MusicPlayerMaskView setupPlayerMaskView:self.view delegate:self];
        _controlView.hidden = YES;
    }
    return _controlView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
