//
//  SureOrderView.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/3/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SureOrderDelegate <NSObject>

- (void)sureSuccess;

@end

@interface SureOrderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *balanceMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *balancePay;
@property (weak, nonatomic) IBOutlet UILabel *cashLabel;

- (IBAction)cancelBtn:(UIButton *)sender;


- (IBAction)sureBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *itemView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, assign)NSInteger isYestodayOder;


@property (nonatomic, assign)id<SureOrderDelegate> delegate;

@end
