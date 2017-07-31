//
//  SVProgressHUD+M_HUD.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/31.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "MBProgressHUD+M_HUD.h"
#import "UtilsMacros.h"
#import "AppDelegate+AppService.h"
#import <YYKit.h>

/**
 * 默认隐藏时间
 */
const NSInteger hideTime = 2;

@implementation MBProgressHUD (M_HUD)

+(MBProgressHUD*)createSVProgressHUDViewWithMessage:(NSString*)message isWindow:(BOOL)isWindow{
    UIView* view = isWindow ? (UIView*)[UIApplication sharedApplication].delegate.window : [kAppDelegate getCurrentUIVC].view;
    MBProgressHUD* hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    } else {
        [hud showAnimated:YES];
    }
    
    hud.minSize = CGSizeMake(100, 100);
    hud.label.text = message ? message : @"加载中...";
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.textColor = KWhiteColor;
    hud.label.numberOfLines = 0;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.9];
    hud.removeFromSuperViewOnHide = YES;
    [hud setContentColor:KWhiteColor];
    return hud;
}

#pragma mark -------------------   show tip   ------------------

+(void)showTipMessageInWindow:(NSString *)message isWindow:(BOOL)isWindow timer:(float)atimer{
    MBProgressHUD* hud = [self createSVProgressHUDViewWithMessage:message isWindow:isWindow];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:hideTime];
}

+(void)showTipMessageInWindow:(NSString *)message{
    [self showTipMessageInWindow:message isWindow:YES timer:hideTime];
}

+(void)showTipMessageInView:(NSString *)message{
    [self showTipMessageInWindow:message isWindow:NO timer:hideTime];
}

+(void)showTipMessageInWindow:(NSString *)message timer:(float)atimer{
    [self showTipMessageInWindow:message isWindow:YES timer:atimer];
}

+(void)showTipMessageInView:(NSString *)message timer:(float)atimer{
    [self showTipMessageInWindow:message isWindow:NO timer:atimer];
}

#pragma mark ------------------------   show activity   --------------------------

+(void)showActivityMessageInWindow:(NSString *)message isWindow:(BOOL)isWindow timer:(float)timer{
    MBProgressHUD* hud = [self createSVProgressHUDViewWithMessage:message isWindow:isWindow];
    hud.mode = MBProgressHUDModeDeterminate;
    if (timer > 0 ) {
        [hud hideAnimated:YES afterDelay:timer];
    }
}

+(void)showActivityMessageInWindow:(NSString *)message{
    [self showActivityMessageInWindow:message isWindow:YES timer:hideTime];
}

+(void)showActivityMessageInView:(NSString *)message{
    [self showActivityMessageInWindow:message isWindow:NO timer:hideTime];
}

+(void)showActivityMessageInWindow:(NSString *)message timer:(float)aTimer{
    [self showActivityMessageInWindow:message isWindow:YES timer:aTimer];
}

+(void)showActivityMessageInView:(NSString *)message timer:(float)aTimer{
    [self showActivityMessageInWindow:message isWindow:NO timer:aTimer];
}

#pragma mark ---------------------    show image    ----------------------

+(void)showSuccessMessage:(NSString *)message{
    [self showCustomIconInWindow:@"MBHUD_Sucess" message:message];
}

+(void)showErrorMessage:(NSString *)message{
    [self showCustomIconInWindow:@"MBHUD_Error" message:message];
}

+(void)showInfoMessage:(NSString *)message{
    [self showCustomIconInWindow:@"MBHUD_Info" message:message];
}

+(void)showWarningMessae:(NSString *)message{
    [self showCustomIconInWindow:@"MBHUD_Warn" message:message];
}

+(void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message{
    [self showCustomIcon:iconName message:message isWindow:YES];
}

+(void)showCustomIconInView:(NSString *)iconName message:(NSString *)message{
    [self showCustomIcon:iconName message:message isWindow:NO];
}

+(void)showCustomIcon:(NSString*)iconName message:(NSString*)messae isWindow:(BOOL)isWindow{
    MBProgressHUD* hud = [self createSVProgressHUDViewWithMessage:messae isWindow:isWindow];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    [hud hideAnimated:YES afterDelay:hideTime];
}

+(void)hideHUD{
    [self hideHUDForView:[kAppDelegate getCurrentUIVC].view animated:YES];
}

#pragma mark ----------------------  顶部tip  -------------------------
+(void)showTopTipMessage:(NSString *)message{
    [self showTopTipMessage:message isWindow:NO];
}

+(void)showTopTipMessage:(NSString *)message isWindow:(BOOL)isWindow{
    CGFloat paddIng = 10;
    
    YYLabel* label = [YYLabel new];
    label.text = message;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = KWhiteColor;
    label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.8];
    label.width = KScreenWidth;
    label.textContainerInset = UIEdgeInsetsMake(paddIng + paddIng, paddIng, 0, paddIng);
    
    if (isWindow) {
        label.height = 64;
        label.bottom = 0;
        [kAppWindow addSubview:label];
        
        [UIView animateWithDuration:0.3 animations:^{
            label.top = 0;
        } completion:^(BOOL finished) {
           [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
               label.bottom = 0;
           } completion:^(BOOL finished) {
               [label removeFromSuperview];
           }];
        }];
    } else {
        label.height = [message heightForFont:label.font width:kAppWindow.width] + 2 * paddIng;
        label.bottom = kiOS7Later ? 64 : 0;
        [[kAppDelegate getCurrentUIVC].view addSubview:label];
        
        [UIView animateWithDuration:0.3 animations:^{
            label.top = (kiOS7Later ? 64 : 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                label.bottom = (kiOS7Later ? 64 : 0);
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
    }
}

@end
