//
//  M_MineView.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/2.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LoginStatusType) {
    LoginStatusType_Logined,
    LoginStatusType_Unlogin
};

@interface M_MineView : UIView

/** 登录状态 */
@property (nonatomic,assign) LoginStatusType userLoginStatus;

@end
