//
//  R_TabbarBadge.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/20.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * tabbar 红点
 */

@interface R_TabbarBadge : UIButton

/** Tabbar item badge value */
@property (nonatomic,copy) NSString *badgeValue;

/** Tabbar's item count */
@property (nonatomic,assign) NSInteger tabbarItemCount;

/** Tabbar item's badge title font */
@property (nonatomic,strong) UIFont *badgeTtitleFont;


@end
