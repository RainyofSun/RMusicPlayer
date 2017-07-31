//
//  M_ShareManager.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_ShareManager.h"
#import <UShareUI/UShareUI.h>

@implementation M_ShareManager

SINGLETON_FOR_CLASS(M_ShareManager);

/**
 * 显示分享面板
 */
-(void)showShareView{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
       //根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
}

-(void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
    //创建分享消息对象
    UMSocialMessageObject* messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject* shareObject = [UMShareWebpageObject shareObjectWithTitle:@"" descr:@"" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com.social";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"share fail with error %@",error);
        } else {
            if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse* resp = result;
                //分享结果消息
                UMSocialLogInfo(@"response message info %@",resp.message);
                //第三方原始返回数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            } else {
                UMSocialLogInfo(@"response data is %@",result);
            }
        }
        [self alertWithError:error];
    }];
}

-(void)alertWithError:(NSError*)error{
    NSString* result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"share sucessed"];
    } else {
        NSMutableString* str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString* key in error.userInfo) {
                [str appendFormat:@"%@ = %@/n",key,error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"share fail with error code :%d\n %@",(int)error.code,str];
        } else {
            result = [NSString stringWithFormat:@"share fail"];
        }
    }
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure",@"确定")
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
