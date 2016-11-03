//
//  SureOrderView.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/3/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "SureOrderView.h"

@implementation SureOrderView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SureOrderView" owner:nil options:nil][0];
    }
    return self;
}

- (void)awakeFromNib
{
    [self sendSubviewToBack:self.backView];
    self.itemView.layer.cornerRadius = 5;
    self.itemView.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
}


- (IBAction)cancelBtn:(UIButton *)sender {
    [self removeFromSuperview];
}


- (IBAction)sureBtn:(UIButton *)sender {
    NSDictionary *pramrs = @{@"token":[TTXUserInfo shareUserInfos].token,
                             @"phone":NullToSpace(self.phoneLabel.text),
                             @"totalAmount":NullToSpace(self.balanceMoneyLabel.text),
                             @"balanceAmount":NullToSpace(self.balancePay.text),
                             @"yesterdayFlag":@(self.isYestodayOder)};
    [SVProgressHUD showWithStatus:@"正在请求..." maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"mch/business/consumeInput" parameters:pramrs success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            if ([self.delegate respondsToSelector:@selector(sureSuccess)]) {
                [self.delegate sureSuccess];
            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


@end
