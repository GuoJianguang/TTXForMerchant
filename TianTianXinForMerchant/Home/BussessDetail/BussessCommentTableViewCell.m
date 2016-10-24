//
//  BussessCommentTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BussessCommentTableViewCell.h"
#import "BussesscommentDetailTableViewCell.h"
#import "BussessAllCommentViewController.h"


@interface BussessCommentTableViewCell()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BussessCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.show_view.layer.cornerRadius = 8;
    self.tableView.delegate= self;
    self.tableView.dataSource = self;
    self.allCommentLabel.textColor = MacoDetailColor;
    self.titleLabel.textColor = MacoTitleColor;
    


}

//返回重用标示
+ (NSString *)indentify
{
    return @"BussessCommentTableViewCell";
}
//创建cell


+ (id)newCell
{
    NSArray *array  = [[NSBundle mainBundle]loadNibNamed:@"BussessCommentTableViewCell" owner:nil options:nil];
    return array[0];
}

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
        [self.tableView reloadData];
    }
    return _commentArray;
}

- (void)setDataModel:(BussessDetailModel *)dataModel
{
    _dataModel = dataModel;
}

- (IBAction)checkmoreComment:(UIButton *)sender {
    BussessAllCommentViewController *allCommentVC = [[BussessAllCommentViewController alloc]init];
    allCommentVC.code = self.dataModel.code;
    [self.viewController.navigationController pushViewController:allCommentVC animated:YES];
    
}



#pragma mark - tableView


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BussesscommentDetailTableViewCell *cell = (BussesscommentDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[BussesscommentDetailTableViewCell indentify]];
    if (!cell) {
        cell = [BussesscommentDetailTableViewCell newCell];
    }
    cell.detail_label.numberOfLines = cell.replayDetailLabel.numberOfLines = 2;
    cell.dataModel = self.commentArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BussessComment *comment = self.commentArray[indexPath.row];
    if (!comment.replyFlag) {
        return 100;
    }
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.commentArray.count;
}


@end
