//
//  AssociatedOrederTableViewCell.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "AssociatedOrederTableViewCell.h"

@implementation AssociatedOrederModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    AssociatedOrederModel *model = [[AssociatedOrederModel alloc]init];
    model.totalAmount = [NullToNumber(dic[@"totalAmount"]) doubleValue];
    model.cashAmount = [NullToNumber(dic[@"cashAmount"]) doubleValue];
    model.balanceAmount = [NullToNumber(dic[@"balanceAmount"]) doubleValue];
    model.mchName = NullToSpace(dic[@"mchName"]);
    model.pic = NullToSpace(dic[@"pic"]);
    model.stateDesc =NullToSpace(dic[@"stateDesc"]);
    model.tranTime = NullToSpace(dic[@"tranTime"]);
    model.userPhone = NullToSpace(dic[@"userPhone"]);
    model.state = NullToSpace(dic[@"state"]);
    model.payType = NullToNumber(dic[@"payType"]);
    model.channel = NullToNumber(dic[@"channel"]);
    model.freight = NullToNumber(dic[@"freight"]);
    return model;
}

@end


@implementation AssociatedOrederTableViewCell

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

- (void)setDataModel:(AssociatedOrederModel *)dataModel
{
    _dataModel = dataModel;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:LoadingErrorImage];
    self.storeName.text = _dataModel.mchName;
    self.phone.text = [NSString stringWithFormat:@"消费者电话:%@",_dataModel.userPhone];
    self.time.text = _dataModel.tranTime;
    
    if (_dataModel.balanceAmount != 0 && _dataModel.cashAmount ==0) {
        self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元(账户扣除金额%.2f元)",_dataModel.totalAmount ,_dataModel.balanceAmount];
    }else if (_dataModel.balanceAmount== 0 && _dataModel.cashAmount!=0){
        self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元(现金%.2f元)",_dataModel.totalAmount ,_dataModel.cashAmount ];
    }else if (_dataModel.balanceAmount  != 0 && _dataModel.cashAmount!=0){
        self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元(账户扣款%.2f元+现金%.2f元)",_dataModel.totalAmount,_dataModel.balanceAmount,_dataModel.cashAmount];
    }
    
    if ([_dataModel.payType isEqualToString:@"1"]) {
        self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元(微信支付)",_dataModel.totalAmount];
    }
    if ([_dataModel.channel isEqualToString:@"2"]) {
        if ([_dataModel.freight isEqualToString:@"0"]) {
            self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元",_dataModel.totalAmount];
        }else{
            self.detail.text = [NSString stringWithFormat:@"订单金额%.2f元(运费%.2f)",_dataModel.totalAmount,[_dataModel.freight doubleValue]];
        }
    }
    
    
    int status  = [_dataModel.state intValue];
    switch (status) {
        case 0:
            self.status.text = @"未支付";
            self.status.textColor = MacoDetailColor;
            self.status.layer.cornerRadius = 4;
            self.status.layer.borderWidth = 1;
            self.status.layer.borderColor = MacoDetailColor.CGColor;
            break;
        case 1:
            self.status.text = @"已完成";
            self.status.textColor = MacoColor;
            self.status.layer.cornerRadius = 4;
            self.status.layer.borderWidth = 1;
            self.status.layer.borderColor = MacoColor.CGColor;
            
            break;
        case 2:
            self.status.text = @"已完成";
            self.status.textColor = MacoColor;
            self.status.layer.cornerRadius = 4;
            self.status.layer.borderWidth = 1;
            self.status.layer.borderColor = MacoColor.CGColor;
            
            break;
        case 3:
            self.status.text = @"已冻结";
            self.status.textColor = MacoDetailColor;
            self.status.layer.cornerRadius = 4;
            self.status.layer.borderWidth = 1;
            self.status.layer.borderColor = MacoDetailColor.CGColor;
            
            break;
        case 4:
            self.status.text = @"人工审核";
            self.status.textColor = MacoColor;
            self.status.layer.cornerRadius = 4;
            self.status.layer.borderWidth = 1;
            self.status.layer.borderColor = MacoColor.CGColor;
            
            break;
        case 5:
            self.status.text = @"已取消";
            self.status.textColor = MacoDetailColor;
            self.status.layer.cornerRadius = 4;
            self.status.layer.borderWidth = 1;
            self.status.layer.borderColor = MacoDetailColor.CGColor;
            
            break;
            
        default:
            break;
    }

    
}


@end
