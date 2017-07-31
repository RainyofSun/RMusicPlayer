//
//  R_WebViewNavController.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_WebViewNavController.h"
#import "R_WebViewController.h"

@interface R_WebViewNavController ()

/** 由于popViewController 会触发shouldPopItems,因此用该布尔值记录是否应该正确 popitems*/
@property (nonatomic,assign) BOOL shouldPopItemAfterPopViewController;

@end

@implementation R_WebViewNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldPopItemAfterPopViewController = NO;
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popViewControllerAnimated:animated];
}

-(NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popToViewController:viewController animated:animated];
}

-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popToRootViewControllerAnimated:animated];
}

-(BOOL)navigationBar:(UINavigationBar*)navigationBar shouldPopItem:(nonnull UINavigationItem *)item{
    //如果应该pop,说明实在popviewcontroller之后,应该直接 popItems
    if (self.shouldPopItemAfterPopViewController) {
        self.shouldPopItemAfterPopViewController = NO;
        return YES;
    }
    
    //如果不应该pop,说明点击了导航栏的返回按钮,这时候就要做出判断是不是在webview中
    if ([self.topViewController isKindOfClass:[R_WebViewController class]]) {
        R_WebViewController* webVC = (R_WebViewController*)self.viewControllers.lastObject;
        if (webVC.webView.canGoBack) {
            [webVC.webView goBack];
            //make sure the back indicator view alpha back to 1
            self.shouldPopItemAfterPopViewController = NO;
            [[self.navigationBar subviews] lastObject].alpha = 1;
            return NO;
        } else {
            [self popViewControllerAnimated:YES];
            return NO;
        }
    } else {
        [self popViewControllerAnimated:YES];
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
