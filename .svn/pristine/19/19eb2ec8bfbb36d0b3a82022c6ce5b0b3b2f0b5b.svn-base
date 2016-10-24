//
//  YetCompleteOrderViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "YetCompleteOrderViewController.h"
#import "AssociatedOrederTableViewCell.h"
#import "YetTimeTableViewDataSouce.h"

@interface YetCompleteOrderViewController ()<UITableViewDataSource,UITableViewDelegate,YetTimeDelegate>

@property(nonatomic, strong)YetTimeTableViewDataSouce *timeDataSouce;

@property(nonatomic, strong)UITableView *timeTableView;


@property (nonatomic, strong)NSMutableArray *dataSocueArray;

@property (nonatomic, strong)NSString *tranTime;

@property (nonatomic, assign)NSInteger page;


@end

@implementation YetCompleteOrderViewController

- (NSMutableArray *)dataSocueArray
{
    if (!_dataSocueArray) {
        _dataSocueArray = [NSMutableArray array];
    }
    return _dataSocueArray;
}
- (YetTimeTableViewDataSouce *)timeDataSouce
{
    if (!_timeDataSouce) {
        _timeDataSouce = [[YetTimeTableViewDataSouce alloc]init];
    }
    return _timeDataSouce;
}

- (UITableView *)timeTableView
{
    if (!_timeTableView) {
        _timeTableView = [[UITableView alloc]init];
    }
    return _timeTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"已完成订单";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.timeTableView.delegate = self.timeDataSouce;
    self.timeTableView.dataSource = self.timeDataSouce;
    self.timeDataSouce.delegate = self;
    self.timeTableView.frame = CGRectMake(0, 64+45, TWitdh, 221);
    self.timeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.timeTableView.hidden = YES;
    [self.view addSubview:self.timeTableView];
    self.time.textColor = MacoTitleColor;
    self.timeDataSouce.tempSelect = @"全部时间";

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

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSocueArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssociatedOrederTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AssociatedOrederTableViewCell indentify]];
    if (!cell) {
        cell = [AssociatedOrederTableViewCell newCell];
    }
    if (self.dataSocueArray.count > 0) {
        cell.dataModel = self.dataSocueArray[indexPath.row];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//关联店铺订单数据查询
- (void)waitCollectionRequest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"flag":@"2",
                            @"tranTime":NullToSpace(self.tranTime),
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
                [self.dataSocueArray addObject:[AssociatedOrederModel modelWithDic:dic]];
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

#pragma mark - 选择时间
- (IBAction)selectTime:(id)sender {
    
    self.timeTableView.hidden = !self.timeTableView.hidden;
    if (self.timeTableView.hidden) {
        self.tableView.scrollEnabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.markImage.transform=CGAffineTransformMakeRotation(0);
        }];
    }else{
        self.tableView.scrollEnabled = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.markImage.transform=CGAffineTransformMakeRotation(M_PI);
        }];
    }
}

#pragma mark - YetTimeDelegate
- (void)selectTimeItem:(NSString *)time
{
    if ([time isEqualToString:@"全部时间"]) {
        self.tranTime = @"";
        
    }else{
        self.tranTime = time;
        
    }
    self.time.text = time;
    self.timeTableView.hidden=YES;
    self.tableView.scrollEnabled = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.markImage.transform=CGAffineTransformMakeRotation(0);
    }];
    
    [self.tableView.mj_header beginRefreshing];
}



- (CGFloat)cellHeight:(NSString *)textSting
{
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh - 20 - 30 - 64, 0) font:[UIFont systemFontOfSize:13]];
    return size.height;
}



@end
