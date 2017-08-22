//
//  R_MianTabbarController.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/21.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_MianTabbarController.h"
#import "R_TabbarItem.h"
#import "M_NewsVC.h"
#import "M_MineVC.h"

#define CNavBgColor  [UIColor colorWithHexString:@"00AE68"]

@interface R_MianTabbarController ()<R_TabBarDelegate>

/** tabbar root VC */
@property (nonatomic,strong) NSMutableArray *VCS;

@end

@implementation R_MianTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabBar
    [self setUpTabBar];
    //初始化VC添加子控制器
    [self setUpAllChildrenViewController];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self removeOriginControls];
}

#pragma mark - 初始化tabBar
-(void)setUpTabBar{
    [self.tabBar addSubview:({
        R_TabBar* tabBar = [[R_TabBar alloc] init];
        tabBar.frame = self.tabBar.bounds;
        tabBar.delegate = self;
        self.TabBar = tabBar;
    })];
}

#pragma mark - 初始化VC
-(void)setUpAllChildrenViewController{
    _VCS = @[].mutableCopy;
    M_NewsVC* news = [M_NewsVC new];
    [self setupChildViewController:news title:@"娱乐时尚" imageName:@"icon_tabbar_homepage" selectImageName:@"icon_tabbar_homepage_selected"];
    
//    M_MineVC* mine = [M_MineVC new];
//    [self setupChildViewController:mine title:@"我的" imageName:@"icon_tabbar_mine" selectImageName:@"icon_tabbar_mine_selected"];
    
    self.viewControllers = _VCS;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString*)title imageName:(NSString*)imageName selectImageName:(NSString*)selectImageName{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    
    //包装导航控制器
    R_RootNavController* nav = [[R_RootNavController alloc] initWithRootViewController:controller];
    [_VCS addObject:nav];
}

#pragma mark - 统一设置tabBarItem属性并添加到tabBar
-(void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    self.TabBar.badgeTitleFont          = SYSTEMFONT(11.0f);
    self.TabBar.itemTitleFont           = SYSTEMFONT(10.0f);
    self.TabBar.itemImageRatio          = self.itemImageRatio == 0 ? 0.7 : self.itemImageRatio;
    self.TabBar.itemTitleColor          = KBlackColor;
    self.TabBar.selectedItemColor       = CNavBgColor;
    
    self.TabBar.tabbarItemCount         = viewControllers.count;
    
    [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController* vc = (UIViewController*)obj;
        
        UIImage* selectedImg = vc.tabBarItem.selectedImage;
        vc.tabBarItem.selectedImage = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self addChildViewController:vc];
        
        [self.TabBar addTabBarItem:vc.tabBarItem];
    }];
}

#pragma mark - 选中某个tab
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    
    self.TabBar.selectedItem.selected = NO;
    self.TabBar.selectedItem = self.TabBar.tabBarItems[selectedIndex];
    self.TabBar.selectedItem.selected = YES;
}

#pragma mark - 去除系统自带的tabbar并把里面的按钮删除掉
-(void)removeOriginControls{
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj removeFromSuperview];
        }
    }];
}

#pragma mark - R_TabBarDelegate
-(void)tabBar:(R_TabBar *)tabBarView didSelectedItemForm:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
