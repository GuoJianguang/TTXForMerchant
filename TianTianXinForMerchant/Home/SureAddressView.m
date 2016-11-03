//
//  SureAddressView.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/7/21.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "SureAddressView.h"

@implementation SureAddressView

- (void)awakeFromNib
{
    [self bringSubviewToFront:self.itemView];
    self.itemView.layer.cornerRadius = 6;
    self.itemView.layer.masksToBounds = YES;
    self.zuobiaoLabel.textColor = self.addressLabel.textColor= MacoDetailColor;
    self.longitude.textColor = self.latitude.textColor = self.address.textColor = MacoColor;
    [self.sureBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:MacoDetailColor forState:UIControlStateNormal];

    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SureAddressView" owner:nil options:nil][0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        self.backView.userInteractionEnabled = YES;
        [self.backView addGestureRecognizer:tap];
    }
    return self;
}

- (void)setDetailAddress:(NSString *)detailAddress
{
    _detailAddress = detailAddress;
    self.address.text = _detailAddress;
    self.longitude.text = [NSString stringWithFormat:@"经度:%.4f",[TTXUserInfo shareUserInfos].locationCoordinate.longitude];
    self.latitude.text = [NSString stringWithFormat:@"纬度:%.4f",[TTXUserInfo shareUserInfos].locationCoordinate.latitude];
    self.ItemHeight.constant = [self cellHeight:_detailAddress] + 44 + 84 + 10;
}


- (void)tapView
{
    [self removeFromSuperview];
}

- (IBAction)sureBtn:(UIButton *)sender {
    
    if (![TTXUserInfo shareUserInfos].currentLogined) {
        //判断是否先登录
        UINavigationController *navc = [LoginViewController controller];
        [self.viewController presentViewController:navc animated:YES completion:NULL];
        return;
    }
    NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"longitude":NullToNumber(@([TTXUserInfo shareUserInfos].locationCoordinate.longitude)),
                            @"latitude":NullToNumber(@([TTXUserInfo shareUserInfos].locationCoordinate.latitude))
                            };
    [SVProgressHUD showWithStatus:@"上传中" maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"mch/uploadLocation" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            [TTXUserInfo shareUserInfos].locationUploadFlag = YES;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadLocationSuccess" object:nil];
            [self removeFromSuperview];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"上传失败，请重试"];
    }];
    
}

- (CGFloat)cellHeight:(NSString *)textSting
{
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh  - 120, 0) font:[UIFont systemFontOfSize:13]];
    return size.height;
}

- (IBAction)cancelBtn:(UIButton *)sender {
    
    [self removeFromSuperview];
    
}
@end
