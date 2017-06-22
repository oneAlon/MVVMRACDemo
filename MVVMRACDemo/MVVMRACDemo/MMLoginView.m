//
//  MMLoginView.m
//  MVVMRACDemo
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import "MMLoginView.h"
#import "MMLoginViewModel.h"

@interface MMLoginView()
/** viewModel */
@property (nonatomic, strong) MMLoginViewModel *viewModel;
/** 账号 */
@property (nonatomic, strong) UITextField *accountTextField;
/** 密码 */
@property (nonatomic, strong) UITextField *passwordTextField;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginButton;
@end

@implementation MMLoginView


-initWithViewModel:(MMLoginViewModel *)viewModel
{
    if (self = [super init]) {
        self.viewModel = viewModel;
        [self mmSetupViews];
        [self mmBindViewModel];
    }
    return self;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self mmSetupViews];
        [self mmBindViewModel];
    }
    return self;
}

/**
 绑定viewModel
 */
- (void)mmBindViewModel
{
    RAC(self.viewModel, loginAccount) = self.accountTextField.rac_textSignal;
    RAC(self.viewModel, loginPwd) = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = self.viewModel.loginButtonEnableSignal;
    // 按钮点击
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self endEditing:YES];
        [self.viewModel.loginButtonClickSignal execute:@"执行"];
    }];
}

-(void)mmSetupViews
{
    self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self setupUI];
}

-(void)setupUI
{
    _accountTextField = [self setupTextField:CGRectMake((screenWidth - 300)/2, 200, 300, 40) placeholder:@"账号"];
    _passwordTextField = [self setupTextField:CGRectMake((screenWidth - 300)/2, 280, 300, 40) placeholder:@"密码"];
    [self addSubview:_accountTextField];
    [self addSubview:_passwordTextField];
    _loginButton = [self setupLoginButton];
    [self addSubview:_loginButton];
}

-(UITextField *)setupTextField:(CGRect)frame placeholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.font = [UIFont systemFontOfSize:20];
    textField.textColor = mainColor;
    textField.placeholder = placeholder;
    textField.backgroundColor = [UIColor grayColor];
    return textField;
}

-(UIButton *)setupLoginButton
{
    UIButton *loginButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton1 setTitle:@"登录失效" forState:UIControlStateDisabled];
    [loginButton1 setTitle:@"登录可用" forState:UIControlStateNormal];
    loginButton1.frame = CGRectMake((screenWidth - 100)/2, 380, 100, 40);
    loginButton1.backgroundColor = [UIColor grayColor];
    return loginButton1;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
@end
