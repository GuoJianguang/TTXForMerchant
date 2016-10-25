//
//  WithDrawalViewController.m
//  天添薪
//
//  Created by ttx on 16/1/8.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "WithDrawalViewController.h"
#import "WithDrawalResultView.h"
#import "Verify.h"
#import "UIView+SetGradient.h"



@interface WithDrawalViewController ()<BasenavigationDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic, strong)WithDrawalResultView *resultView;


@end

@implementation WithDrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"提现";
//    self.naviBar.hiddenDetailBtn = NO;
//    self.naviBar.detailTitle = @"提现说明";
    self.naviBar.delegate = self;
    
    //账户余额
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[[TTXUserInfo shareUserInfos].aviableBalance doubleValue]];
    
    [self setViewLayer:self.editView];
    CGFloat height = (TWitdh - 80)*(1/6.)/2;
    self.sureView.layer.cornerRadius = height;
    self.sureView.layer.masksToBounds = YES;
    self.sendCodeBtn.layer.cornerRadius = 5;
    self.sendCodeBtn.layer.masksToBounds = YES;
    self.sendCodeBtn.layer.borderColor = MacoDetailColor.CGColor;
    [self.sendCodeBtn setTitleColor:MacoDetailColor forState:UIControlStateNormal];
    self.sendCodeBtn.layer.borderWidth = 1;

    
    
    
    [TTXUserInfo setjianpianColorwithView:self.showMoneyView withWidth:TWitdh withHeight:self.showMoneyView.bounds.size.height];
    [self setIsBlowCongqing];
}

- (BOOL)myContainsString:(NSString*)string and:(NSString *)otherString {
    NSRange range = [string rangeOfString:otherString];
    return range.length != 0;
}

//判断是否是重庆地区，如果是提现的部分会有一部分金额用于公益事业

- (void)setIsBlowCongqing
{   self.actualView.hidden = YES;
    self.actualViewHeight.constant = 0;
    self.alerLabel.hidden = NO;
    self.editViewHeight.constant = 101;
//    if ([self myContainsString:[TTXUserInfo shareUserInfos].province and:@"重庆"]) {
//        self.actualView.hidden = NO;
//        self.actualViewHeight.constant = 50;
//        self.alerLabel.hidden = NO;
//        self.editViewHeight.constant = 152;
//    }else{
//        self.actualView.hidden = YES;
//        self.actualViewHeight.constant = 0;
//        self.alerLabel.hidden = YES;
//        self.editViewHeight.constant = 101;
//    }
}


//限制电话号码为11位数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    
    if (textField == self.editMoneyTF) {
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
    }
    
    return YES;
}



- (WithDrawalResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[WithDrawalResultView alloc]init];
    }
    return _resultView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewLayer:(UIView *)view
{
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
}

#pragma mark - 提现说明
- (void)detailBtnClick
{
    BaseHtmlViewController *htmelVC = [[BaseHtmlViewController alloc]init];
    htmelVC.htmlTitle = @"提现说明";
    htmelVC.htmlUrl = @"http://www.tiantianxcn.com/html5/forapp/getMoney-notice.html";
    [self.navigationController pushViewController:htmelVC animated:YES];
}


- (IBAction)sendCodeBtn:(UIButton *)sender {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.editMoneyTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入提现金额" duration:1.];
        return;
    }else if ([self.moneyLabel.text doubleValue] < [self.editMoneyTF.text doubleValue]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的可提现余额不足，请重新输入" duration:1.];
        return;
    }else if ([self.editMoneyTF.text integerValue]%10 !=0){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的提现金额必须是10的整数倍" duration:1.];
        return;
    }else if ([self.editMoneyTF.text integerValue] <1000){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的提现金额不能少于1000元" duration:1.5];
        return;
    }
    [HttpClient POST:@"mch/withdraw/sendVerifyCode" parameters:@{@"token":[TTXUserInfo shareUserInfos].token} success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.sendCodeBtn setTitle:@"重新获取(60)" forState:UIControlStateNormal];
            self.sendCodeBtn.enabled = NO;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeLeft:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
    self.sendCodeBtn.titleLabel.text = title;
    [self.sendCodeBtn setTitle:title forState:UIControlStateNormal];
    
}


-(void) verifyButtonNormal {
    [self.timer invalidate];
    timeLefted = 60;
    [self.sendCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.sendCodeBtn.enabled = YES;
}


- (IBAction)commentBtn:(UIButton *)sender {
    [self.codeTF resignFirstResponder];
    [self.editMoneyTF resignFirstResponder];
    if ([self valueValidated]) {
        //提现的接口请求
        NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                                @"verifyCode":self.codeTF.text,
                                @"withdrawAmount":self.editMoneyTF.text};
        [HttpClient POST:@"mch/withdraw/withdrawReq" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
            if (IsRequestTrue) {
                [self withDrawalSuccess];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}


-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.editMoneyTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入提现金额" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.codeTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入验证码" duration:1.];
        return NO;
    }else if ([self.moneyLabel.text doubleValue] < [self.editMoneyTF.text doubleValue]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的可提现余额不足，请重新输入" duration:1.];
        return NO;
    }else if ([self.editMoneyTF.text integerValue]%10 !=0){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的提现金额必须是10的整数倍" duration:1.];
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


- (void)withDrawalSuccess
{

    [self.view addSubview:self.resultView];
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}


@end
