//
//  MyMessageListViewController.m
//  天添薪
//
//  Created by ttx on 16/1/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyMessageListViewController.h"
#import "MyMessageTableViewCell.h"

@interface MyMessageListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *datasouceArray;

@property (nonatomic, assign)NSInteger page;
@end

@implementation MyMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"消息列表";
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self alldetailReqest:YES];
    }];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self alldetailReqest:NO];
        
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSInteger pangeCount = 20;

- (void)alldetailReqest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":@(pangeCount),
                            @"token":[TTXUserInfo shareUserInfos].token};
    [HttpClient GET:@"mch/message/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.datasouceArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.datasouceArray addObject:[MessafeModel modelWithDic:dic]];
            }
            //判断数据源有无数据
            [self.tableView judgeIsHaveDataSouce:self.datasouceArray];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView showRereshBtnwithALerString:@"网络连接不好"];
        
    }];
    
}

#pragma mark - UITableView
- (NSMutableArray *)datasouceArray
{
    if (!_datasouceArray) {
        _datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasouceArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datasouceArray.count > 0) {
        MessafeModel *model = self.datasouceArray[indexPath.row];
        CGFloat height = [self cellHeight:model.content];
        return 31+25 + height + 16 + 8 + 20 + 20;
    }
    return 31+25 + 100 + 16 + 8 + 20 + 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMessageTableViewCell *cell = (MyMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[MyMessageTableViewCell indentify]];
    if (!cell) {
        cell = [MyMessageTableViewCell newCell];
    }
    cell.item_view.layer.cornerRadius = 8;
    cell.item_view.layer.masksToBounds = YES;
    if (self.datasouceArray.count > 0) {
        cell.dataModel = self.datasouceArray[indexPath.row];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)cellHeight:(NSString *)textSting
{
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh - 20 - 30, 0) font:[UIFont systemFontOfSize:13]];
    return size.height;
}


@end
