//
//  AssociatedOrederTableViewCell.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "WaitCollectionTableViewCell.h"
@implementation WaitCollectionModel
+ (id)modelWithDic:(NSDictionary *)dic
{
    WaitCollectionModel *model = [[WaitCollectionModel alloc]init];
    model.mchName = NullToSpace(dic[@"mchName"]);
    model.pic = NullToSpace(dic[@"pic"]);
    model.tranTime = NullToSpace(dic[@"tranTime"]);
    model.userPhone = NullToSpace(dic[@"userPhone"]);
    model.state = NullToSpace(dic[@"state"]);
    model.totalAmount = [NullToNumber(dic[@"totalAmount"]) doubleValue];
    model.cashAmount = [NullToNumber(dic[@"cashAmount"]) doubleValue];
    model.balanceAmount = [NullToNumber(dic[@"balanceAmount"]) doubleValue];
    model.incomeDesc = NullToSpace(dic[@"incomeDesc"]);
    model.payType = NullToNumber(dic[@"payType"]);
    model.amountDesc = NullToSpace(dic[@"amountDesc"]);
    return model;
}

@end
@implementation OnlineAccountIn

+ (id)modelWithDic:(NSDictionary *)dic
{
    OnlineAccountIn *model = [[OnlineAccountIn alloc]init];
    model.orderId = NullToNumber(dic[@"orderId"]);
    model.goodsId = NullToNumber(dic[@"goodsId"]);
    model.goodsName = NullToNumber(dic[@"goodsName"]);
    model.goodsImage = NullToNumber(dic[@"goodsImage"]);
    model.income = NullToNumber(dic[@"income"]);
    model.receiptPeople = NullToNumber(dic[@"receiptPeople"]);
    model.phone = NullToNumber(dic[@"phone"]);
    model.time = NullToSpace(dic[@"time"]);
    return model;
}

@end


@implementation WaitCollectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.itemView.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.itemView.layer.cornerRadius = 8;
    self.itemView.layer.masksToBounds = YES;
    
    self.status.layer.cornerRadius = 5;
    self.status.layer.borderWidth = 1;
    self.status.layer.borderColor = MacoColor.CGColor;
    self.status.textColor = MacoColor;
    
    self.headImage.backgroundColor = [UIColor cyanColor];
    self.headImage.layer.cornerRadius = self.headImage.bounds.size.width/2.;
    self.headImage.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(WaitCollectionModel *)dataModel
{
    _dataModel = dataModel;
    switch ([_dataModel.payType integerValue]) {
        case 0:
            self.storeName.text = @"余额支付";
//            if (_dataModel.balanceAmount != 0 && _dataModel.cashAmount ==0) {
//                self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元(账户扣除金额%.2f元)",_dataModel.totalAmount ,_dataModel.balanceAmount];
//            }else if (_dataModel.balanceAmount== 0 && _dataModel.cashAmount!=0){
//                self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元(现金%.2f元)",_dataModel.totalAmount ,_dataModel.cashAmount ];
//            }else if (_dataModel.balanceAmount  != 0 && _dataModel.cashAmount!=0){
//                self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元(账户扣款%.2f元+现金%.2f元)",_dataModel.totalAmount,_dataModel.balanceAmount,_dataModel.cashAmount];
//            }
//            self.shouldInMoney.text = [NSString stringWithFormat:@"应入账金额%.2f元",_dataModel.balanceAmount];
            break;
        case 1:
            self.storeName.text = @"微信支付";
//            self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元(微信支付%.2f元)",_dataModel.totalAmount ,_dataModel.totalAmount ];
//
//            self.shouldInMoney.text = [NSString stringWithFormat:@"应入账金额%.2f元",_dataModel.totalAmount];

            break;
            
        default:
            break;
    }
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:LoadingErrorImage];
    self.shouldInMoney.text = _dataModel.incomeDesc;
    self.detail.text = _dataModel.amountDesc;
    self.phone.text = [NSString stringWithFormat:@"消费者电话:%@",_dataModel.userPhone];
    self.time.text = _dataModel.tranTime;

}

- (void)setOnLineModel:(OnlineAccountIn *)onLineModel
{
    _onLineModel = onLineModel;
    self.storeName.text = _onLineModel.goodsName;
    self.detail.text = [NSString stringWithFormat:@"消费者:%@",_onLineModel.receiptPeople];
    self.shouldInMoney.text = [NSString stringWithFormat:@"应入账金额%.2f元",[_onLineModel.income doubleValue]];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_onLineModel.goodsImage] placeholderImage:LoadingErrorImage];
    
    self.phone.text = [NSString stringWithFormat:@"消费者电话:%@",_onLineModel.phone];

    self.time.text = _onLineModel.time;

}

@end
