//
//  OrderEntryTableViewCell.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/3/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "OrderEntryTableViewCell.h"
#import "Verify.h"

@interface OrderEntryTableViewCell()<UITextFieldDelegate>

@end

@implementation OrderEntryTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scanResult:) name:@"scanResultSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    self.phoneTF.delegate = self;
    self.orderMoneyTF.delegate = self;
    self.yueMoneyTF.delegate = self;
    self.yueMoneyTF.keyboardType = UIKeyboardTypeASCIICapable;

    
    self.contentView.backgroundColor = [UIColor clearColor];
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"dateString:%@",dateString);
    
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy年MM月dd日"];
    NSString *lastDayStr = [dateFormatter1 stringFromDate:lastDay];
    self.lastDayLabel.text = lastDayStr;
    
    if ([dateString floatValue] > 8 ) {
        self.timeHeight.constant = 0;
        self.timeView.hidden = YES;
    }else{
        self.timeHeight.constant = 100;
        self.timeView.hidden = NO;
        self.sureBtnTop.constant = 30;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark - 扫码结果
- (void)scanResult:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    self.phoneTF.text = NullToSpace(info[@"phone"]);
}
- (void)textFieldChanged:(UITextField *)textfiled
{
    double order = [NullToNumber(self.orderMoneyTF.text) doubleValue];
    double  yue = [NullToNumber(self.yueMoneyTF.text) doubleValue];
    if (yue - order <= 0 ) {
        self.cashLabel.text = [NSString stringWithFormat:@"%.2lf元",order - yue];
    }
    if (yue > order) {
        self.yueMoneyTF.text = [self.yueMoneyTF.text substringToIndex:self.yueMoneyTF.text.length-1];
    }
}


- (IBAction)scanBtn:(id)sender
{
    [(OrderEntryViewController *)self.viewController scan];
}

- (IBAction)sureBtn:(id)sender
{
    [self.phoneTF resignFirstResponder];
    [self.orderMoneyTF resignFirstResponder];
    [self.yueMoneyTF resignFirstResponder];
    
    if ([self valueValidated]) {
        Verify *ver = [[Verify alloc]init];
        if (![ver verifyPhoneNumber:self.phoneTF.text]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"您的电话号码格式不正确" duration:1.5];
            return;
        }
        NSDate *date = [NSDate date];
        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy年MM月dd日"];
        NSString *lastDayStr = [dateFormatter1 stringFromDate:lastDay];

        NSString *todayStr = [dateFormatter1 stringFromDate:date];
        
        NSString *cashStr = [self.cashLabel.text stringByReplacingOccurrencesOfString:@"元" withString:@""];
        
        NSString *yueMoneyStr = [NSString string];
        if ([self.yueMoneyTF.text isEqualToString:@""] || !self.yueMoneyTF.text) {
            yueMoneyStr = @"0";
        }else{
            yueMoneyStr = self.yueMoneyTF.text;
        }
        
        if (self.isSelectBtn.selected) {
            [(OrderEntryViewController *)self.viewController addSureOrderView:self.phoneTF.text withOrderMoney:self.orderMoneyTF.text withyuePay:yueMoneyStr withCash:cashStr withTime:lastDayStr withIsYestoday:self.isSelectBtn.selected];
        }else{
            [(OrderEntryViewController *)self.viewController addSureOrderView:self.phoneTF.text withOrderMoney:self.orderMoneyTF.text withyuePay:yueMoneyStr withCash:cashStr  withTime:todayStr withIsYestoday:self.isSelectBtn.selected];
        }
    }
}

-(BOOL) valueValidated {
    // 判断电话号码是否合格
    
    if ([self emptyTextOfTextField:self.phoneTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入手机号码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.orderMoneyTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入订单金额" duration:1.];
        return NO;
    }else if ([self.orderMoneyTF.text doubleValue] >10000000.){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的录入金额不能超过1千万" duration:2.];
        return NO;
    }
//    }else if ([self emptyTextOfTextField:self.yueMoneyTF]) {
//        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入余额支付金额" duration:1.];
//        return NO;
//    }
    return YES;
}


-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
}

//限制电话号码为11位数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTF || self.orderMoneyTF) {
        if (textField.text.length > 10 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    if (textField == self.orderMoneyTF) {
        self.yueMoneyTF.text = @"";
    }
    
    if (textField == self.orderMoneyTF || textField == self.yueMoneyTF) {
        if ([string isEqualToString:@"-"]) {
            return NO;
        }
    }
    if (textField == self.orderMoneyTF || textField == self.yueMoneyTF) {
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



- (IBAction)isSelectBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}
@end
