//
//  M_LoginVc.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/24.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_LoginVc.h"
#import "M_LoginView.h"
#import "M_LoginAVManager.h"

@interface M_LoginVc ()<M_LoginViewDelegate>

/** 登录界面UI */
@property (nonatomic,strong) M_LoginView *loginView;

@end

@implementation M_LoginVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLoginAV];
    [self.view addSubview:self.loginView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[M_LoginAVManager loginManager] destroyAVPlayer];
}

#pragma mark - 加载登录视频画面
-(void)loadLoginAV{
    NSString* boundlePath = [[NSBundle mainBundle] pathForResource:@"M_LoginRes" ofType:@"bundle"];
    NSString* resUrl = [boundlePath stringByAppendingPathComponent:@"register_guide_video.mp4"];
    [[M_LoginAVManager loginManager] loginGiudeRes:resUrl superView:self.view];
}

#pragma mark - M_LoginViewDelegate
-(void)loginApp:(NSDictionary *)sender{
    
}

-(void)loginVistor:(id)sender{
    KPostNotification(KNotificationLoginStateChange, @YES);
}

-(void)forgetPassword:(id)sender{
    
}

-(void)registApp:(id)sender{
    
}

#pragma mark - getter
-(M_LoginView *)loginView{
    if (!_loginView) {
        _loginView = [[M_LoginView alloc] initWithFrame:self.view.bounds];
        _loginView.delegate = self;
    }
    return _loginView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
