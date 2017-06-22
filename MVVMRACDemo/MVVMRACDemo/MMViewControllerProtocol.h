//
//  MMViewControllerProtocol.h
//  MVVMRACDemo
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMViewModelProtocol;

@protocol MMViewControllerProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <MMViewModelProtocol>)viewModel;


/**
 绑定viewModel
 */
-(void)mmBindViewModel;

/**
 添加视图
 */
-(void)mmAddSubviews;

/**
 获取数据
 */
-(void)mmGetNewData;

/**
 设置导航条
 */
-(void)mmSetNavigation;


//- (void)yd_addSubviews;
//- (void)yd_bindViewModel;
//- (void)yd_getNewData;
//- (void)yd_layoutNavigation;
//- (void)recoverKeyboard;


@end
