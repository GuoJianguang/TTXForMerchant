//
//  TimeTableViewCell.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "TimeTableViewCell.h"


@implementation MyStoreModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    MyStoreModel *model = [[MyStoreModel alloc]init];
    model.aviableBalance = NullToNumber(dic[@"aviableBalance"]);
    model.mchCode = NullToNumber(dic[@"mchCode"]);
    model.mchName = NullToNumber(dic[@"mchName"]);
    return model;
}

@end


@implementation TimeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setDataModel:(TimeModel *)dataModel
{
    _dataModel = dataModel;
    self.timeLabel.text = _dataModel.time_str;
    if (_dataModel.isSelect) {
        self.timeLabel.textColor = MacoColor;
    }else{
        self.timeLabel.textColor = MacoTitleColor;
    }
}

- (void)setStoreModel:(MyStoreModel *)storeModel
{
    _storeModel = storeModel;
    self.timeLabel.text = _storeModel.mchName;
}


@end
