//
//  EditPasswordViewController.m
//  天添薪
//
//  Created by ttx on 16/1/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "EditPasswordViewController.h"
#import "Verify.h"

@interface EditPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) NSTimer *timer;


@end

@implementation EditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.naviBar.title = @"修改密码";
//    [self setViewLayer:self.oldPassword_view];
//    [self setViewLayer:self.password_view];
//    [self setViewLayer:self.surePassword_view];
    
    self.sure_view.layer.cornerRadius = self.sure_view.bounds.size.height/2;
    self.sure_view.layer.masksToBounds = YES;
    
//    [TTXUserInfo setjianpianColorwithView:self.sure_view withWidth:self.sure_view.bounds.size.width withHeight:self.sure_view.bounds.size.height];
    self.pasword_tf.delegate = self;
    self.surePassword_tf.delegate = self;
    self.pasword_tf.delegate = self;
    
    self.verifBtn.layer.cornerRadius = 3;
    self.verifBtn.layer.borderWidth = 1;
    self.verifBtn.layer.borderColor = MacoDetailColor.CGColor;
    [self.verifBtn setTitleColor:MacoDetailColor forState:UIControlStateNormal];
    
}


- (void)setViewLayer:(UIView *)view
{
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
}


-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.oldPassword_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入旧密码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.pasword_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入新密码" duration:1.];
        return NO;
    }else if (self.pasword_tf.text.length<6 || self.pasword_tf.text.length > 18){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的密码必须在6-18位之间" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.surePassword_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请重复新密码" duration:1.];
        return NO;
    }else if (![self.pasword_tf.text isEqualToString:self.surePassword_tf.text]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"两次输入的密码不一致" duration:1.];
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


#pragma mark - 确认修改密码

- (IBAction)sure_btn:(UIButton *)sender {
    if ([self valueValidated]) {
        NSString *oldPassword = [[NSString stringWithFormat:@"%@%@",self.oldPassword_tf.text,PasswordKey]md5_32];
        NSString *newPassword = [[NSString stringWithFormat:@"%@%@",self.pasword_tf.text,PasswordKey]md5_32];
        
        [SVProgressHUD showWithStatus:@"正在提交请求..."];
        NSDictionary *parms = @{@"oldPassword":oldPassword,
                                @"token":[TTXUserInfo shareUserInfos].token,
                                @"newPassword":newPassword,
                                @"verifyCode":self.verif_tf.text};
        [HttpClient POST:@"mch/updatePassword" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                //设置用户信息
                [[JAlertViewHelper shareAlterHelper]showTint:@"修改成功" duration:1.5];
                [[NSUserDefaults standardUserDefaults]setObject:self.pasword_tf.text forKey:LoginUserPassword];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
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


- (IBAction)verifBtn:(UIButton *)sender {
    NSString *phone= [[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName];
    NSDictionary *prams = @{@"phone":phone};
    [HttpClient POST:@"sms/sendMchModifyPwdCode" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
                if (IsRequestTrue) {
                    [self.verifBtn setTitle:@"重新获取(60)" forState:UIControlStateNormal];
                    self.verifBtn.enabled = NO;
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeLeft:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];
}
#pragma mark - 验证码计时器
static int timeLefted = 60;
-(void) timeLeft:(NSTimer*) timer {
    
    timeLefted--;
    if (timeLefted == 0) {
        [self verifyButtonNormal];
        return;
    }
    
    NSString *title = [NSString stringWithFormat:@"重新获取(%d)",timeLefted];
    self.verifBtn.titleLabel.text = title;
    [self.verifBtn setTitle:title forState:UIControlStateNormal];
    
}

-(void) verifyButtonNormal {
    [self.timer invalidate];
    timeLefted = 60;
    [self.verifBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.verifBtn.enabled = YES;
}


@end
