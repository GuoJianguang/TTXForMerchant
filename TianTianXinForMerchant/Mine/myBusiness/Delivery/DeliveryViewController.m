//
//  DeliveryViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/4/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "DeliveryViewController.h"
#import "DeliveryTableViewCell.h"
#import "MallOrderModel.h"


@interface DeliveryViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"物流填写";
    self.tableView.backgroundColor = [UIColor clearColor];
    
}





- (MallOrderModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [[MallOrderModel alloc]init];
    }
    return _dataModel;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DeliveryTableViewCell indentify]];
    if (!cell) {
        cell = [DeliveryTableViewCell newCell];
    }
    cell.dataModel = self.dataModel;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100 + 148 + 135 + 140 + 45;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
