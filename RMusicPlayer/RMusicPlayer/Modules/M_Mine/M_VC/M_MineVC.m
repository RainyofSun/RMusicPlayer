//
//  M_MineVC.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/2.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_MineVC.h"
#import "M_MineView.h"
#import "M_UserManager.h"

@interface M_MineVC ()

/** 登录UI */
@property (nonatomic,strong) M_MineView *mineView;

@end

@implementation M_MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.mineView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if (userManager.isLogined) {
//        self.mineView.userLoginStatus = LoginStatusType_Logined;
//    } else {
//        self.mineView.userLoginStatus = LoginStatusType_Unlogin;
//    }
    self.mineView.userLoginStatus = LoginStatusType_Logined;
}

-(M_MineView *)mineView{
    if (!_mineView) {
        _mineView = [[M_MineView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth/13*7, KScreenHeight)];
    }
    return _mineView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
