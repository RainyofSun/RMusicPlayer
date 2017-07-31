//
//  M_UserManager.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/25.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M_UserInfo.h"
#import "UtilsMacros.h"

typedef NS_ENUM(NSInteger,UserLoginType) {
    UserLoginType_Unkown,//未知
    UserLoginType_WeChat,//微信登录
    UserLoginType_QQ,//QQ登录
    UserLoginType_PWD//账号登录
};

typedef void(^LoginBack)(BOOL sucess,NSString* des);

#define isLogin     [M_UserManager sharedM_UserManager].isLogined
#define curUser     [M_UserManager sharedM_UserManager].curUserInfo
#define userManager [M_UserManager sharedM_UserManager]

/**
 * 包含用户相关服务
 */
@interface M_UserManager : NSObject

/**
 * 单利
 */
SINGLETON_FOR_HEADER(M_UserManager)

/** 当前用户 */
@property (nonatomic,strong) M_UserInfo *curUserInfo;
/** 当前登录类型 */
@property (nonatomic,assign) UserLoginType loginType;
/** 标记是否登录 */
@property (nonatomic,assign) BOOL isLogined;

#pragma mark - 登录相关
/**
 * 三方登录
 * @param loginType     登录方式
 * @param completion    回调
 */
-(void)login:(UserLoginType)loginType completion:(LoginBack)completion;

/**
 * 带参登录
 * @param loginType     登录方式
 * @param params        手机和账号登录需要
 * @param completion    回调
 */
-(void)login:(UserLoginType)loginType params:(NSDictionary*)params completion:(LoginBack)completion;

/**
 * 自动登录
 * @param completion    回调
 */
-(void)autoLoginToServer:(LoginBack)completion;

/**
 * 退出登录
 * @param completion    回调
 */
-(void)logout:(LoginBack)completion;

/**
 * 加载缓存用户数据
 * @return              是否成功
 */
-(BOOL)loadUserInfo;

@end
