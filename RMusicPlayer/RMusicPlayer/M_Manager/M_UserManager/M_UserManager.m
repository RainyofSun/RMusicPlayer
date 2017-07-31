//
//  M_UserManager.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/25.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_UserManager.h"
#import "CommonMacros.h"
#import <UMSocialCore/UMSocialCore.h>
#import "M_LibMacros.h"

@implementation M_UserManager

SINGLETON_FOR_CLASS(M_UserManager);

-(instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick:)
                                                     name:KNotificationOnKick
                                                   object:nil];
    }
    return self;
}

#pragma mark - 三方登录
-(void)login:(UserLoginType)loginType completion:(LoginBack)completion{
    [self login:loginType params:nil completion:completion];
}

#pragma mark - 带参数登录
-(void)login:(UserLoginType)loginType params:(NSDictionary *)params completion:(LoginBack)completion{
    //设置友盟登录类型
    UMSocialPlatformType platFormType;
    switch (loginType) {
        case UserLoginType_QQ:
            platFormType = UMSocialPlatformType_QQ;
            break;
        case UserLoginType_WeChat:
            platFormType = UMSocialPlatformType_WechatSession;
            break;
        default:
            platFormType = UMSocialPlatformType_UnKnown;
            break;
    }
    
    //第三方登录
    if (loginType != UserLoginType_PWD) {
        
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
                if (completion) {
                    completion(NO,error.localizedDescription);
                }
            } else {
                UMSocialUserInfoResponse* resp = result;
//                NSString* unionid = resp.originalResponse[@"unionid"] == nil ? @"" : resp.originalResponse[@"unionid"];
                NSString* openid = resp.openid == nil ? @"" : resp.openid;
                NSString* name = resp.name == nil ? @"" : resp.name;
                //登录参数
                NSDictionary* params = @{@"openid":openid,
                                         @"nickname":name,
                                         @"photo":resp.iconurl,
                                         @"sex":[resp.unionGender isEqualToString:@"男"] ? @1 : @2,
                                         @"cityname":resp.originalResponse[@"city"],
                                         @"fr":@(loginType)};
                self.loginType = loginType;
                //登录到服务器
                [self loginToServer:params completion:completion];
            }
        }];
    }
}

#pragma mark - 手动登录到服务器
-(void)loginToServer:(NSDictionary*)params completion:(LoginBack)completion{
    
    
}

#pragma mark - 自动登录服务器
-(void)autoLoginToServer:(LoginBack)completion{
    
}

#pragma mark - 登录成功的处理
-(void)loginSucess:(id)responseObject completion:(LoginBack)completion{
    
}

#pragma mark - 储存用户信息
-(void)saveUserInfo{
    if (self.curUserInfo) {
        YYCache* cache = [[YYCache alloc] initWithName:KUserCacheName];
        NSDictionary* dic = [self.curUserInfo modelToJSONObject];
        [cache setObject:dic forKey:KUserModelCache];
    }
}

//pod 'PPNetworkHelper',:git => 'https://github.com/jkpang/PPNetworkHelper.git'

#pragma mark - 加载缓存的用户信息
-(BOOL)loadUserInfo{
    YYCache* cache = [[YYCache alloc] initWithName:KUserCacheName];
    NSDictionary* userDic = (NSDictionary*)[cache objectForKey:KUserModelCache];
    if (userDic) {
        self.curUserInfo = [M_UserInfo modelWithDictionary:userDic];
        return YES;
    }
    return NO;
}

#pragma mark - 被踢下线
-(void)onKick:(NSNotification*)notification{
    [self logout:nil];
}

#pragma mark - 退出登录
-(void)logout:(LoginBack)completion{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    //IM登出操作
    
    //清空用户缓存
    self.curUserInfo = nil;
    self.isLogined = NO;
    
    //移除缓存
    YYCache* cache = [[YYCache alloc] initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    
    KPostNotification(KNotificationLoginStateChange, @NO);
}

@end
