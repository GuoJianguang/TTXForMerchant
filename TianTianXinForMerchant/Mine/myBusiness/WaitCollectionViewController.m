//
//  WaitCollectionViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "WaitCollectionViewController.h"
#import "WaitCollectionTableViewCell.h"

@interface WaitCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataSocueArray;


@property (nonatomic, assign)NSInteger page;

@end

@implementation WaitCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"待收款订单";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self waitCollectionRequest:YES];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self waitCollectionRequest:NO];
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

//关联店铺订单数据查询
- (void)waitCollectionRequest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"flag":@"1",
                            @"tranTime":@"",
                            @"pageNo":@(self.page),
                            @"pageSize":@(MacoPageSize)};
    [HttpClient POST:@"mch/business/orders" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
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
    return cell;
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
