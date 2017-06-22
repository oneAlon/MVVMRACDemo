//
//  MMBookViewController.m
//  MVVMRACDemo
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 lifepay. All rights reserved.
//

#import "MMBookViewController.h"
#import "MMBookViewModel.h"
#import "MMBookCell.h"

@interface MMBookViewController ()<UITableViewDelegate, UITableViewDataSource>
/** viewModel*/
@property (nonatomic ,strong) MMBookViewModel *viewModel;
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MMBookViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewBackGroundColor;
    [self addSubviews];
    [self bindViewModel];
}

-(void)addSubviews
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - 信号绑定
-(void)bindViewModel
{
    // 加载数据
    [self.viewModel.loadDataSignal execute:nil];
    
    // 刷新UI
    [self.viewModel.refreshUISignal subscribeNext:^(id x) {
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableView reloadData];
       });
    }];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.datasourceOfCellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMBookCell *cell = (MMBookCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MMBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.cellViewModel = self.viewModel.datasourceOfCellArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell点击
    [self.viewModel.cellClickSignal sendNext:@(indexPath.row)];
}

#pragma mark - 懒加载
/** viewModel*/
-(MMBookViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[MMBookViewModel alloc] init];
    }
    return _viewModel;
}

@end
