//
//  AssociatedOrederTableViewCell.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

//待收款订单model
@interface WaitCollectionModel : BaseModel
//商户名称
@property (nonatomic, copy)NSString *mchName;
//商户封面图
@property (nonatomic, copy)NSString *pic;
//交易时间
@property (nonatomic, copy)NSString *tranTime;
//消费者电话
@property (nonatomic, copy)NSString *userPhone;
//订单状态,0(未支付) 1、2(已完成)3(已冻结) 4(人工审核)5(已取消)
@property (nonatomic, copy)NSString *state;
//订单总金额
@property (nonatomic, assign)double totalAmount ;
//余额支付金额
@property (nonatomic, assign)double balanceAmount ;
//现金支付金额
@property (nonatomic, assign)double cashAmount ;
//应入账金额描述
@property (nonatomic, copy)NSString *incomeDesc;

//支付类型
@property (nonatomic, copy)NSString *payType;

@property (nonatomic, copy)NSString *amountDesc;


@end

@interface OnlineAccountIn : BaseModel

@property (nonatomic, copy)NSString *orderId;
@property (nonatomic, copy)NSString *goodsId;
@property (nonatomic, copy)NSString *goodsName;
@property (nonatomic, copy)NSString *goodsImage;
@property (nonatomic, copy)NSString *income;
@property (nonatomic, copy)NSString *receiptPeople;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *time;


@end
@interface WaitCollectionTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *itemView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *storeName;

@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *shouldInMoney;

@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (nonatomic, strong)WaitCollectionModel *dataModel;


@property (nonatomic, strong)OnlineAccountIn *onLineModel;


@end
