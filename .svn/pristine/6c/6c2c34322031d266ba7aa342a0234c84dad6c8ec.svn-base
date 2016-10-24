//
//  BussessinfoDetailTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BussessinfoDetailTableViewCell.h"
#import "ShowBussessImageViewController.h"
#import "ImageViewer.h"


@implementation BussessinfoDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.show_view.layer.cornerRadius = 8;
//    self.show_view.backgroundColor = [UIColor clearColor];
    self.checkMoreLabel.textColor = MacoDetailColor;
    

    self.introduce_label.textColor = [UIColor colorFromHexString:@"8c8c8c"];
    self.titleLabel.textColor = MacoTitleColor;
}

//返回重用标示
+ (NSString *)indentify
{
    return @"BussessinfoDetailTableViewCell";
}
//创建cell


+ (id)newCell
{
    NSArray *array  = [[NSBundle mainBundle]loadNibNamed:@"BussessinfoDetailTableViewCell" owner:nil options:nil];
    return array[0];
}

- (IBAction)checkMoreImage_btn:(UIButton *)sender {
    if (self.dataModel.morePic.count ==0) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"暂时没有更多图片" duration:1.5];
        return;
    }
    [ImageViewer sharedImageViewer].controller = self.viewController;
    [[ImageViewer sharedImageViewer]showImageViewer:[NSMutableArray arrayWithArray:self.dataModel.morePic] withIndex:0 andView:self];
//    ShowBussessImageViewController *showVC = [[ShowBussessImageViewController alloc]init];
//    [self.viewController.navigationController pushViewController:showVC animated:YES];
}


- (void)setDataModel:(BussessDetailModel *)dataModel
{
    _dataModel = dataModel;
    self.introduce_label.numberOfLines = 0;
    self.introduce_label.text = _dataModel.desc;
    if ([_dataModel.desc isEqualToString:@""]) {
        self.introduce_label.text = @"您的店铺还没有任何描述,请编辑好描述信息联系我们吧!";
    }
}

@end
