//
//  MyAccountInDetailViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/3/1.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyAccountInDetailViewController.h"
#import "WaitCollectionTableViewCell.h"

@interface MyAccountInDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataSocueArray;
@property (nonatomic, assign)NSInteger page;

@end

@implementation MyAccountInDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"账户收入";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self accountInCollectionRequest:YES];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self accountInCollectionRequest:NO];
    }];
    
    [self.tableView addNoDatasouceWithCallback:^{
        [self.tableView.mj_header beginRefreshing];
    } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataSocueArray
{
    if (!_dataSocueArray) {
        _dataSocueArray = [NSMutableArray array];
    }
    return _dataSocueArray;
}

//账户收入
- (void)accountInCollectionRequest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"flag":@"1",
                            @"tranTime":@"",
                            @"pageNo":@(self.page),
                            @"pageSize":@(MacoPageSize)};
    [HttpClient POST:@"mch/account/income" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        if (IsRequestTrue) {
            
            if (isHeader) {
                [self.dataSocueArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.dataSocueArray addObject:[WaitCollectionModel modelWithDic:dic]];
            }
            [self.tableView reloadData];
            [self.tableView judgeIsHaveDataSouce:self.dataSocueArray];
            return ;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - UITableView



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSocueArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaitCollectionTableViewCell *cell = (WaitCollectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[WaitCollectionTableViewCell indentify]];
    if (!cell) {
        cell = [WaitCollectionTableViewCell newCell];
    }
    if (self.dataSocueArray.count > 0) {
        cell.dataModel = self.dataSocueArray[indexPath.row];
    }
    cell.storeName.text = @"余额支付";
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
