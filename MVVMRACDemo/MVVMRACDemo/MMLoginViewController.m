//
//  MMLoginViewController.m
//  MVVMRACDemo
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import "MMLoginViewController.h"
#import "MMLoginViewModel.h"
#import "MMLoginView.h"
#import "MMBookViewController.h"


@interface MMLoginViewController ()
/** viewModel */
@property (nonatomic, strong) MMLoginViewModel *viewModel;
/** view */
@property (nonatomic, strong) MMLoginView *loginView;
@end

@implementation MMLoginViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewBackGroundColor;
    [self mmAddSubviews];
    [self mmBindViewModel];
}

-(void)mmAddSubviews
{
    [self.view addSubview:self.loginView];
}

#pragma mark - 信号绑定
-(void)mmBindViewModel
{
    // 登录成功
    [self.viewModel.loginSuccessSignal subscribeNext:^(id x) {
        NSLog(@"接收到请求数据:%@",x);
        MMBookViewController *bookVC = [[MMBookViewController alloc] init];
        [self presentViewController:bookVC animated:YES completion:nil];
    }];
}


#pragma mark - 懒加载
- (MMLoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MMLoginViewModel alloc] init];
    }
    return _viewModel;
}

- (MMLoginView *)loginView{
    if (!_loginView) {
        _loginView = [[MMLoginView alloc] initWithViewModel:self.viewModel];
    }
    return _loginView;
}



@end
