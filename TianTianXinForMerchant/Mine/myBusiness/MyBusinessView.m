//
//  MyBusinessView.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/22.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyBusinessView.h"
#import "MyWalletTableViewCell.h"
#import "WaitCollectionViewController.h"
#import "YetCompleteOrderViewController.h"
#import "OrderEntryViewController.h"
#import "StoreJiesuanViewController.h"
#import "MallOrderViewController.h"



@interface MyBusinessView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *datasouceArray;

@end

@implementation MyBusinessView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"MyBusinessView" owner:nil options:nil][0];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.backgroundColor = MacoGrayColor;
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)updataInfo
{
    [self awakeFromNib];
}

- (void)awakeFromNib {
    NSDictionary *dic1 = @{@"titel":@"待收款订单",@"image_name":@"iconfont-xiaofeijilu",@"count":@"0"};
    MyWalletViewModel *model1 = [MyWalletViewModel dataWithDic:dic1];
    NSDictionary *dic2 = @{@"titel":@"已完成订单",@"image_name":@"icon_completed",@"count":@"0"};
    MyWalletViewModel *model2 = [MyWalletViewModel dataWithDic:dic2];
    NSDictionary *dic3 = @{@"titel":@"订单录入",@"image_name":@"icon_order-entry",@"count":@"0"};
    MyWalletViewModel *model3 = [MyWalletViewModel dataWithDic:dic3];

    NSDictionary *dic4 = @{@"titel":@"结算统计",@"image_name":@"icon_settlementof-statistical",@"count":@"0"};
    MyWalletViewModel *model4 = [MyWalletViewModel dataWithDic:dic4];
    
    NSDictionary *dic5 = @{@"titel":@"商城订单",@"image_name":@"icon_Mall-order",@"count":[NSString stringWithFormat:@"%ld",[[TTXUserInfo shareUserInfos].waitDeliverCount integerValue] + [[TTXUserInfo shareUserInfos].hasDeliveredCount integerValue] + [[TTXUserInfo shareUserInfos].shopCompleteCount integerValue]]};
    MyWalletViewModel *model5 = [MyWalletViewModel dataWithDic:dic5];
    self.datasouceArray = [NSMutableArray arrayWithArray:@[model2,model3,model4,model5]];
    
    [self.tableView reloadData];
}


- (NSMutableArray *)datasouceArray
{
    if (!_datasouceArray) {
        _datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}


#pragma mark - UITableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasouceArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyWalletTableViewCell *cell = (MyWalletTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[MyWalletTableViewCell indentify]];
    if (!cell) {
        cell = [MyWalletTableViewCell newCell];
    }
    cell.layer.cornerRadius = 8;
    cell.dataModel = self.datasouceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 10:
        {
            WaitCollectionViewController *waitVC = [[WaitCollectionViewController alloc]init];
            [self.viewController.navigationController pushViewController:waitVC animated:YES];
        }
            break;
        case 0:
        {
            YetCompleteOrderViewController *YetVC = [[YetCompleteOrderViewController alloc]init];
            [self.viewController.navigationController pushViewController:YetVC animated:YES];
        }
            break;
        case 1:
        {
            OrderEntryViewController *orderenterVC = [[OrderEntryViewController alloc]init];
            [self.viewController.navigationController pushViewController:orderenterVC animated:YES];
        }
            break;
        case 2:
        {
            StoreJiesuanViewController *jiesuanVC = [[StoreJiesuanViewController alloc]init];
            [self.viewController.navigationController pushViewController:jiesuanVC animated:YES];
        }
            break;
        case 3:
        {
            MallOrderViewController *mallVC = [[MallOrderViewController alloc]init];
            mallVC.orderType = MallOrderRequetst_yetComplete;
            [self.viewController.navigationController pushViewController:mallVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
