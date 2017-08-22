//
//  M_AppManager.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_AppManager.h"
#import "M_AdPageView.h"
#import "M_FPSLabel.h"

@implementation M_AppManager

+(void)appStart{
    //加载广告
    M_AdPageView* adView = [[M_AdPageView alloc] initWithFrame:kScreen_Bounds withTapBlcok:^{
        R_RootNavController* loginNav = [[R_RootNavController alloc] initWithRootViewController:[[R_RootWebViewController alloc] initWithUrl:@"http://www.hao123.com"]];
        [kRootViewController presentViewController:loginNav animated:YES completion:nil];
    }];
    adView = adView;
}

#pragma mark - FPS监测
+(void)showFPS{
    M_FPSLabel* _fpsLabel = [M_FPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = KScreenHeight - 55;
    _fpsLabel.right = KScreenWidth - 10;
    
    [kAppWindow addSubview:_fpsLabel];
}

@end
