//
//  M_TabBar.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/20.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class R_TabbarItem,R_TabBar;

//给每个按钮定义协议 与 方法
@protocol R_TabBarDelegate <NSObject>

@optional
- (void)tabBar:(R_TabBar*)tabBarView didSelectedItemForm:(NSInteger)from to:(NSInteger)to;

@end

@interface R_TabBar : UIView

/** TabBar item title color */
@property (nonatomic,strong) UIColor *itemTitleColor;

/** Tabbar selected item tilte color */
@property (nonatomic,strong) UIColor *selectedItemColor;

/** Tabbar item title font */
@property (nonatomic,strong) UIFont *itemTitleFont;

/** Tabbar item's badge title font */
@property (nonatomic,strong) UIFont *badgeTitleFont;

/** Tabbar item image ratio */
@property (nonatomic,assign) CGFloat itemImageRatio;

/** Tabbar's item count */
@property (nonatomic,assign) NSInteger tabbarItemCount;

/** Tabbar's selected item */
@property (nonatomic,strong) R_TabbarItem *selectedItem;

/** Tabbar items array */
@property (nonatomic,strong) NSMutableArray *tabBarItems;

/**
 *  TabBar delegate
 */
@property (nonatomic, weak) id<R_TabBarDelegate> delegate;

/**
 *  Add tabBar item
 */
- (void)addTabBarItem:(UITabBarItem *)item;

@end
