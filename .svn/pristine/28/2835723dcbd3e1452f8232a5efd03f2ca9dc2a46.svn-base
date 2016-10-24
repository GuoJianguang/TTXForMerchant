//
//  PayQrCodeViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/7/19.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "PayQrCodeViewController.h"
#import "MyQrCodeView.h"


@interface PayQrCodeViewController ()<UITextFieldDelegate>

@end

@implementation PayQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"收款";
    self.sureBtn.backgroundColor = MacoColor;
    self.sureBtn.layer.cornerRadius = 20.;
    self.sureBtn.layer.masksToBounds = YES;
    self.moneyTF.delegate = self;
    self.view.backgroundColor =  [UIColor colorWithRed:241/255. green:247/255. blue:247/255. alpha:1.];
    
    
}

#pragma mark - 生成二维码点击事件
- (IBAction)sureBtn:(UIButton *)sender {
    
    [self.moneyTF resignFirstResponder];
    if (![TTXUserInfo shareUserInfos].currentLogined) {
        //判断是否先登录
        UINavigationController *navc = [LoginViewController controller];
        [self presentViewController:navc animated:YES completion:NULL];
        return;
    }
    if ([self.moneyTF.text isEqualToString:@""] ||[self.moneyTF.text doubleValue] ==0) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入正确的金额" duration:2.];
        return;
    }
    
    NSInteger width = (TWitdh - 100)*0.8;
    NSDictionary *parms = @{@"tranAmount":self.moneyTF.text,
                            @"width":@(width),
                            @"height":@(width),
                            @"mchCode":self.dataModel.code};
    [SVProgressHUD showWithStatus:@"正在生成二维码" maskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [self defaultManager];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parms];
    NSString *url = [NSString stringWithFormat:@"%@%@",HttpClient_BaseUrl,@"qrCode/mch/generate"];
    [manager POST:url parameters:mutalbleParameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        UIImage *image = [[UIImage alloc]initWithData:responseObject];
        MyQrCodeView *qrCodeView = [[MyQrCodeView alloc]init];
        qrCodeView.qrImage = image;
        [self.navigationController.view addSubview:qrCodeView];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        [qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.navigationController.view).insets(insets);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"图形验证码获取失败，请重试" duration:2.];
        sender.enabled = YES;
    }];
}

-(AFHTTPRequestOperationManager*) defaultManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.stringEncoding = RequestSerializerEncoding;
    requestSerializer.timeoutInterval = TimeoutInterval;
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.stringEncoding = ResponseSerializerEncoding;
    
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = responseSerializer;
    
    return manager;
}


#pragma mark - 现在输金额只能为数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSScanner      *scanner    = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers;
    NSRange         pointRange = [textField.text rangeOfString:@"."];
    
    if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
    {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
    else
    {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    
    if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] )
    {
        return NO;
    }
    
    short remain = 2; //默认保留2位小数
    
    NSString *tempStr = [textField.text stringByAppendingString:string];
    NSUInteger strlen = [tempStr length];
    if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
        if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
            return NO;
        }
        if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
            return NO;
        }
    }
    
    NSRange zeroRange = [textField.text rangeOfString:@"0"];
    if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
        if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
            textField.text = string;
            return NO;
        }else{
            if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                if([string isEqualToString:@"0"]){
                    return NO;
                }
            }
        }
    }
    NSString *buffer;
    if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) )
    {
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.moneyTF resignFirstResponder];
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
