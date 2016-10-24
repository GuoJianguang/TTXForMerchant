//
//  MyMessageTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyMessageTableViewCell.h"


@implementation MessafeModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    MessafeModel *model = [[MessafeModel alloc]init];
    model.messageid = NullToSpace(dic[@"id"]);
    model.title = NullToSpace(dic[@"title"]);
    model.content = NullToSpace(dic[@"content"]);
    model.createTime = NullToSpace(dic[@"createTime"]);
    model.type = NullToSpace(dic[@"type"]);
    return model;
}

@end

@implementation MyMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.time_label.textColor = [UIColor whiteColor];
    self.detail_label.textColor = [UIColor colorFromHexString:@"8c8c8c"];
    self.titel_label.textColor = MacoTitleColor;
}

//返回重用标示
+ (NSString *)indentify
{
    return @"MyMessageTableViewCell";
}
//创建cell
+ (id)newCell
{
    NSArray *array  = [[NSBundle mainBundle]loadNibNamed:@"MyMessageTableViewCell" owner:nil options:nil];
    return array[0];
}

- (void)setDataModel:(MessafeModel *)dataModel
{
    _dataModel = dataModel;
    self.titel_label.text = _dataModel.title;
    self.detail_label.text = _dataModel.content;
    self.time_label.text = [NSString stringWithFormat:@"%@", _dataModel.createTime];
}


@end
