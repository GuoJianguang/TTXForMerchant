//
//  BussessCommentTableViewCell.h
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussessDetailModel.h"

@interface BussessCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *show_view;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)checkmoreComment:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *allCommentLabel;

//返回重用标示
+ (NSString *)indentify;
//创建xib中的cell
+ (id)newCell;

@property (nonatomic, strong)BussessDetailModel *dataModel;
@property (nonatomic, strong)NSMutableArray *commentArray;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
