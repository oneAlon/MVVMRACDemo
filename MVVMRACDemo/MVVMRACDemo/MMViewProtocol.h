//
//  MMViewProtocol.h
//  MVVMRACDemo
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMViewModelProtocol;


@protocol MMViewProtocol <NSObject>
@optional

/**
 绑定viewModel
 */
- (void)mmBindViewModel:(id<MMViewModelProtocol>)viewModel;

/**
 初始化子view
 */
- (void)mmSetupViews;

@end
