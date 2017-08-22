//
//  M_LoginView.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/1.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_LoginView.h"

@interface M_LoginView ()

/** 用户头像 */
@property (nonatomic,strong) UIImageView *loginUserImg;
/** 输入账号 */
@property (nonatomic,strong) UITextField *loginAccount;
/** 输入密码 */
@property (nonatomic,strong) UITextField *loginPassword;
/** 登录按钮 */
@property (nonatomic,strong) UIButton *loginBtn;
/** 游客登录 */
@property (nonatomic,strong) UIButton *loginVistor;
/** 忘记密码 */
@property (nonatomic,strong) UIButton *forgetPasBtn;
/** 新用户注册 */
@property (nonatomic,strong) UIButton *registerBtn;
/** QQ登录 */
@property (nonatomic,strong) UIButton *loginQQ;
/** WX登录 */
@property (nonatomic,strong) UIButton *loginWX;
/** 分割线1 */
@property (nonatomic,strong) UIView *sepLine1;
/** 分割线2 */
@property (nonatomic,strong) UIView *sepLine2;

@end

@implementation M_LoginView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.loginAccount resignFirstResponder];
    [self.loginPassword resignFirstResponder];
}

#pragma mark - 登录点击
-(void)loginBtnClick:(UIButton*)sender{
    if (self.loginAccount.text.length == 0 || self.loginPassword.text.length == 0) {
        [MBProgressHUD showErrorMessage:@"请正确填写账号密码"];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(loginApp:)]) {
        [self.delegate loginApp:@{@"pas":self.loginPassword.text,
                                  @"acc":self.loginAccount.text}];
    }
}

#pragma mark - 游客登录---暂不登录
-(void)loginVistorMT:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(loginVistor:)]) {
        [self.delegate loginVistor:self];
    }
}

#pragma mark - 忘记密码
-(void)forgetPass:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(forgetPass:)]) {
        [self.delegate forgetPassword:self];
    }
}

#pragma mark - 新用户注册
-(void)registerBtn:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(registApp:)]) {
        [self.delegate registApp:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.loginUserImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).with.offset(-230);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    [self.loginAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).with.offset(-100);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth - 30, 40));
    }];
    
    [self.sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.bottom.left.equalTo(self.loginAccount);
        make.height.mas_equalTo(1.5);
    }];
    
    [self.loginPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginAccount.mas_bottom).with.offset(30);
        make.size.left.equalTo(self.loginAccount);
    }];
    
    [self.sepLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.loginPassword);
        make.height.mas_equalTo(1.5);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.equalTo(self.loginAccount);
        make.top.equalTo(self.loginPassword.mas_bottom).with.offset(30);
    }];
    
    [self.loginVistor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.equalTo(self.loginAccount);
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(15);
    }];
    
    [self.forgetPasBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginVistor);
        make.top.equalTo(self.loginVistor.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 15));
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginVistor);
        make.top.equalTo(self.forgetPasBtn);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
    
    [self.loginQQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(-50);
        make.centerY.equalTo(self.mas_centerY).with.offset(200);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.loginWX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(50);
        make.size.top.equalTo(self.loginQQ);
    }];
}

#pragma mark - getter
-(UIImageView *)loginUserImg{
    if (!_loginUserImg) {
        _loginUserImg = [[UIImageView alloc] init];
        _loginUserImg.backgroundColor = KClearColor;
        _loginUserImg.layer.cornerRadius = 60;
        _loginUserImg.layer.masksToBounds = YES;
        [self addSubview:_loginUserImg];
    }
    return _loginUserImg;
}

-(UITextField *)loginAccount{
    if (!_loginAccount) {
        _loginAccount = [[UITextField alloc] init];
        _loginAccount.placeholder = @"手机号/邮箱";
        _loginAccount.font = [UIFont systemFontOfSize:16];
        _loginAccount.borderStyle = UITextBorderStyleNone;
        [self addSubview:_loginAccount];
    }
    return _loginAccount;
}

-(UITextField *)loginPassword{
    if (!_loginPassword) {
        _loginPassword = [[UITextField alloc] init];
        _loginPassword.placeholder = @"密码";
        _loginPassword.secureTextEntry = YES;
        _loginPassword.font = [UIFont systemFontOfSize:16];
        _loginPassword.borderStyle = UITextBorderStyleNone;
        [self addSubview:_loginPassword];
    }
    return _loginPassword;
}

-(UIView *)sepLine1{
    if (!_sepLine1) {
        _sepLine1 = [[UIView alloc] init];
        _sepLine1.backgroundColor = KWhiteColor;
        [self addSubview:_sepLine1];
    }
    return _sepLine1;
}

-(UIView *)sepLine2{
    if (!_sepLine2) {
        _sepLine2 = [[UIView alloc] init];
        _sepLine2.backgroundColor = KWhiteColor;
        [self addSubview:_sepLine2];
    }
    return _sepLine2;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.backgroundColor = AppMainBlue;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 3;
        [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginBtn];
    }
    return _loginBtn;
}

-(UIButton *)loginVistor{
    if (!_loginVistor) {
        _loginVistor = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginVistor setTitle:@"游客登录" forState:UIControlStateNormal];
        [_loginVistor setTitleColor:KWhiteColor forState:UIControlStateNormal];
        _loginVistor.backgroundColor = AppMainBlue;
        _loginVistor.layer.cornerRadius = 3;
        [_loginVistor addTarget:self action:@selector(loginVistorMT:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginVistor];
    }
    return _loginVistor;
}

-(UIButton *)forgetPasBtn{
    if (!_forgetPasBtn) {
        _forgetPasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasBtn setTitleColor:AppMainBlue forState:UIControlStateNormal];
        _forgetPasBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _forgetPasBtn.backgroundColor = KClearColor;
        [_forgetPasBtn addTarget:self action:@selector(forgetPass:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_forgetPasBtn];
    }
    return _forgetPasBtn;
}

-(UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:AppMainBlue forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _registerBtn.backgroundColor = KClearColor;
        [_registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_registerBtn];
    }
    return _registerBtn;
}

-(UIButton *)loginQQ{
    if (!_loginQQ) {
        _loginQQ = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_loginQQ setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
        _loginQQ.backgroundColor = KClearColor;
        [self addSubview:_loginQQ];
    }
    return _loginQQ;
}

-(UIButton *)loginWX{
    if (!_loginWX) {
        _loginWX = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_loginWX setImage:[UIImage imageNamed:@"WX"] forState:UIControlStateNormal];
        _loginWX.backgroundColor = KClearColor;
        [self addSubview:_loginWX];
    }
    return _loginWX;
}

@end
