//
//  MMLoginViewModel.m
//  MVVMRACDemo
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import "MMLoginViewModel.h"

@implementation MMLoginViewModel

-(instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}


-(void)setup
{
    self.loginButtonEnableSignal = [RACSignal combineLatest:@[RACObserve(self, loginAccount), RACObserve(self, loginPwd)] reduce:^id(NSString *account, NSString *password){
        return @(account.length && password.length);
    }];
    
    self.loginButtonClickSignal = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"发送登录请求");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login"]];
            request.HTTPMethod = @"POST";
            NSString *paramString = [NSString stringWithFormat:@"username=%@&pwd=%@&type=JSON", self.loginAccount, self.loginPwd];
            NSData *paramData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
            request.HTTPBody = paramData;
            [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
                [subscriber sendNext:resultDictionary];
                /****************** -------- 发送完成这一步很重要, 不然后面的无法信号无法执行 -------- ******************/
                [subscriber sendCompleted];
            }] resume];
            return nil;
        }];
    }];
    
    [self.loginButtonClickSignal.executionSignals.switchToLatest subscribeNext:^(id x) {
        // 接收到网络请求的数据
        NSLog(@"%@",x);
        [self.loginSuccessSignal sendNext:x];
    }];
    
    [[self.loginButtonClickSignal.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue]) {
            NSLog(@"登录中");
        }else {
            NSLog(@"登录成功");
        }
    }];
}

-(RACSubject *)loginSuccessSignal
{
    if (!_loginSuccessSignal) {
        _loginSuccessSignal = [RACSubject subject];
    }
    return _loginSuccessSignal;
}

@end
