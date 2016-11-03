//
//  MyWithDrawalView.m
//  天添薪
//
//  Created by ttx on 16/1/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyWithDrawalView.h"
#import "WithDrawalViewController.h"
#import "BingdingCardViewController.h"
#import "UIView+SetGradient.h"
#import "WithDrawalTableViewCell.h"


@interface MyWithDrawalView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation MyWithDrawalView

- (void)awakeFromNib
{
//    [super awakeFromNib];
    //    获取提现信息

}

- (void)updataInfo
{
//    [self layoutSubviews];
    [HttpClient GET:@"mch/withdraw" parameters:@{@"token":[TTXUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [TTXUserInfo shareUserInfos].bindingFlag = NullToNumber(jsonObject[@"data"][@"bankAccountFlag"]);
            [TTXUserInfo shareUserInfos].bankAccountRealName = NullToSpace(jsonObject[@"data"][@"realName"]);
            [TTXUserInfo shareUserInfos].bankAccount = NullToSpace(jsonObject[@"data"][@"bankAccount"]);
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView reloadData];
        
    }];

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"MyWithDrawalView" owner:nil options:nil][0];
        self.tableView.delegate  = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//}


#pragma mark - UITabelView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self cellHeight:nil] + 50 + 8 + 15 + 30 +(TWitdh - 80)/6.;
    return  height + 30 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WithDrawalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WithDrawalTableViewCell indentify]];
    if (!cell) {
        cell = [WithDrawalTableViewCell newCell];
    }
    return cell;
}

- (CGFloat)cellHeight:(NSString *)textSting
{
    textSting = @"每位用户只能使用一个天添薪账户并绑定该用户名下银行卡进行提现等操作,如有违反，将对该用户名下所有账号进行冻结处理，无法参与返现，由此造成的后果由用户自行承担";
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh - 20 , 0) font:[UIFont systemFontOfSize:13]];
    return size.height;
}

@end
