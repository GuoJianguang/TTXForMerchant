//
//  BingdingCardViewController.m
//  天添薪
//
//  Created by ttx on 16/1/8.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BingdingCardViewController.h"
#import "PSCityPickerView.h"
#import "BankShareManager.h"
#import "Verify.h"
#import "BankPickView.h"


@interface BingdingCardViewController ()<PSCityPickerViewDelegate,BankPickViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) BankPickView *cityPicker;
@property (strong, nonatomic)BankPickView *bankPicker;

@property (copy,nonatomic)NSString *bank_id;

@property (copy,nonatomic)NSString *tempBankName;
@property (copy,nonatomic)NSString *tempProName;


@end

@implementation BingdingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"绑定银行卡";
    self.editView.layer.cornerRadius = 8;
    self.editView.layer.masksToBounds = YES;
//    [TTXUserInfo setjianpianColorwithView:self.sureView withWidth:CGRectGetWidth(self.sureView.bounds) withHeight:CGRectGetHeight(self.sureView.bounds)];
//    self.sureView.layer.cornerRadius = CGRectGetHeight(self.sureView.bounds)/2;
    self.sureView.layer.masksToBounds = YES;
    self.phoneTF.delegate = self;
    self.provincesTF.delegate = self;
    self.bankLabel.delegate = self;
    self.cityPicker.isAddressPicker = YES;
    self.provincesTF.inputView = self.cityPicker;
    self.bankLabel.inputView = self.bankPicker;
    self.tempProName = self.cityPicker.dataSouceArray[0][@"bankName"];
    self.tempBankName = @"中国银行";
    self.bank_id = @"1";
    self.bankCardNu.delegate = self;
//    [self.bankCardNu formatterTextFieldWithSpace:24 formatterTextFieldHandler:^(NSString *formatterNumber) {
//        NSString *str = [formatterNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
////        BankModel *model =   [[BankShareManager shareManager]getBankInfo:str];
////        self.bankLabel.text = model.bankName;
//    }];
}


- (NSString *)tempBankName
{
    if (!_tempBankName) {
        _tempBankName = [NSString string];
    }
    return _tempBankName;
}

- (NSString *)tempProName
{
    if (!_tempProName) {
        _tempProName   = [NSString string];
    }
    return _tempProName;
}
#pragma mark - BankPickerView

- (BankPickView *)bankPicker
{
    if (!_bankPicker) {
        _bankPicker = [[BankPickView alloc]init];
        _bankPicker.bankdelegate = self;
    }
    return _bankPicker;
}

- (void)bankPickerView:(BankPickView *)picker finishPickbankName:(NSString *)bankName bankId:(NSString *)bankId
{
    if (picker == self.bankPicker) {
        self.bankLabel.text = bankName;
        self.tempBankName = bankName;
        self.bank_id = bankId;
    }else{
        self.provincesTF.text = bankName;
        self.tempProName = bankName;
    }

}

#pragma mark - PSCityPickerViewDelegate
- (void)cityPickerView:(PSCityPickerView *)picker
    finishPickProvince:(NSString *)province
                  city:(NSString *)city
              district:(NSString *)district
{
    self.tempProName = province;
    [self.provincesTF setText:[NSString stringWithFormat:@"%@ %@ %@",province,city,district]];
}

#pragma mark - Getter and Setter
- (BankPickView *)cityPicker
{
    if (!_cityPicker)
    {   _cityPicker.isAddressPicker = YES;
        _cityPicker = [[BankPickView alloc] init];
        _cityPicker.bankdelegate = self;
    }
    return _cityPicker;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//选择发卡行
- (IBAction)banLabelBtn:(UIButton *)sender {
    [self.bankLabel becomeFirstResponder];

}

//选择地址
- (IBAction)provincesBtn:(UIButton *)sender {
    [self.provincesTF becomeFirstResponder];
}

//绑定
- (IBAction)bingdingBtn:(UIButton *)sender {
    
    self.nameTF.text =  [self.nameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([self valueValidated]) {
        //绑定的请求
        Verify *ver = [[Verify alloc]init];
        if (![ver verifyPhoneNumber:self.phoneTF.text]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"您的电话号码格式不正确" duration:1.5];
            return;
        }
        if (![ver verifyIDNumber:self.idCardNUTF.text]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"您的身份证号码格式不正确" duration:1.5];
            return;
        }
        
        NSString *bankNum = [self.bankCardNu.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSDictionary *parms = @{@"bankId":self.bank_id,
                                @"bankAccount":bankNum,
                                @"realName":self.nameTF.text,
                                @"bankPhone":self.phoneTF.text,
                                @"bankAccountPro":self.provincesTF.text,
                                @"token":[TTXUserInfo shareUserInfos].token,
                                @"identity":self.idCardNUTF.text};
        [HttpClient POST:@"user/withdraw/bindBankcard/add" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
            if (IsRequestTrue) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"绑定成功" duration:1.5];
                [TTXUserInfo shareUserInfos].bankAccount = bankNum;
                [TTXUserInfo shareUserInfos].bankAccountRealName = self.nameTF.text;
                [TTXUserInfo shareUserInfos].bindingFlag = @"1";
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }
}


-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.bankCardNu]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入银行卡号" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.bankLabel]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择发卡银行" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.provincesTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择地址" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.nameTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入持卡人姓名" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.phoneTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入银行预留手机号码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.idCardNUTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入身份证号码" duration:1.];
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

#pragma mark - UItextFileDelegate
//字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.bankCardNu == textField) {
        //格式化银行卡号
        NSString *text = [textField text];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound)
        {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0)
        {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4)
            {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        if (newString.length >= 24)
        {
            [textField resignFirstResponder];
            return NO;
        }
        
        [textField setText:newString];

        return NO;
    }
    
    if (textField == self.phoneTF) {
        if (self.phoneTF.text.length >10 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.provincesTF) {
        [self.provincesTF setText:[NSString stringWithFormat:@"%@",self.tempProName]];
    }
    if (textField == self.bankLabel) {
        [self.bankLabel setText:[NSString stringWithFormat:@"%@",self.tempBankName]];
    }
}


@end
