//
//  M_UserInfo.h
//  UniversalApp
//
//  Created by 刘冉 on 2017/7/25.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,M_UserGender) {
    M_UserGender_UnKnow = 0,//未知
    M_UserGender_Male,//男
    M_UserGender_Female//女
};

@interface M_UserInfo : NSObject

/** 用户ID */
@property (nonatomic,copy) NSString *userid;
/** 用户头像 */
@property (nonatomic,copy) NSString *photo;
/** 用户昵称 */
@property (nonatomic,copy) NSString *nickName;
/** IM账号 */
@property (nonatomic,copy) NSString *imID;
/** 性别 */
@property (nonatomic,assign) M_UserGender *userSex;
/** IM密码 */
@property (nonatomic,copy) NSString *impass;
/** 用户等级 */
@property (nonatomic,copy) NSString *degreeId;
/** 个性签名 */
@property (nonatomic,copy) NSString *signature;


@end
