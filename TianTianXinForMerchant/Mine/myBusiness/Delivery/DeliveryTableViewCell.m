//
//  DeliveryTableViewCell.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/4/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "DeliveryTableViewCell.h"
#import "MallOrderModel.h"
#import "LogisticsCompanyPickView.h"


@interface DeliveryTableViewCell()<LogisticsCompanyPickDelegate,UITextFieldDelegate>

@property (nonatomic, strong)LogisticsCompanyPickView *companyPicker;

@property (nonatomic, strong)NSString *logisticsCompanyCode;

@property (nonatomic, strong)NSString *tempCompanyStr;


@end

@implementation DeliveryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.shiipingPerson.textColor = MacoTitleColor;
    self.phone.textColor = MacoTitleColor;
    self.address.textColor = MacoIntroduceColor;
    self.shippingView.layer.cornerRadius = 5;
    self.shippingView.backgroundColor = [UIColor whiteColor];
    self.shippingView.layer.masksToBounds = YES;
    self.logisticsTF.delegate = self;
    
    self.orderView.layer.cornerRadius = 5;
    self.orderView.backgroundColor = [UIColor whiteColor];
    self.orderView.layer.masksToBounds = YES;
    self.orderImage.layer.cornerRadius = self.orderImage.bounds.size.width/2;
    self.orderImage.layer.masksToBounds = YES;
    self.orderName.textColor = MacoTitleColor;
    self.orderDetail.textColor = MacoDetailColor;
    self.time.textColor = [UIColor whiteColor];
    self.orderPrice.textColor = [UIColor whiteColor];
    
    
    self.logisticsTF.inputView = self.companyPicker;

    
    self.logisticsView.layer.cornerRadius = 5;
    self.logisticsView.backgroundColor = [UIColor whiteColor];
    self.logisticsView.layer.masksToBounds = YES;
    self.noLoginsticsLabel.textColor = MacoTitleColor;
    self.logisticsTF.textColor = MacoTitleColor;
    self.loginsticsLabel.textColor = MacoTitleColor;
    self.ohterLabel.textColor = MacoTitleColor;
    self.awbLabel.textColor = MacoTitleColor;
    self.awbTF.textColor = self.otherLNameTF.textColor = MacoDetailColor;
    
    self.selectLogBtn.selected = YES;
    self.logisticsHeight.constant = 135;
    self.logisticsNuTop.constant = 0;
    self.otherLView.hidden = YES;
    
    
    [self getAllCommpany];
    
}


- (NSString *)tempCompanyStr
{
    if (!_tempCompanyStr) {
        _tempCompanyStr = [NSString string];
    }
    return _tempCompanyStr;
}

#pragma mark - 获取所有物流公司

- (void)getAllCommpany
{
    self.logisticsTF.enabled = NO;
    self.logisticsTF.placeholder = @"暂时没有物流公司信息";
    [HttpClient GET:@"mch/business/logisticsCompany" parameters:nil success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = jsonObject[@"data"];
            NSMutableArray *datasoucearray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                NSDictionary *iteDic =  @{@"bankId":NullToSpace(dic[@"logisticsCompanyCode"]),@"bankName":NullToSpace(dic[@"logisticsCompany"])};
                [datasoucearray addObject:iteDic];
            }
            if (datasoucearray.count > 0) {
                self.tempCompanyStr = datasoucearray[0][@"bankName"];
            }
//            NSDictionary *otherdic  = @{@"bankId":@"other",@"bankName":@"其他快递"};
//            [datasoucearray addObject:otherdic];
            self.logisticsTF.placeholder = @"请选择物流公司";
            self.logisticsTF.enabled = YES;

            self.companyPicker.dataSouceArray = datasoucearray;
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
- (LogisticsCompanyPickView *)companyPicker
{
    if (!_companyPicker) {
        _companyPicker = [[LogisticsCompanyPickView alloc]init];
        _companyPicker.pickerdelegate = self;
    }
    return _companyPicker;
}
- (void)bankPickerView:(LogisticsCompanyPickView *)picker finishPickbankName:(NSString *)bankName bankId:(NSString *)bankId
{
    self.tempCompanyStr = bankName;
    self.logisticsTF.text = bankName;
    self.logisticsCompanyCode = bankId;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)noLogisticsBtn:(UIButton *)sender {
    self.selectLogBtn.selected = NO;
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
}

- (IBAction)selectLogBtn:(UIButton *)sender {
    self.noLogisticsBtn.selected = NO;
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
}

#pragma mark - 确认发货
- (IBAction)sureBtn:(UIButton *)sender {
    
    if (self.selectLogBtn.selected) {
        if ([self.logisticsTF.text isEqualToString:@""] || !self.logisticsTF.text) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请选择物流公司" duration:1.5];
            return;
        }else if ([self.awbTF.text isEqualToString:@""] || !self.awbTF.text){
            [[JAlertViewHelper shareAlterHelper]showTint:@"请填写运单号" duration:1.5];
            return;
        }else if ([self.logisticsCompanyCode isEqualToString:@"OTHER"] && ([self.otherLNameTF.text isEqualToString:@""] || !self.otherLNameTF.text)){
            [[JAlertViewHelper shareAlterHelper]showTint:@"请填写其他物流公司名称" duration:1.5];
            return;
        }
        
        NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                                @"orderId":self.dataModel.orderId,
                                @"logisticsCompanyCode":NullToSpace(self.logisticsCompanyCode),
                                @"logisticsNumber":NullToSpace(self.awbTF.text),
                                @"logisticsCompany":NullToSpace(self.otherLNameTF.text)};
        [HttpClient POST:@"mch/business/deliver" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
            if (IsRequestTrue) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"发货成功" duration:1.5];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshWaitFahuo" object:nil];
                [self.viewController.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }else{
        NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                                @"orderId":self.dataModel.orderId,
                                @"logisticsCompanyCode":@"",
                                @"logisticsNumber":@""};
        [HttpClient POST:@"mch/business/deliver" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
            if (IsRequestTrue) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"发货成功" duration:1.5];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshWaitFahuo" object:nil];
                [self.viewController.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}


- (IBAction)seletctBtn:(UIButton *)sender {
    if (self.companyPicker.dataSouceArray.count == 0) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"暂时没有物流公司信息，请重试..." duration:1.5];
        [self getAllCommpany];
        return;
    }
    [self.logisticsTF becomeFirstResponder];
}



- (void)setDataModel:(MallOrderModel *)dataModel
{
    _dataModel = dataModel;
    self.shiipingPerson.text = _dataModel.receiptPeople;
    self.phone.text = [NSString stringWithFormat:@"电话：%@",_dataModel.receiptPhone];
    self.address.text = [NSString stringWithFormat:@"收货地址：%@",_dataModel.receiptAddress];
    
    [self.orderImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.goodsImage] placeholderImage:LoadingErrorImage];
    self.orderName.text = _dataModel.goodsName;
    self.orderDetail.text = [NSString stringWithFormat:@"规格：%@/数量：%@",_dataModel.specStr,_dataModel.quantity];

    self.time.text = [NSString stringWithFormat:@"%@",_dataModel.time];
    
    self.orderPrice.text = [NSString stringWithFormat:@"￥ %.2f",[_dataModel.totalPrice doubleValue]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.logisticsTF.text = self.tempCompanyStr;
    if ([self.logisticsCompanyCode isEqualToString:@"OTHER"]) {
        self.logisticsNuTop.constant = 45;
        self.logisticsHeight.constant = 180;
        self.otherLView.hidden = NO;
    }else{
        self.otherLNameTF.text = @"";
        self.logisticsNuTop.constant = 0;
        self.logisticsHeight.constant = 135;
        self.otherLView.hidden = YES;
    }
}

@end
