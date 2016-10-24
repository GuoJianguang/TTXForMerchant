//
//  MallOrderModel.m
//  tiantianxin
//
//  Created by ttx on 16/4/15.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MallOrderModel.h"

@implementation MallOrderModel


+ (id)modelWithDic:(NSDictionary *)dic
{
    MallOrderModel *model = [[MallOrderModel alloc]init];
    model.orderId = NullToNumber(dic[@"orderId"]);
    model.goodsId = NullToNumber(dic[@"goodsId"]);
    model.goodsName = NullToSpace(dic[@"goodsName"]);
    model.goodsImage = NullToSpace(dic[@"goodsImage"]);
    model.totalPrice = NullToNumber(dic[@"totalPrice"]);
    model.time = NullToNumber(dic[@"time"]);
    model.receiptPeople = NullToSpace(dic[@"receiptPeople"]);
    model.receiptAddress = NullToSpace(dic[@"receiptAddress"]);
    model.receiptPhone = NullToNumber(dic[@"receiptPhone"]);
    model.quantity = NullToNumber(dic[@"quantity"]);
    model.specStr = NullToNumber(dic[@"specStr"]);
    return model;
}


@end
