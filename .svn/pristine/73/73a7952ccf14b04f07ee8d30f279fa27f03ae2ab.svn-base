//
//  MyWalletTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyWalletTableViewCell.h"


@implementation MyWalletViewModel

+ (MyWalletViewModel *)dataWithDic:(NSDictionary *)dic
{
    MyWalletViewModel *model = [[MyWalletViewModel alloc]init];
    model.titel = dic[@"titel"];
    model.image_name = dic[@"image_name"];
    model.count = dic[@"count"];
    return model;
}

@end


@implementation MyWalletTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.count_label.layer.cornerRadius = 8;
    self.count_label.layer.masksToBounds = YES;
    self.count_label.backgroundColor = MacoColor;
    self.item_view.backgroundColor = [UIColor clearColor];

    self.detail_titel.textColor = MacoTitleColor;
}

//返回重用标示
+ (NSString *)indentify
{
    return @"MyWalletTableViewCell";
}
//创建cell
+ (id)newCell
{
    NSArray *array  = [[NSBundle mainBundle]loadNibNamed:@"MyWalletTableViewCell" owner:nil options:nil];
    return array[0];
}


- (void)setDataModel:(MyWalletViewModel *)dataModel
{
    _dataModel = dataModel;
    
    self.mark_image.image = [UIImage imageNamed:_dataModel.image_name];
    self.detail_titel.text = _dataModel.titel;
    self.count_label.text = _dataModel.count;
    if ([_dataModel.count isEqualToString:@"0"]) {
        self.count_label.hidden = YES;
    }
}



@end
