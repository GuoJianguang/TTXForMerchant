//
//  DeliveryViewController.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/4/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"
@class MallOrderModel;

@interface DeliveryViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)MallOrderModel *dataModel;

@end
