//
//  MyWalletView.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/18.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyWalletView.h"
#import "MyWalletTableViewCell.h"
#import "MyWalletDetailViewController.h"
#import "MyAccountInDetailViewController.h"
#import "MyAccountInNewViewController.h"



@interface MyWalletView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *datasouceArray;

@end

@implementation MyWalletView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"MyWalletView" owner:nil options:nil][0];
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
    
    NSDictionary *dic1 = @{@"titel":@"账户收入",@"image_name":@"icon_account-consumption",@"count":NullToNumber([TTXUserInfo shareUserInfos].accountCount)};
    MyWalletViewModel *model1 = [MyWalletViewModel dataWithDic:dic1];
    NSDictionary *dic2 = @{@"titel":@"账户提现",@"image_name":@"icon_account-withdrawal",@"count":NullToNumber([TTXUserInfo shareUserInfos].withdrawCount)};
    MyWalletViewModel *model2 = [MyWalletViewModel dataWithDic:dic2];

    self.datasouceArray = [NSMutableArray arrayWithArray:@[model1,model2]];
    [self.tableView reloadData];
    [HttpClient GET:@"mch/wallet" parameters:@{@"token":[TTXUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            self.moneyLabel.text = [NSString stringWithFormat:@"账户余额:￥ %@", NullToNumber(jsonObject[@"data"][@"balance"])];
            [TTXUserInfo shareUserInfos].aviableBalance = NullToNumber(jsonObject[@"data"][@"balance"]);
            NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:self.moneyLabel.text];
            [attributedString2 addAttribute:NSForegroundColorAttributeName value:MacoTitleColor range:NSMakeRange(0, 5)];
            self.moneyLabel.attributedText = attributedString2;

        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        self.moneyLabel.text = [NSString stringWithFormat:@"账户余额:￥ %@", [TTXUserInfo shareUserInfos].aviableBalance];
    }];
    

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
//            MyAccountInDetailViewController *detailVC = [[MyAccountInDetailViewController alloc]init];
//            [self.viewController.navigationController pushViewController:detailVC animated:YES];
            MyAccountInNewViewController *detailVC = [[MyAccountInNewViewController alloc]init];
            [self.viewController.navigationController pushViewController:detailVC animated:YES];

        }
            break;
        case 1:
        {
            MyWalletDetailViewController *detailVC = [[MyWalletDetailViewController alloc]init];
            detailVC.selectType = MYWallecttype_tixian;
            [self.viewController.navigationController pushViewController:detailVC animated:YES];

        }
            break;
        
            
        default:
            break;
    }
    
    
}

@end
