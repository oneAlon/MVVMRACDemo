//
//  MMViewController.m
//  MVVMRACDemo
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import "MMViewController.h"

@implementation MMViewController

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    MMViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController);
        [viewController mmAddSubviews];
        [viewController mmBindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewController);
        [viewController mmGetNewData];
    }];
    
    return viewController;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 绑定viewModel
 */
-(void)mmBindViewModel
{
    
}

/**
 添加视图
 */
-(void)mmAddSubviews
{
    
}

/**
 获取数据
 */
-(void)mmGetNewData
{
    
}

/**
 设置导航条
 */
-(void)mmSetNavigation
{
    
}
@end
