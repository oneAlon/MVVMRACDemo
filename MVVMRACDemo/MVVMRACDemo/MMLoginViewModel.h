//
//  MMLoginViewModel.h
//  MVVMRACDemo
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import "MMViewModel.h"

@interface MMLoginViewModel : NSObject

/** 账号 */
@property (nonatomic, copy) NSString *loginAccount;
/** 密码 */
@property (nonatomic, copy) NSString *loginPwd;
/** 登录按钮Enable */
@property (nonatomic, strong) RACSignal *loginButtonEnableSignal;
/** 登录按钮点击 */
@property (nonatomic, strong) RACCommand *loginButtonClickSignal;
/** 登录成功Signal*/
@property (nonatomic ,strong) RACSubject *loginSuccessSignal;

@end
