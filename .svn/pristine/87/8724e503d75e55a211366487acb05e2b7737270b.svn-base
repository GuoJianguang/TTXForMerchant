
//  BankPickView.m
//  天添薪
//
//  Created by ttx on 16/1/13.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BankPickView.h"

@interface BankPickView()<UIPickerViewDelegate,UIPickerViewDataSource>



@end

@implementation BankPickView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
        if (!self.isAddressPicker) {
            self.dataSouceArray = [NSMutableArray arrayWithArray:@[@{@"bankId":@"1",@"bankName":@"中国银行"},
                                                                   @{@"bankId":@"2",@"bankName":@"中国农业银行"},
                                                                   @{@"bankId":@"3",@"bankName":@"中国工商银行"},
                                                                   @{@"bankId":@"4",@"bankName":@"中国建设银行"},
                                                                   @{@"bankId":@"5",@"bankName":@"招商银行"},
                                                                   @{@"bankId":@"6",@"bankName":@"成都银行"},
                                                                   @{@"bankId":@"7",@"bankName":@"中国民生银行"},
                                                                   @{@"bankId":@"8",@"bankName":@"中国邮政储蓄"},
                                                                   @{@"bankId":@"9",@"bankName":@"农村信用社"},]];
        }else{
            [self.dataSouceArray removeAllObjects];
            NSBundle *bundle=[NSBundle mainBundle];
            NSString *path=[bundle pathForResource:@"city" ofType:@"plist"];
            NSDictionary *cityDic = [[NSDictionary alloc]initWithContentsOfFile:path];
            for (NSString *str in cityDic.allKeys) {
                NSDictionary *dic = cityDic[str];
                NSString *cityName = dic.allKeys[0];
                NSDictionary *iteDic =  @{@"bankId":@"0",@"bankName":cityName};
                [self.dataSouceArray addObject:iteDic];
            }
        }
    }
    return _dataSouceArray;

}

- (void)initWithIsAddrss:(BOOL)isAddress
{
    if (isAddress) {
        [self.dataSouceArray removeAllObjects];
        NSBundle *bundle=[NSBundle mainBundle];
        NSString *path=[bundle pathForResource:@"city" ofType:@"plist"];
        NSDictionary *cityDic = [[NSDictionary alloc]initWithContentsOfFile:path];
        for (NSString *str in cityDic.allKeys) {
            NSDictionary *dic = cityDic[str];
            NSString *cityName = dic.allKeys[0];
            NSDictionary *iteDic =  @{@"bankId":@"0",@"bankName":cityName};
            [self.dataSouceArray addObject:iteDic];
        }
    }

}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    //包含3列
    return 1;
}

//该方法返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSLog(@"-----%d",self.isAddressPicker);
    return self.dataSouceArray.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *titleLabel = (UILabel *)view;
    if (!titleLabel)
    {
        titleLabel = [self labelForPickerView];
    }
    titleLabel.text = self.dataSouceArray[row][@"bankName"];
    return titleLabel;
}

//选择指定列、指定列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *dic = self.dataSouceArray[row];
    if ([self.bankdelegate respondsToSelector:@selector(bankPickerView:finishPickbankName:bankId:)]) {
        [self.bankdelegate bankPickerView:pickerView finishPickbankName:dic[@"bankName"] bankId:dic[@"bankId"]];
    }
}

//指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    // 宽度
    return 100;
}



- (UILabel *)labelForPickerView
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:85/255 green:85/255 blue:85/255 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

@end
