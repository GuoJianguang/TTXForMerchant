//
//  BussesscommentDetailTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BussesscommentDetailTableViewCell.h"

#import "CommentReplayViewController.h"



@implementation BussessComment

+ (id)modelWithDic:(NSDictionary *)dic
{
    BussessComment *model = [[BussessComment alloc]init];
    model.commentId = NullToNumber(dic[@"id"]);
    model.consumeTime = NullToNumber(dic[@"consumeTime"]);
    model.createTime = NullToNumber(dic[@"createTime"]);
    model.mchCode = NullToNumber(dic[@"mchCode"]);
    model.mchName = NullToNumber(dic[@"mchName"]);
    model.pic = NullToNumber(dic[@"pic"]);
    model.content = NullToNumber(dic[@"content"]);
    model.userId = NullToNumber(dic[@"userId"]);
    model.userNickName = NullToNumber(dic[@"userNickName"]);
    if ([NullToNumber(dic[@"replyFlag"]) isEqualToString:@"1"]) {
        model.replyFlag = YES;
    }else{
        model.replyFlag = NO;
    }
    model.replyContent = NullToSpace(dic[@"replyContent"]);
    return model;
}

@end

@implementation BussesscommentDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.time_label.textColor = MacoDetailColor;
    self.detail_label.textColor  = MacoIntroduceColor;
    self.replayDetailLabel.textColor = MacoIntroduceColor;
    [self.replayBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    self.user_name.textColor = MacoColor;

}

//返回重用标示
+ (NSString *)indentify
{
    return @"BussesscommentDetailTableViewCell";
}
//创建cell


+ (id)newCell
{
    NSArray *array  = [[NSBundle mainBundle]loadNibNamed:@"BussesscommentDetailTableViewCell" owner:nil options:nil];
    return array[0];
}

- (void)setDataModel:(BussessComment *)dataModel
{
    _dataModel = dataModel;
    self.user_name.text = _dataModel.userNickName;
    if ([_dataModel.userNickName isEqualToString:@""]) {
       self.user_name.text = @"天添薪用户";
    }
    self.replayView.hidden = !_dataModel.replyFlag;
    self.replayBtn.hidden = _dataModel.replyFlag;
    self.replayDetailLabel.text = [NSString stringWithFormat:@"商家回复:%@",_dataModel.replyContent];
    self.detail_label.text = _dataModel.content;
    self.time_label.text = _dataModel.createTime;
    

}





- (IBAction)replayBtn:(UIButton *)sender {
    CommentReplayViewController *replayVC = [[CommentReplayViewController alloc]init];
    replayVC.dataModel = _dataModel;
    [self.viewController.navigationController pushViewController:replayVC animated:YES];
}
@end
