//
//  WithDrawalTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "WithDrawalTableViewCell.h"
#import "WithDrawalViewController.h"
#import "BingdingCardViewController.h"
#import "UIView+SetGradient.h"

@implementation WithDrawalTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.card_label.textColor = MacoTitleColor;
    self.detail_label.textColor = MacoTitleColor;
    self.alerLabel.textColor = [UIColor colorFromHexString:@"8c8c8c"];
    
    if ([[TTXUserInfo shareUserInfos].bindingFlag isEqualToString:@"1"]) {
        self.card_label.text = [self normalNumToBankNum:[TTXUserInfo shareUserInfos].bankAccount];
        self.detail_label.text = [TTXUserInfo shareUserInfos].bankAccountRealName;
        self.alerLabel.text = @"";
        
        [self.commit_btn setBackgroundImage:[UIImage imageNamed:@"btn_1_nor"] forState:UIControlStateNormal];
        self.commit_btn.enabled = YES;
        self.rightBtn.hidden = YES;
        return;
    }
    
    self.rightBtn.hidden = YES;
    self.card_label.text = @"银行卡";
    self.detail_label.text = @"";
    self.alerLabel.text = @"您还没有绑定银行卡，请联系代理商进行信息确认及绑定银行卡(该银行卡须与每日结算扣款银行卡账号一致），如有疑问请联系客服。";

    [self.commit_btn setBackgroundImage:[UIImage imageNamed:@"btn_1_dis"] forState:UIControlStateNormal];
    [self.commit_btn setTitleColor:MacoGrayColor forState:UIControlStateNormal];
    self.commit_btn.enabled = NO;
    
}


- (NSString *)normalNumToBankNum:(NSString *)num
{
    if (num.length < 7) {
        return num;
    }
    NSString *temp = [NSString string];
    for (int i = 0; i < num.length - 7; i ++) {
        temp = [NSString stringWithFormat:@"%@*",temp];
    }
    NSString *tmpStr = [num stringByReplacingCharactersInRange:NSMakeRange(4, num.length-7) withString:temp];
    
    NSUInteger size = (tmpStr.length / 4);
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*4, (tmpStr.length % 4))]];
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tmpStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (IBAction)commit_btn:(UIButton *)sender {
    NSLog(@"提现");
    WithDrawalViewController *withDVC = [[WithDrawalViewController alloc]init];
    [self.viewController.navigationController pushViewController:withDVC animated:YES];
    
    
}

- (IBAction)detail_btn:(UIButton *)sender {
    return;
//    if ([[TTXUserInfo shareUserInfos].bindingFlag isEqualToString:@"1"]) return;
//    NSLog(@"查看详情");
//    BingdingCardViewController *bingDingVC = [[BingdingCardViewController alloc]init];
//    [self.viewController.navigationController pushViewController:bingDingVC animated:YES];
    
}


@end
