//
//  MMBookCell.m
//  MVVMRACDemo
//
//  Created by mac on 2017/6/22.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import "MMBookCell.h"
#import "MMCellViewModel.h"

@implementation MMBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellViewModel:(MMCellViewModel *)cellViewModel
{
    _cellViewModel = cellViewModel;
    self.textLabel.text = cellViewModel.title;
}

@end
