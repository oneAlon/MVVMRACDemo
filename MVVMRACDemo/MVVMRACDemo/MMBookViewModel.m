//
//  MMBookViewModel.m
//  MVVMRACDemo
//
//  Created by 王亚龙 on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import "MMBookViewModel.h"
#import "MMCellViewModel.h"
#import <MJExtension.h>

@implementation MMBookViewModel
-(instancetype)init
{
    if (self = [super init]) {
        [self initCommand];
    }
    return self;
}

-(void)initCommand
{
    NSLog(@"viewmodel被加载了...");
    self.loadDataSignal = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.douban.com/v2/book/search?q=%22%E7%BE%8E%E5%A5%B3%22"]];
            [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
                [subscriber sendNext:resultDictionary];
                [subscriber sendCompleted];
            }] resume];
            return nil;
        }];
    }];
    
    [self.loadDataSignal.executionSignals.switchToLatest subscribeNext:^(NSDictionary *x) {
        // 接收到网络请求的数据
        NSLog(@"%@",x[@"books"]);
        self.datasourceOfCellArray = [MMCellViewModel mj_objectArrayWithKeyValuesArray:x[@"books"]];
        // 刷新UI信号,发送数据
        [self.refreshUISignal sendNext:self.datasourceOfCellArray];
    }];
    
    [[self.loadDataSignal.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue]) {
            NSLog(@"登录中");
        }else {
            NSLog(@"登录成功");
        }
    }];
    
    [self.cellClickSignal subscribeNext:^(id x) {
        
       NSLog(@"%@",x);
    }];
}

#pragma mark - 懒加载
-(RACSubject *)refreshUISignal{
    if (!_refreshUISignal) {
        _refreshUISignal = [RACSubject subject];
    }
    return _refreshUISignal;
}

-(RACSubject *)cellClickSignal{
    if (!_cellClickSignal) {
        _cellClickSignal = [RACSubject subject];
    }
    return _cellClickSignal;
}

- (NSMutableArray *)datasourceOfCellArray{
    if (!_datasourceOfCellArray) {
        _datasourceOfCellArray = [[NSMutableArray alloc] init];
    }
    return _datasourceOfCellArray;
}

@end
