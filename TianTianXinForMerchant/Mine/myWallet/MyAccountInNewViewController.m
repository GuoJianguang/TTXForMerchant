//
//  MyAccountInNewViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/5/10.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyAccountInNewViewController.h"
#import "SortButtonSwitchView.h"
#import "WaitCollectionTableViewCell.h"


@interface MyAccountInNewViewController ()<SwipeViewDelegate,SwipeViewDataSource,SortButtonSwitchViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *mchTableView;
@property (nonatomic, strong)UITableView *merchantsTableView;

@property (nonatomic, assign)NSInteger mchPage;
@property (nonatomic, assign)NSInteger MerchantsPage;
@property (nonatomic, strong)NSMutableArray *mchdataSouceArray;
@property (nonatomic, strong)NSMutableArray *merchantsdataSouceArray;
@end

@implementation MyAccountInNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"账户收入";
    self.sortView.titleArray = @[@"实体店铺",@"网上商城"];
    self.sortView.delegate = self;
    self.swipeView.delegate = self;
    self.swipeView.dataSource = self;
    self.swipeView.backgroundColor = [UIColor clearColor];
    
    __weak MyAccountInNewViewController *weak_self = self;
    
    self.mchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.mchPage = 1;
        [weak_self getGoodsWaitCommentRequest:YES];
    }];
    self.mchTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getGoodsWaitCommentRequest:NO];
    }];

    //添加无数据提醒
    [self.mchTableView addNoDatasouceWithCallback:^{
        [weak_self.mchTableView.mj_header beginRefreshing];
    } andAlertSting:@"亲，暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
    
    
    self.merchantsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.MerchantsPage = 1;
        [weak_self getMerchantWaitCommentRequest:YES];
    }];
    self.merchantsTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getMerchantWaitCommentRequest:NO];
    }];


    //添加无数据提醒
    [self.merchantsTableView addNoDatasouceWithCallback:^{
        [weak_self.merchantsTableView.mj_header beginRefreshing];
    } andAlertSting:@"亲，暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];

    [self.merchantsTableView.mj_header beginRefreshing];
    [self.mchTableView.mj_header beginRefreshing];

}

- (UITableView *)mchTableView
{
    if (!_mchTableView) {
        _mchTableView = [[UITableView alloc]init];
        _mchTableView.dataSource = self;
        _mchTableView.delegate = self;
        _mchTableView.backgroundColor = [UIColor clearColor];
        _mchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _mchTableView;
}

- (UITableView *)merchantsTableView
{
    if ((!_merchantsTableView)) {
        _merchantsTableView  = [[UITableView alloc]init];
        _merchantsTableView.dataSource = self;
        _merchantsTableView.delegate = self;
        _merchantsTableView.backgroundColor = [UIColor clearColor];
        _merchantsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _merchantsTableView;
}

#pragma mark - 懒加载
- (NSMutableArray *)merchantsdataSouceArray
{
    if (!_merchantsdataSouceArray) {
        _merchantsdataSouceArray = [NSMutableArray array];
    }
    return _merchantsdataSouceArray;
}

- (NSMutableArray *)mchdataSouceArray
{
    if (!_mchdataSouceArray) {
        _mchdataSouceArray = [NSMutableArray array];
    }
    return _mchdataSouceArray;
}

#pragma mark - 实体店铺

- (void)getGoodsWaitCommentRequest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"flag":@"1",
                            @"tranTime":@"",
                            @"pageNo":@(self.mchPage),
                            @"pageSize":@(MacoPageSize)};
    
    [HttpClient POST:@"mch/account/income" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.mchdataSouceArray removeAllObjects];
                [self.mchTableView.mj_header endRefreshing];
            }else{
                [self.mchTableView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.mchPage ++;
            }
            for (NSDictionary *dic in array) {
                [self.mchdataSouceArray addObject:[WaitCollectionModel modelWithDic:dic]];
            }
            //判断数据源有无数据
            [self.mchTableView judgeIsHaveDataSouce:self.mchdataSouceArray];
            [self.mchTableView reloadData];
            return;
        }
        if (isHeader) {
            [self.mchTableView.mj_header endRefreshing];
        }else{
            [self.mchTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (isHeader) {
            [self.mchTableView.mj_header endRefreshing];
        }else{
            [self.mchTableView.mj_footer endRefreshing];
        }
        [self.mchTableView judgeIsHaveDataSouce:self.mchdataSouceArray];
        
    }];
}

#pragma mark - 商户请求
- (void)getMerchantWaitCommentRequest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"pageNo":@(self.MerchantsPage),
                            @"pageSize":@(MacoPageSize)};
    
    [HttpClient POST:@"mch/account/shopIncome" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.merchantsdataSouceArray removeAllObjects];
                [self.merchantsTableView.mj_header endRefreshing];
            }
            [self.merchantsTableView.mj_footer endRefreshing];
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.MerchantsPage ++;
            }
            for (NSDictionary *dic in array) {
                [self.merchantsdataSouceArray addObject:[OnlineAccountIn modelWithDic:dic]];
            }
            //判断数据源有无数据
            [self.merchantsTableView judgeIsHaveDataSouce:self.merchantsdataSouceArray];
            [self.merchantsTableView reloadData];
            return;
        }
        if (isHeader) {
            [self.merchantsTableView.mj_header endRefreshing];
        }else{
            [self.merchantsTableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (isHeader) {
            [self.merchantsTableView.mj_header endRefreshing];
        }else{
            [self.merchantsTableView.mj_footer endRefreshing];
        }
        [self.merchantsTableView judgeIsHaveDataSouce:self.merchantsdataSouceArray];
    }];
    
}


#pragma mark - SortButtonSwitchViewDelegate
- (void)sortBtnDselect:(SortButtonSwitchView *)sortView withSortId:(NSString *)sortId
{
    [self.swipeView scrollToPage:[sortId integerValue]- 1 duration:0.5];
}


#pragma mark - SwipeViewDataSource,SwipeViewDelegate
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 2;
}


- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (nil == view) {
        view = [[UIView alloc] initWithFrame:swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    switch (index) {
        case 1:
        {
            [self removeAllSubviews:view];
            [view addSubview:self.merchantsTableView];
            [self.merchantsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 0:
        {
            [self removeAllSubviews:view];
            [view addSubview:self.mchTableView];
            [self.mchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
    }
    return view;
}

- (void)removeAllSubviews:(UIView *)view{
    while (view.subviews.count) {
        UIView* child = view.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    switch (swipeView.currentItemIndex) {
        case 0:
//            [self.merchantsTableView.mj headerBeginRefreshing];
            break;
        case 1:
//            [self.mchTableView headerBeginRefreshing];
            break;
        default:
            break;
    }
    [self.sortView selectItem:swipeView.currentItemIndex ];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mchTableView) {
        return self.mchdataSouceArray.count;
    }
    return self.merchantsdataSouceArray.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaitCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WaitCollectionTableViewCell indentify]];
    
    if (!cell) {
        cell = [WaitCollectionTableViewCell newCell];
    }
    if (tableView == self.merchantsTableView) {
        if (self.merchantsdataSouceArray.count > 0) {
            cell.onLineModel = self.merchantsdataSouceArray[indexPath.row];
        }
//        cell.isGoodsOrder = NO;
    }else{
        if (self.mchdataSouceArray.count > 0) {
            cell.dataModel = self.mchdataSouceArray[indexPath.row];
        }
//        cell.isGoodsOrder = YES;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
