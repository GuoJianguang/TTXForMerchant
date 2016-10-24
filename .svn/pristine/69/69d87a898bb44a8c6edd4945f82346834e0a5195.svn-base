//
//  BussessInfoTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BussessInfoTableViewCell.h"
#import "BussessMapViewController.h"
#import "LocationManager.h"
#import "SureAddressView.h"



@interface BussessInfoTableViewCell()

@property (nonatomic,strong)SureAddressView *sureView;

@end
@implementation BussessInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.show_view.layer.cornerRadius = 8;
    self.address_label.textColor = MacoDetailColor;
    self.titleLabel.textColor = MacoTitleColor;
    [self.getLocationBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"uploadLocationSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uploadSuccess) name:@"uploadLocationSuccess" object:nil];
}


- (void)uploadSuccess
{
    self.getLocationBtn.hidden = YES;
}

//返回重用标示
+ (NSString *)indentify
{
    return @"BussessInfoTableViewCell";
}
//创建cell

- (void)setDataModel:(BussessDetailModel *)dataModel
{
    _dataModel = dataModel;
    self.address_label.text = _dataModel.address;
    self.getLocationBtn.hidden = [TTXUserInfo shareUserInfos].locationUploadFlag;
}
- (SureAddressView *)sureView
{
    if (!_sureView) {
        _sureView = [[SureAddressView alloc]init];
        _sureView.frame = CGRectMake(0, 0, TWitdh, THeight);
    }
    return _sureView;
}


+ (id)newCell
{
    NSArray *array  = [[NSBundle mainBundle]loadNibNamed:@"BussessInfoTableViewCell" owner:nil options:nil];
    return array[0];
}

- (IBAction)call_btn:(UIButton *)sender {
    
    
    if ([_dataModel.phone isEqualToString:@""]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"这个商家没有留下联系电话" duration:1.5];
        return;
    }
    
    UIWebView *webView = (UIWebView*)[self.viewController.view viewWithTag:1000];
    if (!webView) {
        webView = [[UIWebView alloc]init];
    }
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_dataModel.phone]]]];
    [self.viewController.view addSubview:webView];    
}

- (IBAction)check_address_btn:(UIButton *)sender {
    BussessMapViewController *mapVC = [[BussessMapViewController alloc]init];
    CLLocationCoordinate2D d;
    d.latitude = [self.dataModel.latitude floatValue];
    d.longitude = [self.dataModel.longitude floatValue];
    
    if (d.longitude == 0 || d.latitude == 0) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"该商户暂时没有位置信息" duration:1.5];
        return;
    }
    mapVC.stopcoordinate = d;
    mapVC.dataModel = self.dataModel;
    [self.viewController.navigationController pushViewController:mapVC animated:YES];
}


#pragma mark - 获取坐标
- (IBAction)getLocationBtn:(UIButton *)sender {
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    [[LocationManager sharedLocationManager] startLocationWithGDManager];
    [LocationManager sharedLocationManager].finishLocation = ^(AMapLocationReGeocode *reGeocode,NSString *city,NSString *areaName,NSError *error ,BOOL success){
        [SVProgressHUD dismiss];
        if (city) {
            self.sureView.detailAddress = reGeocode.formattedAddress;
            [self.viewController.navigationController.view addSubview:self.sureView];
            
        }else{
            [[JAlertViewHelper shareAlterHelper]showTint:@"获取地址失败，请稍后重试" duration:2.];
        }
    };
 
    
}
@end
