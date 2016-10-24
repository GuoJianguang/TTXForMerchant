//
//  MallOrderViewController.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/4/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,MallOrderRequetstType){
    MallOrderRequetst_yetComplete= 3,//已完成
    MallOrderRequetst_yetFahuo = 2,//已发货
    MallOrderRequetst_waitFahuo = 1,//待发货
    
};

@class SortButtonSwitchView;

@interface MallOrderViewController : BaseViewController


@property (weak, nonatomic) IBOutlet SortButtonSwitchView *sortView;

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;



@property (nonatomic, assign)MallOrderRequetstType orderType;

@end
