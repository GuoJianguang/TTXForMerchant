//
//  BankPickView.h
//  天添薪
//
//  Created by ttx on 16/1/13.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogisticsCompanyPickView;
@protocol LogisticsCompanyPickDelegate <NSObject>

- (void)bankPickerView:(LogisticsCompanyPickView *)picker
    finishPickbankName:(NSString *)bankName
                  bankId:(NSString *)bankId;

@end

@interface LogisticsCompanyPickView : UIPickerView

@property (nonatomic, assign)BOOL isAddressPicker;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (nonatomic, assign)id<LogisticsCompanyPickDelegate> pickerdelegate;


@end
