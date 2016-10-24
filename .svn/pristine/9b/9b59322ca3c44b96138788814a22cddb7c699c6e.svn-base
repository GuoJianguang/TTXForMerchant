//
//  BussessInfoTableViewCell.h
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussessDetailModel.h"

@interface BussessInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *show_view;
- (IBAction)call_btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *address_label;

- (IBAction)check_address_btn:(UIButton *)sender;

@property (nonatomic, strong)BussessDetailModel *dataModel;

@property (weak, nonatomic) IBOutlet UIButton *getLocationBtn;

- (IBAction)getLocationBtn:(UIButton *)sender;

//返回重用标示
+ (NSString *)indentify;
//创建xib中的cell
+ (id)newCell;


@end
