//
//  JiesuanPayViewController.h
//  TianTianXinForMerchant
//
//  Created by Guo on 16/8/29.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"
#import "MyWallectCollectionViewCell.h"

@interface JiesuanPayViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *infoView;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UILabel *jiesuanMoeny;
@property (weak, nonatomic) IBOutlet UILabel *poundage;
@property (weak, nonatomic) IBOutlet UILabel *payTotalMoney;
- (IBAction)sureBtn:(id)sender;


@property (nonatomic, strong)AssociateJissuanModel *dataModel;

@end
