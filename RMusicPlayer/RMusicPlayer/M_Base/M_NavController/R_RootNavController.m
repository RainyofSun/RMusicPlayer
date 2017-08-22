//
//  R_RootNavController.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_RootNavController.h"
#import "XYTransitionProtocol.h"
#import "XYTransition.h"

@interface R_RootNavController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

/** pop delegate */
@property (nonatomic,weak) id popDelegate;
/**<#object#>*/
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTranstion;
/**<#object#>*/
@property (nonatomic,strong) UIPanGestureRecognizer *popRecognizer;/// UIPanGestureRecognizer 比 UIScreenEdgePanGestureRecognizer 触发更灵敏
/** 是否开启系统右滑返回 */
@property (nonatomic,assign) BOOL isSystemSlidBack;

@end

@implementation R_RootNavController

//APP生命周期中，只知性一次
+(void)initialize{
    //导航栏主题 title文字属性
    UINavigationBar* navBar = [UINavigationBar appearance];
    //导航栏背景图
    [navBar setBackgroundImage:[UIImage imageNamed:@"tabBarbj"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBarTintColor:CNavBgColor];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
    _popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTranstion:)];
    
    [_popRecognizer setEnabled:YES];
    [self.view addGestureRecognizer:_popRecognizer];
}

#pragma mark - 解决手势失效的问题
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self;
    } else {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    
    if (_isSystemSlidBack) {
        self.interactivePopGestureRecognizer.enabled = YES;
        [_popRecognizer setEnabled:NO];
    } else {
        self.interactivePopGestureRecognizer.enabled = NO;
        [_popRecognizer setEnabled:YES];
    }
}

#pragma mark - push时隐藏tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[R_RootViewController class]]) {
        R_RootViewController* rootVC = (R_RootViewController*)viewController;
        if (rootVC.R_IsHideNavBar) {
            [rootVC.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            [rootVC.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

#pragma mark - 返回指定的类视图
-(BOOL)popToAppointViewController:(NSString *)ClassName animationed:(BOOL)animated{
    id VC = [self getCurrentViewControllerClass:ClassName];
    if (VC != nil && [VC isKindOfClass:[UIViewController class]]) {
        [self popToViewController:VC animated:animated];
        return YES;
    }
    return NO;
}

/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName{
    Class classObj = NSClassFromString(ClassName);
    
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj]){
            return vc;
        }
    }
    return nil;
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

#pragma mark - 转场动画区
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    self.isSystemSlidBack = YES;
    //如果来源vc和目标vc都实现协议,那么开始动画
    if ([fromVC conformsToProtocol:@protocol(XYTransitionProtocol)] && [toVC conformsToProtocol:@protocol(XYTransitionProtocol)]) {
        BOOL printerNeed = [self isNeedTransition:fromVC :toVC];
        XYTransition* transtion = [XYTransition new];
        if (operation == UINavigationControllerOperationPush && printerNeed) {
            transtion.isPush = YES;
            self.isSystemSlidBack = NO;
        } else if (operation == UINavigationControllerOperationPop && printerNeed) {
            transtion.isPush = NO;
            self.isSystemSlidBack = NO;
        } else {
            return nil;
        }
        return transtion;
    } else if ([toVC conformsToProtocol:@protocol(XYTransitionProtocol)]) {
        //如果只有目标vc开启动画，那么isSystemSlidBack也要随之改变
        BOOL printerNeed = [self isNeedTransition:toVC];
        self.isSystemSlidBack = !printerNeed;
        return nil;
    }
    return nil;
}

//判断fromVC和toVC是否需要实现printers效果
-(BOOL)isNeedTransition:(UIViewController<XYTransitionProtocol> *)fromVC :(UIViewController<XYTransitionProtocol>*)toVC{
    BOOL a = NO;
    BOOL b = NO;
    if ([fromVC respondsToSelector:@selector(isNeedTransition)] && [fromVC isNeedTransition]) {
        a = YES;
    }
    if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
        b = YES;
    }
    return (a && b);
}

-(BOOL)isNeedTransition:(UIViewController<XYTransitionProtocol>*) tovc{
    BOOL b = NO;
    if ([tovc respondsToSelector:@selector(isNeedTransition)] && [tovc isNeedTransition]) {
        b = YES;
    }
    return b;
}

#pragma mark - NavigationControllerDelegate
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (!self.interactivePopTranstion) {
        return nil;
    }
    
    return self.interactivePopTranstion;
}

#pragma mark - UIGestureRecognizer handers
-(void)handleNavigationTranstion:(UIPanGestureRecognizer*)reconger{
    CGFloat progress = [reconger translationInView:self.view].x / self.view.bounds.size.width;
    NSLog(@"右划%0.2f",progress);
    if (self.viewControllers.count == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMyMenuShow object:reconger];
        return;
    }
    if (reconger.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTranstion = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    } else if (reconger.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTranstion updateInteractiveTransition:progress];
    } else if (reconger.state == UIGestureRecognizerStateEnded || reconger.state == UIGestureRecognizerStateCancelled) {
        CGPoint velocity = [reconger velocityInView:reconger.view];
        
        if (progress > 0.5 || velocity.x > 1000) {
            [self.interactivePopTranstion finishInteractiveTransition];
        } else {
            [self.interactivePopTranstion cancelInteractiveTransition];
        }
        self.interactivePopTranstion = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
