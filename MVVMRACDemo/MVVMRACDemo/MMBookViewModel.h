//
//  MMBookViewModel.h
//  MVVMRACDemo
//
//  Created by 王亚龙 on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMCellViewModel;

@interface MMBookViewModel : NSObject
/** 加载数据Signal*/
@property (nonatomic ,strong) RACCommand *loadDataSignal;
/** 刷新UI */
@property (nonatomic, strong) RACSubject *refreshUISignal;
/** cell点击 */
@property (nonatomic, strong) RACSubject *cellClickSignal;
/** 模型数组*/
@property (nonatomic ,strong) NSMutableArray<MMCellViewModel *> *datasourceOfCellArray;
@end
