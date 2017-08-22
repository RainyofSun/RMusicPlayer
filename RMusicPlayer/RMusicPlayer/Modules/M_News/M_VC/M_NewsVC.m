//
//  M_NewsVC.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/2.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_NewsVC.h"
#import "M_MineVC.h"

@interface M_NewsVC ()

/** 我的侧滑菜单 */
@property (nonatomic,strong) LLSlideMenu *slideMenu;
/** 我的界面 */
@property (nonatomic,strong) M_MineVC *mineView;
/** 侧滑手势的偏移 */
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *percent;

@end

@implementation M_NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"娱乐时尚";
    self.R_IsHideTabBar = YES;
    [kAppWindow addSubview:self.slideMenu];
    [self.slideMenu addSubview:self.mineView.view];
    [self setUpNav];
    [self addObserver];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 添加监听
-(void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slideMenuShow:) name:kMyMenuShow object:nil];
}

#pragma mark - 创建左NavItem
-(void)setUpNav{
    [self R_AddNavigationItemWithImageNames:@[@"icon_tabbar_mine"] isLeft:YES target:self action:@selector(jumpMine:) tags:@[@100]];
}

-(void)jumpMine:(UIButton*)sender{
    [self.slideMenu ll_openSlideMenu];
}

#pragma mark - 策划手势监听通知
-(void)slideMenuShow:(NSNotification*)notification{
    UIPanGestureRecognizer* reconger = (UIPanGestureRecognizer*)notification.object;
    if (self.slideMenu.ll_isOpen || self.slideMenu.ll_isAnimating) {
        /// 如果菜单栏已经出现或者已打开 禁止滑动
        return;
    }
    
    /// 计算手指滑的物理距离(滑动的距离与起始位置无关)
    CGFloat progress = [reconger translationInView:self.view].x / (KScreenWidth * 1.0);
    /// 把百分比限制在0-1之间
    progress = MIN(1.0, MAX(0.0, progress));
    
    /// 当手势刚刚开始时，创建一个UIPercentDrivenInteractiveTransition对象
    if (reconger.state == UIGestureRecognizerStateBegan) {
        self.percent = [[UIPercentDrivenInteractiveTransition alloc] init];
    } else if (reconger.state == UIGestureRecognizerStateChanged) {
        /// 当手慢慢划入时, 我们把总体手势划入的进度告诉UIPercentDrivenInteractiveTransition对象
        [self.percent updateInteractiveTransition:progress];
        self.slideMenu.ll_distance = [reconger translationInView:self.view].x;
    } else if (reconger.state == UIGestureRecognizerStateCancelled || reconger.state == UIGestureRecognizerStateEnded) {
        /// 当手势结束时, 我们根据用户的手势进度来判断过渡是应该完成海试取消并相应的调用 finishInteractiveTranstion 或者 cancelInteractiveTranstion 方法
        if (progress > 0.2) {
            [self.percent finishInteractiveTransition];
            [self.slideMenu ll_openSlideMenu];
        } else {
            [self.percent cancelInteractiveTransition];
            [self.slideMenu ll_closeSlideMenu];
        }
    }
}

#pragma mark - getter
-(LLSlideMenu *)slideMenu{
    if (!_slideMenu) {
        _slideMenu = [[LLSlideMenu alloc] init];
        /// 设置菜单宽度
        _slideMenu.ll_menuWidth = KScreenWidth/13*7;
        /// 设置菜单背景色
        _slideMenu.ll_menuBackgroundColor = KWhiteColor;
        /// 设置弹力和速度
        _slideMenu.ll_springDamping = 20; // 阻力-->阻尼系数越大，停止越快
        _slideMenu.ll_springVelocity = 5; // 速度-->动画回弹越快，越生硬
        _slideMenu.ll_springFramesNum = 30; //关键帧数量
    }
    return _slideMenu;
}

-(M_MineVC *)mineView{
    if (!_mineView) {
        _mineView = [[M_MineVC alloc] init];
        _mineView.view.frame = CGRectMake(0, 0, KScreenWidth/13*7, KScreenHeight);
    }
    return _mineView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
