//
//  DeliveryTableViewCell.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/4/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallOrderModel;

@interface DeliveryTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *shippingView;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *shiipingPerson;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *phone;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIView *orderView;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *orderImage;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderDetail;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *time;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderPrice;

@property (weak, nonatomic) IBOutlet UIView *logisticsView;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *noLogisticsBtn;

- (IBAction)noLogisticsBtn:(UIButton *)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *selectLogBtn;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderName;



- (IBAction)selectLogBtn:(UIButton *)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *logisticsTF;
- (IBAction)seletctBtn:(UIButton *)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *noLoginsticsLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *loginsticsLabel;


- (IBAction)sureBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *selectBtn;


@property (unsafe_unretained, nonatomic) IBOutlet UILabel *awbLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *awbTF;




@property (nonatomic, strong)MallOrderModel *dataModel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logisticsHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logisticsNuTop;
@property (weak, nonatomic) IBOutlet UIView *otherLView;
@property (weak, nonatomic) IBOutlet UITextField *otherLNameTF;

@property (weak, nonatomic) IBOutlet UILabel *ohterLabel;


@end
