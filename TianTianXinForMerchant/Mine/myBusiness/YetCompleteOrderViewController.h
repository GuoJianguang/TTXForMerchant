//
//  YetCompleteOrderViewController.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"

@interface YetCompleteOrderViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *markImage;

- (IBAction)selectTime:(id)sender;



@end
