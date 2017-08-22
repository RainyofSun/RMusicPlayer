//
//  M_MineView.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/2.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_MineView.h"
#import "M_TableView.h"

@interface M_MineView ()

/** 登录状态 */
@property (nonatomic,strong) UILabel *loginStatus;
/** 头像 */
@property (nonatomic,strong) UIImageView *headImg;
/** 我的资料 */
@property (nonatomic,strong) M_TableView *tableView;

@end

@implementation M_MineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
    }
    return self;
}

-(void)setUserLoginStatus:(LoginStatusType)userLoginStatus{
    switch (userLoginStatus) {
        case LoginStatusType_Logined:
            self.loginStatus.hidden = YES;
            self.tableView.hidden = NO;
            self.loginStatus.text = @"已登陆";
            break;
        case LoginStatusType_Unlogin:
            self.loginStatus.hidden = NO;
            self.tableView.hidden = YES;
            self.loginStatus.text = @"未登录";
            break;
        default:
            break;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.loginStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
}

#pragma mark - getter
-(UILabel *)loginStatus{
    if (!_loginStatus) {
        _loginStatus = [[UILabel alloc] init];
        _loginStatus.textAlignment = NSTextAlignmentCenter;
        _loginStatus.hidden = YES;
        [self addSubview:_loginStatus];
    }
    return _loginStatus;
}

-(UIImageView *)headImg{
    if (!_headImg) {
        _headImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headImg"]];
        _headImg.layer.cornerRadius = 40;
        _headImg.layer.masksToBounds = YES;
        [self addSubview:_headImg];
    }
    return _headImg;
}

-(M_TableView *)tableView{
    if (!_tableView) {
        _tableView = [[M_TableView alloc] initWithFrame:CGRectMake(0, 150, KScreenWidth/13*7, KScreenHeight - 150) style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
