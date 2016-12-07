//
//  WaitSendMchTableViewCell.m
//  tiantianxin
//
//  Created by ttx on 16/4/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "WaitSendMchTableViewCell.h"
#import "DeliveryViewController.h"

@interface WaitSendMchTableViewCell()<UITextFieldDelegate>

@end

@implementation WaitSendMchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.itemView.backgroundColor = [UIColor whiteColor];
    self.mchDetailView.backgroundColor = [UIColor whiteColor];
//    self.mchName.adjustsFontSizeToFitWidth = YES;
    
    self.remindBtn.layer.cornerRadius = 4;
    self.remindBtn.layer.borderWidth = 0.5;
    self.remindBtn.layer.borderColor = MacoDetailColor.CGColor;
    
    self.mchName.textColor = MacoTitleColor;
    self.mchStatus.textColor = MacoColor;
    self.mchDetail.textColor = MacoDetailColor;
    
    self.itemView.layer.cornerRadius = 5;
    self.itemView.layer.masksToBounds = YES;
    
    [self.remindBtn setTitleColor:MacoDetailColor forState:UIControlStateNormal];
    
    self.mchImage.layer.cornerRadius = self.mchImage.bounds.size.width/2;
    self.mchImage.layer.masksToBounds = YES;
    

}


- (void)setDataModel:(MallOrderModel *)dataModel
{
    _dataModel = dataModel;
    [self.mchImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.goodsImage] placeholderImage:LoadingErrorImage];
    self.mchName.text = _dataModel.goodsName;
    self.mchStatus.text = [NSString stringWithFormat:@"收货人：%@",_dataModel.receiptPeople];
    self.mchDetail.text = [NSString stringWithFormat:@"规格：%@/数量：%@",_dataModel.specStr,_dataModel.quantity];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_dataModel.time];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"￥ %.2f",[_dataModel.totalPrice doubleValue]];

}


- (void)setOrderType:(MallOrderRequetstType)orderType
{
    _orderType = orderType;
    
    switch (_orderType) {
        case MallOrderRequetst_waitFahuo:
        {
            [self.remindBtn setTitle:@"去发货" forState:UIControlStateNormal];
            [self.remindBtn setTitleColor:MacoColor forState:UIControlStateNormal];
            self.remindBtn.layer.borderColor = MacoColor.CGColor;
            self.remindBtn.enabled = YES;
        }
            break;
        case MallOrderRequetst_yetComplete:
        {
            [self.remindBtn setTitle:@"已完成" forState:UIControlStateNormal];
            [self.remindBtn setTitleColor:MacoColor forState:UIControlStateNormal];
            self.remindBtn.layer.borderColor = MacoColor.CGColor;
            self.remindBtn.enabled = NO;
        }
            break;
        case MallOrderRequetst_yetFahuo:
        {
            self.remindBtn.enabled = NO;
            [self.remindBtn setTitle:@"已发货" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (IBAction)remindBtn:(UIButton *)sender {
    DeliveryViewController *deliverVC = [[DeliveryViewController alloc]init];
    deliverVC.dataModel = self.dataModel;
    [self.viewController.navigationController pushViewController:deliverVC animated:YES];
    
}
@end
