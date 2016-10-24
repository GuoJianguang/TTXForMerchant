//
//  JiesuanPayViewController.m
//  TianTianXinForMerchant
//
//  Created by Guo on 16/8/29.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "JiesuanPayViewController.h"
#import "WeXinPayObject.h"

@interface JiesuanPayViewController ()

@end

@implementation JiesuanPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"结算支付";
    self.infoView.layer.cornerRadius = 4;
    self.infoView.layer.masksToBounds = YES;
    self.time.text = self.dataModel.settleTime;
    self.totalMoney.text = [NSString stringWithFormat:@"%.2f元",[self.dataModel.totalAmount doubleValue]];
    self.jiesuanMoeny.text = [NSString stringWithFormat:@"%.2f元",[self.dataModel.settleAmount doubleValue]];
    self.poundage.text = @"千分之六";
    self.payTotalMoney.text = [NSString stringWithFormat:@"%.2f元",[self.dataModel.settleAmount doubleValue]*1.006];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weixinPayResult:) name:WeixinPayResult object:nil];

    
}
- (IBAction)sureBtn:(id)sender {

    
    NSDictionary *prams = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"settleId":NullToSpace(self.dataModel.settleId)};
    [WeXinPayObject startWexinPay:prams];
    
}

#pragma mark - 微信支付结果回调
- (void)weixinPayResult:(NSNotification *)notification
{
    //    WXSuccess           = 0,    /**< 成功    */
    //    WXErrCodeCommon     = -1,   /**< 普通错误类型    */
    //    WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
    //    WXErrCodeSentFail   = -3,   /**< 发送失败    */
    //    WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
    //    WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
    NSString *code = notification.userInfo[@"resultcode"];
    switch ([code intValue]) {
        case WXSuccess:
        {
            [self paysuccess];
        }
            
            break;
        case WXErrCodeCommon:
            [[JAlertViewHelper shareAlterHelper]showTint:@"支付失败" duration:2.];
            
            break;
        case WXErrCodeUserCancel:
            [[JAlertViewHelper shareAlterHelper]showTint:@"您已取消支付" duration:2.];
            
            break;
        case WXErrCodeSentFail:
            [[JAlertViewHelper shareAlterHelper]showTint:@"发起支付请求失败" duration:2.];
            
            break;
        case WXErrCodeAuthDeny:
            [[JAlertViewHelper shareAlterHelper]showTint:@"微信支付授权失败" duration:2.];
            break;
        case WXErrCodeUnsupport:
            [[JAlertViewHelper shareAlterHelper]showTint:@"您未安装微信客户端,请先安装" duration:2.];
            break;
        default:
            break;
    }
}

- (void)paysuccess
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, TWitdh, THeight - 64)];
    view.backgroundColor = MacoGrayColor;
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,THeight*(120/1136.), THeight*(120/1136.))];
    image.image = [UIImage imageNamed:@"icon_success"];
    [view addSubview:image];
    image.center = CGPointMake(view.center.x, view.center.y -150);
    UILabel *label = [[UILabel alloc]init];
    [view addSubview:label];
    label.frame = CGRectMake(0,CGRectGetMaxY(image.frame) + 15, TWitdh,40);
    label.text = @"支付成功";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = MacoTitleColor;
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
