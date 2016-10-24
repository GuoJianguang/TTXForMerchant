//
//  InformationDetailTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "InformationDetailTableViewCell.h"

@implementation InformationDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.itemView.layer.cornerRadius = 8;
    self.itemView.layer.masksToBounds= YES;
    
    self.detailImage.layer.cornerRadius = 8;
    self.detailImage.layer.masksToBounds = YES;

    self.timeLabel.textColor = MacoDetailColor;
    self.titleLabel.textColor = MacoTitleColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setDataModel:(InformationBannerModel *)dataModel
{
    _dataModel = dataModel;
    [self.detailImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.cover] placeholderImage:LoadingErrorImage options:SDWebImageRefreshCached];

    self.titleLabel.text = _dataModel.title;
    self.timeLabel.text = _dataModel.createTime;
    
}


@end
