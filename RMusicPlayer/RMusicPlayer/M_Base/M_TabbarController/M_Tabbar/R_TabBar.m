//
//  M_TabBar.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/20.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_TabBar.h"
#import "R_TabbarItem.h"

@implementation R_TabBar

-(NSMutableArray *)tabBarItems{
    if (!_tabBarItems) {
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}

-(void)addTabBarItem:(UITabBarItem *)item{
    R_TabbarItem* tabbarItem = [[R_TabbarItem alloc] initWithItemImageRatio:self.itemImageRatio];
    
    tabbarItem.badgeTitleFont           = self.badgeTitleFont;
    tabbarItem.itemTitleFont            = self.itemTitleFont;
    tabbarItem.itemTitleColor           = self.itemTitleColor;
    tabbarItem.selectedItemTitleColor   = self.selectedItemColor;
    
    tabbarItem.tabbarItemCount          = self.tabbarItemCount;
    
    tabbarItem.tabbarItem = item;
    
    [tabbarItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabbarItem];
    
    [self.tabBarItems addObject:tabbarItem];
    
    if (self.tabBarItems.count == 1) {
        [self buttonClick:tabbarItem];
    }
}

-(void)buttonClick:(R_TabbarItem*)tabBarItem{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedItemForm:to:)]) {
        [self.delegate tabBar:self didSelectedItemForm:self.selectedItem.tag to:tabBarItem.tag];
    }
    
    self.selectedItem.selected = NO;
    self.selectedItem = tabBarItem;
    self.selectedItem.selected = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    int count = (int)self.tabBarItems.count;
    CGFloat itemY = 0;
    CGFloat itemW = w / self.subviews.count;
    CGFloat itemH = h;
    
    for (int index = 0; index < count; index ++ ) {
        R_TabbarItem* tabBarItem = self.tabBarItems[index];
        tabBarItem.tag = index;
        CGFloat itemX = index * itemW;
        tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
    }
}

@end
