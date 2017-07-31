//
//  R_RootViewController.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_RootViewController.h"
#import "R_RootNavController.h"
#import "M_LoginVc.h"
#import "M_LibMacros.h"
#import "FontAndColorMacros.h"

@interface R_RootViewController ()

/** 加载无数据占位图片 */
@property (nonatomic,strong) UIImageView *noDataView;

@end

@implementation R_RootViewController

#pragma mark - life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KWhiteColor;
    //是否显示返回按钮
    self.R_IsShowLiftBack = YES;
    self.statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - 更改状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return _statusBarStyle;
}

-(void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 跳转登录界面
-(void)R_GoLogin{
    R_RootNavController* loginNav = [[R_RootNavController alloc] initWithRootViewController:[[M_LoginVc alloc] init]];
    [self presentViewController:loginNav animated:YES completion:nil];
}

-(void)R_GoLoginWithPush{
    [self.navigationController pushViewController:[[M_LoginVc alloc] init]animated:YES];
}

-(void)R_ShowShouldLoginPoint{
    
}

-(void)R_ShowLoadingAnimation{
    
}

-(void)R_StopLoadingAnimation{
    
}

-(void)R_ShowNoDataImage{
    _noDataView = [[UIImageView alloc] init];
    [_noDataView setImage:[UIImage imageNamed:@"generl_nodata"]];
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            _noDataView.frame = CGRectMake(0, 0, obj.frame.size.width, obj.frame.size.height);
            [obj addSubview:_noDataView];
        }
    }];
}

-(void)R_RemoveNoDataImage{
    if (_noDataView) {
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
}

/**
 * 懒加载UItableView
 */
-(UITableView *)rootTabView{
    if (!_rootTabView) {
        _rootTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        //头部刷新
        MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = NO;
        _rootTabView.mj_header = header;
        
        //底部刷新
        _rootTabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
        _rootTabView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
        _rootTabView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
        _rootTabView.backgroundColor = CViewBgColor;
        _rootTabView.scrollsToTop = YES;
        _rootTabView.tableFooterView = [[UIView alloc] init];
    }
    return _rootTabView;
}

/**
 * 懒加载 collectionView
 */
-(UICollectionView *)rootCollectionView{
    if (!_rootCollectionView) {
        UICollectionViewFlowLayout* flow = [[UICollectionViewFlowLayout alloc] init];
        _rootCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flow];
        MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = NO;
        _rootCollectionView.mj_header = header;
        
        MJRefreshBackNormalFooter* footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
        _rootCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
        _rootCollectionView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
        _rootCollectionView.backgroundColor = CViewBgColor;
        _rootCollectionView.scrollsToTop = YES;
        _rootCollectionView.mj_footer = footer;
    }
    return _rootCollectionView;
}

-(void)headerRefreshing{
    
}

-(void)footerRefreshing{
    
}

/**
 * 是否显示返回按钮
 */
-(void)setR_IsShowLiftBack:(BOOL)R_IsShowLiftBack{
    _R_IsShowLiftBack = R_IsShowLiftBack;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //下边判断的意义是 当VC所在的导航控制器中的VC的个数大于1 或者 是present出来的VC时，才展示返回按钮 其他情况不展示
    if (R_IsShowLiftBack && (VCCount > 1 || self.navigationController.presentationController != nil)) {
        [self R_AddNavigationItemWithTitles:@[@"返回"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem* NULLBar = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}

-(void)backBtnClicked{
    if (self.presentationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)R_addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags{
    NSMutableArray* items = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString* imageName in imageNames) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        btn.imageEdgeInsets = isLeft ? UIEdgeInsetsMake(0, -10, 0, 10) : UIEdgeInsetsMake(0, 10, 0, -10);
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.tag = [tags[i++] integerValue];
        
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

-(void)R_AddNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags{
    NSMutableArray* items = [NSMutableArray array];
    //调整按钮位置
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -10;
    [items addObject:spaceItem];
    
    NSInteger i = 0;
    for (NSString* title in titles) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(16);
        [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        btn.tag = [tags[i++] integerValue];
        [btn sizeToFit];
        
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

#pragma mark - 取消请求
-(void)cancelRequest{
    
}

-(void)dealloc{
    [self cancelRequest];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
