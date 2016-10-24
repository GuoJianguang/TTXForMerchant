//
//  OrderEntryTableViewCell.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/3/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderEntryViewController.h"

@interface OrderEntryTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *alerLabel;


@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

- (IBAction)scanBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *orderMoneyTF;

@property (weak, nonatomic) IBOutlet UITextField *yueMoneyTF;
- (IBAction)sureBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *cashLabel;

@property (weak, nonatomic) IBOutlet UIView *timeView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sureBtnTop;

@property (weak, nonatomic) IBOutlet UILabel *lastDayLabel;

- (IBAction)isSelectBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *isSelectBtn;


@end
