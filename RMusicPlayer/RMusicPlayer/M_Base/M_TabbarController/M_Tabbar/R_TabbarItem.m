//
//  R_TabbarItem.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/20.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_TabbarItem.h"
#import "R_TabbarBadge.h"

@interface R_TabbarItem ()

/** Tabbar badge */
@property (nonatomic,strong) R_TabbarBadge *tabbarBadge;

@end

@implementation R_TabbarItem

-(void)dealloc{
    [self.tabbarItem removeObserver:self forKeyPath:@"badgeValue"];
    [self.tabbarItem removeObserver:self forKeyPath:@"title"];
    [self.tabbarItem removeObserver:self forKeyPath:@"image"];
    [self.tabbarItem removeObserver:self forKeyPath:@"selectedImage"];
}

-(instancetype)initWithItemImageRatio:(CGFloat)itemImageRatio{
    if (self = [super init]) {
        self.itemImageRatio = itemImageRatio;
    }
    return self;
}

#pragma mark - setter
-(void)setItemTitleFont:(UIFont *)itemTitleFont{
    _itemTitleFont = itemTitleFont;
    self.titleLabel.font = itemTitleFont;
}

-(void)setItemTitleColor:(UIColor *)itemTitleColor{
    _itemTitleColor = itemTitleColor;
    [self setTitleColor:itemTitleColor forState:UIControlStateNormal];
}

-(void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor{
    _selectedItemTitleColor = selectedItemTitleColor;
    [self setTitleColor:selectedItemTitleColor forState:UIControlStateSelected];
}

-(void)setBadgeTitleFont:(UIFont *)badgeTitleFont{
    _badgeTitleFont = badgeTitleFont;
    self.tabbarBadge.badgeTtitleFont = badgeTitleFont;
}

-(void)setTabbarItemCount:(NSInteger)tabbarItemCount{
    _tabbarItemCount = tabbarItemCount;
    self.tabbarBadge.tabbarItemCount = tabbarItemCount;
}

-(void)setTabbarItem:(UITabBarItem *)tabbarItem{
    _tabbarItem = tabbarItem;
    
    [tabbarItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [tabbarItem addObserver:self forKeyPath:@"title" options:0 context:nil];
    [tabbarItem addObserver:self forKeyPath:@"image" options:0 context:nil];
    [tabbarItem addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self setTitle:self.tabbarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabbarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabbarItem.selectedImage forState:UIControlStateSelected];
    
    self.tabbarBadge.badgeValue = self.tabbarItem.badgeValue;
}

#pragma mark - Reset tabbarItem 
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = 0.f;
    CGFloat imageY = 0.f;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height *  self.itemImageRatio;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0.f;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height * self.itemImageRatio + (self.itemImageRatio == 1.0f ? 100.0f : -5.0f);
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(void)setHighlighted:(BOOL)highlighted{};

@end
