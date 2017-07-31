//
//  R_TabbarItem.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/20.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface R_TabbarItem : UIButton

/** Tabbar item */
@property (nonatomic,strong) UITabBarItem *tabbarItem;

/** Tabbar's item count */
@property (nonatomic,assign) NSInteger tabbarItemCount;

/** Tabbar item title color */
@property (nonatomic,strong) UIColor *itemTitleColor;

/** Tabbar selected item title color */
@property (nonatomic,strong) UIColor *selectedItemTitleColor;

/** Tabbar item title font */
@property (nonatomic,strong) UIFont *itemTitleFont;

/** Tabbar item's badge title font */
@property (nonatomic,strong) UIFont *badgeTitleFont;

/** Tabbar item image ratio */
@property (nonatomic,assign) CGFloat itemImageRatio;

/**
 * Tabbar item init func
 */
- (instancetype)initWithItemImageRatio:(CGFloat)itemImageRatio;

@end
