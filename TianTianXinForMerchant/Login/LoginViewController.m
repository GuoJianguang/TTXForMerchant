
//
//  LoginViewController.m
//  天添薪
//
//  Created by ttx on 16/1/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPasswordViewController.h"


@interface LoginViewController ()<UIAlertViewDelegate,UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.naviBar.hidden = YES;
    self.user_tf.delegate = self;
    
    CGFloat height = (TWitdh - 80)*(1/6.)/2;
    self.password_view.layer.cornerRadius = height;
    self.user_view.layer.cornerRadius = height;
    self.login_view.layer.cornerRadius = height;
    self.login_view.layer.masksToBounds = YES;
    self.user_view.layer.borderWidth = 0;
    self.user_view.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.user_view sendSubviewToBack:self.usernameImage];
    [self.password_view sendSubviewToBack:self.passwordImage];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:IsFirstLaunch]) {
        self.cancelBtn.hidden = YES;
    }
    self.cancelBtn.hidden = YES;

    if ([[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName]) {
        self.user_tf.text = [[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName];
    }
//    self.user_tf.text = @"18615752084";
//    self.password_tf.text = @"1";
    [self setLoginConrest];
    
}

- (void)setLoginConrest
{
    self.logHeight.constant = THeight*(252/1334.) - 20;
    self.usertop.constant = THeight*(116/1334.);
    self.passwordTop.constant = THeight*(40/1334.);
    self.loginTop.constant = THeight*(15/1334.);
    if (THeight == 480) {
        self.logHeight.constant = 35;
        self.usertop.constant = 20;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 登录操作
- (IBAction)login_btn:(UIButton *)sender {
    [self.user_tf resignFirstResponder];
    [self.password_tf resignFirstResponder];
    if ([self valueValidated]) {
        [SVProgressHUD showWithStatus:@"正在登录..."];
     //登录接口请求操作
        NSString *password = [[NSString stringWithFormat:@"%@%@",self.password_tf.text,PasswordKey]md5_32];
        
        NSDictionary *parms = @{@"phone":self.user_tf.text,
                                @"deviceToken":[TTXUserInfo shareUserInfos].devicetoken,
                                @"deviceType":@"ios",
                                @"password":password};
        [HttpClient POST:@"mch/login" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                //设置用户信息
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [[NSUserDefaults standardUserDefaults]setObject:self.user_tf.text forKey:LoginUserName];
                [[NSUserDefaults standardUserDefaults]setObject:self.password_tf.text forKey:LoginUserPassword];
                [[NSUserDefaults standardUserDefaults]setObject:self.password_tf.text forKey:LoginUserPassword];
                [TTXUserInfo shareUserInfos].currentLogined = YES;
                [[TTXUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
                //记录商户号
                [[NSUserDefaults standardUserDefaults]setObject:[TTXUserInfo shareUserInfos].code forKey:MyBussinssCode];
                
                //统计新增用户
                [MobClick profileSignInWithPUID:[TTXUserInfo shareUserInfos].userid];
                [[NSUserDefaults standardUserDefaults]synchronize];

                if (![[NSUserDefaults standardUserDefaults]objectForKey:IsFirstLaunch]) {
                    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:IsFirstLaunch];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"Home"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:IsFirstLaunch];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [self presentViewController:[UIApplication sharedApplication].keyWindow.rootViewController animated:YES completion:NULL];
                }else{
                    [self dismissViewControllerAnimated:YES completion:NULL];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == self.user_tf) {
        NSScanner      *scanner    = [NSScanner scannerWithString:string];
        NSCharacterSet *numbers;
        NSRange         pointRange = [textField.text rangeOfString:@"."];
        
        if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        else
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
    }

    if (textField == self.user_tf) {
        if (textField.text.length > 10 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    
    return YES;
}

-(BOOL) valueValidated {
    // 判断电话号码是否合格
     if ([self emptyTextOfTextField:self.user_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入用户名" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.password_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入密码" duration:1.];
        return NO;
    }
    return YES;
}

-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.user_tf resignFirstResponder];
    [self.password_tf resignFirstResponder];
}
#pragma mark - 获取登录界面

- (IBAction)cancelLogin:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

+ (UINavigationController *)controller
{

    return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"];

}
- (IBAction)forgetBtn:(UIButton *)sender {
    
    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetVC animated:YES];
    
//    UIAlertView *alerView  = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"请您联系客服帮助您找回密码,客服电话:4001028997,是否拨打？" delegate:self cancelButtonTitle:@"点错了" otherButtonTitles:@"拨号", nil];
//    [alerView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4001028997"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

@end
