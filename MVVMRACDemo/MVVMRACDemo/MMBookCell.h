//
//  MMBookCell.h
//  MVVMRACDemo
//
//  Created by mac on 2017/6/22.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMCellViewModel;

@interface MMBookCell : UITableViewCell
/** viewModel */
@property (nonatomic, strong) MMCellViewModel *cellViewModel;
@end
