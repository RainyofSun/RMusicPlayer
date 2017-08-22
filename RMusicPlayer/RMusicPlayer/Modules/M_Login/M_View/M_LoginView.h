//
//  M_LoginView.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/1.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol M_LoginViewDelegate <NSObject>

/**
 * 登录按钮
 */
-(void)loginApp:(NSDictionary*)sender;

/**
 * 游客登录
 */
-(void)loginVistor:(id)sender;

/**
 * 注册按钮
 */
-(void)registApp:(id)sender;

/**
 * 找回密码
 */
-(void)forgetPassword:(id)sender;

@end

/**
 * 登录界面的UI
 */

@interface M_LoginView : UIView

/** delegate */
@property (nonatomic,weak) id<M_LoginViewDelegate> delegate;

@end
