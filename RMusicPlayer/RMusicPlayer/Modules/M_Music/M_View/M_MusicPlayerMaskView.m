//
//  M_MusicPlayerMaskView.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_MusicPlayerMaskView.h"

@interface M_MusicPlayerMaskView ()


/** play */
@property (nonatomic,strong) UIButton *playSongBtn;
/** lastSong */
@property (nonatomic,strong) UIButton *playLastSong;
/** nextSong */
@property (nonatomic,strong) UIButton *playNextSong;

@end

@implementation M_MusicPlayerMaskView

+(instancetype)setupPlayerMaskView:(UIView *)view delegate:(id<M_MusicPlayerMaskViewDelegate>)delegate{
    M_MusicPlayerMaskView* maskView = [[M_MusicPlayerMaskView alloc] initWithFrame:CGRectMake(0, KScreenHeight/3 + 50, KScreenWidth, KScreenHeight)];
    maskView.delegate = delegate;
    maskView.backgroundColor = [UIColor clearColor];
    [view addSubview:maskView];
    return maskView;
}

-(void)playSong:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(startPlaySong:)]) {
        [self.delegate startPlaySong:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.waveLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).with.offset(150);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth, 120));
    }];
    
    [self.playSongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.waveLineView.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.playLastSong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.equalTo(self.playSongBtn);
        make.trailing.equalTo(self.playSongBtn.mas_leading).offset(-50);
    }];
    
    [self.playNextSong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.equalTo(self.playSongBtn);
        make.leading.equalTo(self.playSongBtn.mas_trailing).offset(50);
    }];
}

#pragma mark - getter
-(UIView *)waveLineView{
    if (!_waveLineView) {
        _waveLineView = [[UIView alloc] init];
        _waveLineView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_waveLineView];
    }
    return _waveLineView;
}

-(UIButton *)playSongBtn{
    if (!_playSongBtn) {
        _playSongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playSongBtn.backgroundColor = [UIColor yellowColor];
        [_playSongBtn addTarget:self action:@selector(playSong:) forControlEvents:UIControlEventTouchDragInside];
        [self addSubview:_playSongBtn];
    }
    return _playSongBtn;
}

-(UIButton *)playLastSong{
    if (!_playLastSong) {
        _playLastSong = [UIButton buttonWithType:UIButtonTypeCustom];
        _playLastSong.backgroundColor = [UIColor yellowColor];
        [self addSubview:_playLastSong];
    }
    return _playLastSong;
}

-(UIButton *)playNextSong{
    if (!_playNextSong) {
        _playNextSong = [UIButton buttonWithType:UIButtonTypeCustom];
        _playNextSong.backgroundColor = [UIColor yellowColor];
        [self addSubview:_playNextSong];
    }
    return _playNextSong;
}

@end
