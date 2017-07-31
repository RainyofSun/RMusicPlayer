//
//  SVProgressHUD+M_HUD.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/31.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
/**
 * SVProgressHUD 的二次封装
 */
@interface MBProgressHUD (M_HUD)

+(void)showTipMessageInWindow:(NSString*)message;
+(void)showTipMessageInView:(NSString*)message;
+(void)showTipMessageInWindow:(NSString *)message timer:(float)atimer;
+(void)showTipMessageInView:(NSString *)message timer:(float)atimer;

+(void)showActivityMessageInWindow:(NSString*)message;
+(void)showActivityMessageInView:(NSString *)message;
+(void)showActivityMessageInWindow:(NSString *)message timer:(float)aTimer;
+(void)showActivityMessageInView:(NSString *)message timer:(float)aTimer;

+(void)showSuccessMessage:(NSString*)message;
+(void)showErrorMessage:(NSString*)message;
+(void)showInfoMessage:(NSString*)message;
+(void)showWarningMessae:(NSString*)message;

+(void)showCustomIconInWindow:(NSString*)iconName message:(NSString*)message;
+(void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;

+(void)hideHUD;

+(void)showTopTipMessage:(NSString*)message;
+(void)showTopTipMessage:(NSString *)message isWindow:(BOOL)isWindow;

@end
