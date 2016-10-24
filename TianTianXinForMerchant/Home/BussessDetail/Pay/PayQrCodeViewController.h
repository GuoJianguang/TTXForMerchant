//
//  PayQrCodeViewController.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/7/19.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"
#import "BussessDetailModel.h"

@interface PayQrCodeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *moneyTF;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)sureBtn:(UIButton *)sender;

//商户code
@property (nonatomic, strong)BussessDetailModel *dataModel;

@end
