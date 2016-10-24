//
//  AssociatedOrederTableViewCell.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AssociatedOrederModel : BaseModel
//订单总金额
@property (nonatomic, assign)double totalAmount;
//商户名称
@property (nonatomic, copy)NSString *mchName;
//商户封面图
@property (nonatomic, copy)NSString *pic;
//状态中文描述
@property (nonatomic, copy)NSString *stateDesc;
//交易时间
@property (nonatomic, copy)NSString *tranTime;
//消费者电话
@property (nonatomic, copy)NSString *userPhone;

//现金支付
@property (nonatomic, assign)double cashAmount;

//余额支付
@property (nonatomic, assign)double balanceAmount;
//订单状态,0(未支付) 1、2(已完成)3(已冻结) 4(人工审核)5(已取消)
@property (nonatomic, copy)NSString *state;

@property(nonatomic, copy)NSString *payType;

@property (nonatomic, copy)NSString *channel;
//运费
@property (nonatomic, copy)NSString *freight;


@end

@interface AssociatedOrederTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *itemView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *storeName;

@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UILabel *detail;

@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *time;


@property (nonatomic, strong)AssociatedOrederModel *dataModel;


@end
