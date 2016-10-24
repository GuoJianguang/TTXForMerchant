//
//  MallOrderModel.h
//  tiantianxin
//
//  Created by ttx on 16/4/15.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseModel.h"

@interface MallOrderModel : BaseModel

/**
 * 订单id
 */

@property (nonatomic, copy)NSString *orderId;
/**
 * 商品id
 */


@property (nonatomic, copy)NSString *goodsId;
/**
 * 商品名称
 */

@property (nonatomic, copy)NSString *goodsName;
/**
 * 商品封面图
 */

@property (nonatomic, copy)NSString *goodsImage;
/**
 * 总金额
 */

@property (nonatomic, copy)NSString *totalPrice;
/**
 * 时间 yyy.MM.dd HH:mm
 */

@property (nonatomic, copy)NSString *time;
/**
 * 收货人
 */


@property (nonatomic, copy)NSString *receiptPeople;

/**
 * 收货人地址
 */

@property (nonatomic, copy)NSString *receiptAddress;

/**
 * 收货人电话
 */

@property (nonatomic, copy)NSString *receiptPhone;

/**
 * 数量
 */

@property (nonatomic, copy)NSString *quantity;
/**
 * 规格
 */

@property (nonatomic, copy)NSString *specStr;




@end
