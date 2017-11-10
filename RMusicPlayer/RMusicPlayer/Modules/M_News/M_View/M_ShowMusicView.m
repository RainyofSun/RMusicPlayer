//
//  M_ShowMusicView.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_ShowMusicView.h"

@interface M_ShowMusicView ()

/** 音乐图片 */
@property (nonatomic,strong) M_BaseImageView *musicImage;
/** 歌名 */
@property (nonatomic,strong) UILabel *musicName;
/** 歌手 */
@property (nonatomic,strong) UILabel *musicSonger;
/** 播放按钮 */
@property (nonatomic,strong) UIButton *musicPlayBtn;
/** 歌单 */
@property (nonatomic,strong) UIButton *musicList;

@end

@implementation M_ShowMusicView

+(instancetype)showMusicView:(UIView *)view delegate:(id<M_ShowMusicViewDelegate>)delegate{
    M_ShowMusicView* music = [[M_ShowMusicView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 60, kScreenWidth, 60)];
    music.backgroundColor = [UIColor whiteColor];
    music.delegate = delegate;
    [view addSubview:music];
    return music;
}

-(void)tapMusicImg{
    if ([self.delegate respondsToSelector:@selector(touchMusic:)]) {
        [self.delegate touchMusic:self];
    }
}

-(void)playMusic:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(startPlayMusic:)]) {
        [self.delegate startPlayMusic:self];
    }
}

-(void)showMusicList:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(showLocalMusicList:)]) {
        [self.delegate showLocalMusicList:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.musicImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).with.offset(15);
        make.top.equalTo(self.mas_top).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.musicName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.musicImage);
        make.leading.equalTo(self.musicImage.mas_trailing).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth/2, 25));
    }];
    
    [self.musicSonger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.equalTo(self.musicName);
        make.top.equalTo(self.musicName.mas_bottom).with.offset(3);
    }];
    
    [self.musicPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.musicName.mas_trailing).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.musicList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.musicPlayBtn.mas_trailing).with.offset(13);
        make.size.equalTo(self.musicPlayBtn);
    }];
}

#pragma mark - getter
-(M_BaseImageView *)musicImage{
    if (!_musicImage) {
        _musicImage = [[M_BaseImageView alloc] init];
        _musicImage.backgroundColor = [UIColor yellowColor];
        _musicImage.layer.cornerRadius = 25;
        _musicImage.layer.masksToBounds = YES;
        _musicImage.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMusicImg)];
        [_musicImage addGestureRecognizer:tap];
        [self addSubview:_musicImage];
    }
    return _musicImage;
}

-(UILabel *)musicName{
    if (!_musicName) {
        _musicName = [[UILabel alloc] init];
        _musicName.backgroundColor = [UIColor yellowColor];
        [self addSubview:_musicName];
    }
    return _musicName;
}

-(UILabel *)musicSonger{
    if (!_musicSonger) {
        _musicSonger = [[UILabel alloc] init];
        _musicSonger.backgroundColor = [UIColor yellowColor];
        [self addSubview:_musicSonger];
    }
    return _musicSonger;
}

-(UIButton *)musicPlayBtn{
    if (!_musicPlayBtn) {
        _musicPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _musicPlayBtn.layer.cornerRadius = 20;
        _musicPlayBtn.layer.masksToBounds = YES;
        _musicPlayBtn.backgroundColor = [UIColor yellowColor];
        [_musicPlayBtn addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_musicPlayBtn];
    }
    return _musicPlayBtn;
}

-(UIButton *)musicList{
    if (!_musicList) {
        _musicList = [UIButton buttonWithType:UIButtonTypeCustom];
        _musicList.backgroundColor = [UIColor yellowColor];
        [_musicList addTarget:self action:@selector(showMusicList:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_musicList];
    }
    return _musicList;
}

@end
