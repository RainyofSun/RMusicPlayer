//
//  M_AdPageView.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 启动广告业面
 */

static NSString* const adImageName = @"adImageName";
static NSString* const adUrl = @"adUrl";

typedef void(^TapBlock)();

@interface M_AdPageView : UIView

-(instancetype)initWithFrame:(CGRect)frame withTapBlcok:(TapBlock)tapBlock;

/**
 * 显示广告页面的方法
 */
-(void)show;

/** 图片路径 */
@property (nonatomic,copy) NSString *filePath;

@end
