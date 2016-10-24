//
//  myAssociatedStore.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/22.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyAssociatedStore.h"
#import "MyWalletTableViewCell.h"
#import "AssociatedOrderViewController.h"
#import "JiesuanTongJiViewController.h"


@interface MyAssociatedStore()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *datasouceArray;

@end

@implementation MyAssociatedStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"MyAssociatedStore" owner:nil options:nil][0];
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
    
    NSDictionary *dic1 = @{@"titel":@"关联店铺订单",@"image_name":@"icon_order",@"count":@"0"};
    MyWalletViewModel *model1 = [MyWalletViewModel dataWithDic:dic1];
    NSDictionary *dic2 = @{@"titel":@"结算统计",@"image_name":@"icon_settlementof-statistical",@"count":@"0"};
    MyWalletViewModel *model2 = [MyWalletViewModel dataWithDic:dic2];

    self.datasouceArray = [NSMutableArray arrayWithArray:@[model1,model2]];
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
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.layer.cornerRadius = 8;
    cell.dataModel = self.datasouceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            AssociatedOrderViewController *associateVC = [[AssociatedOrderViewController alloc]init];
            [self.viewController.navigationController pushViewController:associateVC animated:YES];
        }
            break;
        case 1:
        {
            JiesuanTongJiViewController *jiesuanVC = [[JiesuanTongJiViewController alloc]init];
            [self.viewController.navigationController pushViewController:jiesuanVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
