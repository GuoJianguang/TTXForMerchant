//
//  TimeTableViewCell.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YetTimeTableViewDataSouce.h"

@interface MyStoreModel : BaseModel

@property (nonatomic, copy)NSString *aviableBalance;
@property (nonatomic, copy)NSString *mchCode;
@property (nonatomic, copy)NSString *mchName;


@end



@interface TimeTableViewCell : BaseTableViewCell

@property (nonatomic, strong)TimeModel *dataModel;

@property (nonatomic, strong)MyStoreModel *storeModel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;



@end
