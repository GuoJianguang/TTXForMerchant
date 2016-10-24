//
//  AboutUsNewViewController.m
//  tiantianxin
//
//  Created by ttx on 16/5/17.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "AboutUsNewViewController.h"
#import "AboutTableViewCell.h"


@interface AboutUsNewViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AboutUsNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"关于天添薪";
    self.tableView.backgroundColor = [UIColor clearColor];
    
}


#pragma mark - UITabelView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AboutTableViewCell indentify]];
    if (!cell) {
        cell = [AboutTableViewCell newCell];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (THeight >480) {
        return THeight - 30;
    }
    return THeight + (TWitdh-24)/6;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
