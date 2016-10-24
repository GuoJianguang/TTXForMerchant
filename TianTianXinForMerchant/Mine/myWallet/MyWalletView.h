//
//  MyWalletView.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/18.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWalletView : UIView

- (void)updataInfo;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end
