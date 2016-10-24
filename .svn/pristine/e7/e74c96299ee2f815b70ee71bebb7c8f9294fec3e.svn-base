//
//  MyWallectCollectionViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyWallectCollectionViewCell.h"

@implementation MYWallectTixianModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    MYWallectTixianModel *model = [[MYWallectTixianModel alloc]init];
    model.withdrawAmout = [NullToNumber(dic[@"withdrawAmout"]) doubleValue];
    model.successTime = NullToSpace(dic[@"successTime"]);
    model.state = NullToSpace(dic[@"state"]);
    return model;
}

@end


@implementation AssociateJissuanModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    AssociateJissuanModel *model = [[AssociateJissuanModel alloc]init];
    model.mchName = NullToSpace(dic[@"mchName"]);
    model.settleAmount = NullToNumber(dic[@"settleAmount"]);
    model.settleId = NullToSpace(dic[@"settleId"]);
    model.settleTime = NullToNumber(dic[@"settleTime"]);
    model.state = NullToNumber(dic[@"state"]);
    model.stateDesc = NullToNumber(dic[@"stateDesc"]);
    model.totalAmount = NullToNumber(dic[@"totalAmount"]);
    return model;
}
@end

@implementation MyWallectCollectionViewCell


- (void)awakeFromNib {
    // Initialization code
    self.name_label.textColor = MacoTitleColor;
    self.detail_label.textColor = MacoDetailColor;

    self.stauts_label.adjustsFontSizeToFitWidth = YES;
}

- (void)setJiesuanDataModel:(AssociateJissuanModel *)jiesuanDataModel
{
    _jiesuanDataModel = jiesuanDataModel;
    self.name_label.text = _jiesuanDataModel.mchName;
    self.stauts_label.text = _jiesuanDataModel.stateDesc;
    self.detail_label.text = [NSString stringWithFormat:@"营业额:%.2f元\n应结算:%.2f元\n%@",[_jiesuanDataModel.totalAmount doubleValue],[_jiesuanDataModel.settleAmount doubleValue],_jiesuanDataModel.settleTime];
    if ([_jiesuanDataModel.state isEqualToString:@"1"] || [_jiesuanDataModel.state isEqualToString:@"6"]) {
        self.stauts_label.textColor = MacoColor;
    }else{
        self.stauts_label.textColor = MacoDetailColor;
    }
}


- (void)setTixianModel:(MYWallectTixianModel *)tixianModel
{
    _tixianModel = tixianModel;
    self.name_label.text = @"账户提现";
    NSInteger type = [_tixianModel.state integerValue];
    self.detail_label.text = [NSString stringWithFormat:@"%@\n申请提现%.2f元",_tixianModel.successTime,_tixianModel.withdrawAmout];

    switch (type) {
        case 0:
        {
            self.stauts_label.text = @"待审核";
            self.stauts_label.textColor = MacoColor;
        }
            break;
        case 1:
        {
            self.stauts_label.text = @"审核通过";
            self.stauts_label.textColor = MacoColor;
            self.detail_label.text = [NSString stringWithFormat:@"%@\n提现%.2f元成功",_tixianModel.successTime,_tixianModel.withdrawAmout];

        }
            break;
        case 2:
        {
            self.stauts_label.text = @"提现中";
            self.stauts_label.textColor = MacoColor;
        }
            break;
        case 3:
        {
            self.stauts_label.text = [NSString stringWithFormat:@"%.2f元",_tixianModel.withdrawAmout];
            self.stauts_label.textColor = MacoColor;
        }
            break;
        case 4:
        {
            self.stauts_label.text = @"提现失败";
            self.stauts_label.textColor = MacoDetailColor;
            self.detail_label.text = [NSString stringWithFormat:@"%@\n提现%.2f元失败",_tixianModel.successTime,_tixianModel.withdrawAmout];

        }
            break;
            
        default:
            break;
    }
    

}

@end
