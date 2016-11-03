//
//  MallOrderViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/4/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MallOrderViewController.h"
#import "SortButtonSwitchView.h"
#import "MallOrderModel.h"
#import "WaitSendMchTableViewCell.h"
#import "DeliveryViewController.h"


@interface MallOrderViewController ()<SortButtonSwitchViewDelegate,SwipeViewDelegate,SwipeViewDataSource,UITableViewDelegate,UITableViewDataSource,BasenavigationDelegate>



@property (nonatomic, strong)UITableView *yetCompleteTableView;

@property (nonatomic, strong)UITableView *yetFahuoTableView;

@property (nonatomic, strong)UITableView *waitFahuoTableView;

@property (nonatomic, assign)NSInteger yetCompletePage;
@property (nonatomic, assign)NSInteger yetFahuoPage;
@property (nonatomic, assign)NSInteger waitFahuoPage;


@property (nonatomic, strong)NSMutableArray *yetCompleteDataSouceArray;
@property (nonatomic, strong)NSMutableArray *yetFahuoDataSouceArray;
@property (nonatomic, strong)NSMutableArray *waitFahuoDataSouceArray;


@end

@implementation MallOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"商城订单";
    self.sortView.titleArray = @[@"已完成",@"已发货",@"待发货"];
    self.naviBar.delegate = self;
    self.sortView.delegate = self;
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
    
    __weak MallOrderViewController *weak_self = self;
    self.yetCompleteTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.yetCompletePage = 1;
        [weak_self getRequestIsHeader:YES withPage:MallOrderRequetst_yetComplete withTableview:weak_self.yetCompleteTableView withDataSouceArray:weak_self.yetCompleteDataSouceArray withPageType:weak_self.yetCompletePage];
        
    }];
    
    self.yetCompleteTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getRequestIsHeader:NO withPage:MallOrderRequetst_yetComplete withTableview:weak_self.yetCompleteTableView withDataSouceArray:weak_self.yetCompleteDataSouceArray withPageType:weak_self.yetCompletePage];
    }];
    
    [self.yetCompleteTableView addNoDatasouceWithCallback:^{
        [weak_self.yetCompleteTableView.mj_header beginRefreshing];
    } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
    
    self.yetFahuoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.yetFahuoPage = 1;
        [weak_self getRequestIsHeader:YES withPage:MallOrderRequetst_yetFahuo withTableview:weak_self.yetFahuoTableView withDataSouceArray:weak_self.yetFahuoDataSouceArray withPageType:weak_self.yetFahuoPage];
        
    }];
    
    self.yetFahuoTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getRequestIsHeader:NO withPage:MallOrderRequetst_yetFahuo withTableview:weak_self.yetFahuoTableView withDataSouceArray:weak_self.yetFahuoDataSouceArray withPageType:weak_self.yetFahuoPage];
    }];
    
    [self.yetFahuoTableView addNoDatasouceWithCallback:^{
        [weak_self.yetFahuoTableView.mj_header beginRefreshing];
    } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
    
    
    self.waitFahuoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.waitFahuoPage = 1;
        [weak_self getRequestIsHeader:YES withPage:MallOrderRequetst_waitFahuo withTableview:weak_self.waitFahuoTableView withDataSouceArray:weak_self.waitFahuoDataSouceArray withPageType:weak_self.waitFahuoPage];
        
    }];
    
    self.waitFahuoTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getRequestIsHeader:NO withPage:MallOrderRequetst_waitFahuo withTableview:weak_self.waitFahuoTableView withDataSouceArray:weak_self.waitFahuoDataSouceArray withPageType:weak_self.waitFahuoPage];
    }];
    
    [self.waitFahuoTableView addNoDatasouceWithCallback:^{
        [weak_self.waitFahuoTableView.mj_header beginRefreshing];
    } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
    
    [self.yetCompleteTableView.mj_header beginRefreshing];
    [self.yetFahuoTableView.mj_header beginRefreshing];
    [self.waitFahuoTableView.mj_header beginRefreshing];
    [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].shopCompleteCount integerValue] withIndex:0];
    [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].hasDeliveredCount integerValue] withIndex:1];
    [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].waitDeliverCount integerValue] withIndex:2];

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshWaitFahuo) name:@"refreshWaitFahuo" object:nil];

    /**
    当用户停留在当前页面时收到后台推送的处理情况，不用页面跳转，直接改变swipeView位置，并且刷新数据
     */
    //待发货的情况
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWaitFahuo) name:@"notificationWaitFahuo" object:nil];
    //已完成的情况
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationyetComplet) name:@"notificationyetComplet" object:nil];
    
//    [self performSelector:@selector(waitDelay) withObject:nil afterDelay:3.];

}

//- (void)waitDelay
//{
//    [TTXUserInfo shareUserInfos].shopCompleteCount = @"0";
//    [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].shopCompleteCount integerValue] withIndex:0];
//
//}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    switch (self.orderType) {
        case MallOrderRequetst_yetComplete:
            break;
        case MallOrderRequetst_yetFahuo:
            
            break;
        case MallOrderRequetst_waitFahuo:
            self.swipeView.currentPage = 2;
            break;
        default:
            break;
    }
}


- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"refreshWaitFahuo" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notificationWaitFahuo" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notificationyetComplet" object:nil];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshWaitFahuo
{
    [self.yetFahuoTableView.mj_header beginRefreshing];
    [self.waitFahuoTableView.mj_header beginRefreshing];
    
    NSDictionary *parms = @{@"code":[TTXUserInfo shareUserInfos].code};
    [HttpClient GET:@"mch/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if ([jsonObject[@"data"][@"unreadMchMsgCountVo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *unreadMsgCountVo = jsonObject[@"data"][@"unreadMchMsgCountVo"];
                [TTXUserInfo shareUserInfos].messageCount = NullToNumber(unreadMsgCountVo[@"messageCount"]);
                [TTXUserInfo shareUserInfos].withdrawCount = NullToNumber(unreadMsgCountVo[@"withdrawCount"]);
                [TTXUserInfo shareUserInfos].settleCount = NullToNumber(unreadMsgCountVo[@"settleCount"]);
                [TTXUserInfo shareUserInfos].hasDeliveredCount = NullToNumber(unreadMsgCountVo[@"hasDeliveredCount"]);
                [TTXUserInfo shareUserInfos].shopCompleteCount = NullToNumber(unreadMsgCountVo[@"shopCompleteCount"]);
                
                [TTXUserInfo shareUserInfos].waitDeliverCount = NullToNumber(unreadMsgCountVo[@"waitDeliverCount"]);
                [TTXUserInfo shareUserInfos].accountCount = NullToNumber(unreadMsgCountVo[@"accountCount"]);
            }
            [TTXUserInfo shareUserInfos].bindingFlag = NullToNumber(jsonObject[@"data"][@"bankAccountFlag"]);
            [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].shopCompleteCount integerValue] withIndex:0];
            [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].hasDeliveredCount integerValue] withIndex:1];
            [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].waitDeliverCount integerValue] withIndex:2];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];

    
}

#pragma mark - 懒加载
- (UITableView *)yetFahuoTableView
{
    if (!_yetFahuoTableView) {
        _yetFahuoTableView = [[UITableView alloc]init];
        _yetFahuoTableView.delegate = self;
        _yetFahuoTableView.dataSource = self;
        _yetFahuoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _yetFahuoTableView.backgroundColor = [UIColor clearColor];

    }
    return _yetFahuoTableView;
}


- (UITableView *)yetCompleteTableView
{
    if (!_yetCompleteTableView) {
        _yetCompleteTableView  = [[UITableView alloc]init];
        _yetCompleteTableView.delegate = self;
        _yetCompleteTableView.dataSource = self;
        _yetCompleteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _yetCompleteTableView.backgroundColor = [UIColor clearColor];

    }
    return _yetCompleteTableView;
}

- (UITableView *)waitFahuoTableView
{
    if (!_waitFahuoTableView) {
        _waitFahuoTableView = [[UITableView alloc]init];
        _waitFahuoTableView.delegate = self;
        _waitFahuoTableView.dataSource = self;
        _waitFahuoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _waitFahuoTableView.backgroundColor = [UIColor clearColor];


    }
    return _waitFahuoTableView;
}

- (NSMutableArray *)yetFahuoDataSouceArray
{
    if (!_yetFahuoDataSouceArray) {
        _yetFahuoDataSouceArray = [NSMutableArray array];
    }
    return _yetFahuoDataSouceArray;
}

- (NSMutableArray *)waitFahuoDataSouceArray
{
    if (!_waitFahuoDataSouceArray) {
        _waitFahuoDataSouceArray = [NSMutableArray array];
    }
    return _waitFahuoDataSouceArray;
}

- (NSMutableArray *)yetCompleteDataSouceArray
{
    if (!_yetCompleteDataSouceArray) {
        _yetCompleteDataSouceArray = [NSMutableArray array];
    }
    return _yetCompleteDataSouceArray;
}

#pragma mark - 网络数据请求


- (void)getRequestIsHeader:(BOOL)isHeader withPage:(MallOrderRequetstType)requestType withTableview:(UITableView*)tableView withDataSouceArray:(NSMutableArray *)dataSouceArray withPageType:(NSInteger)page
{
    NSDictionary *prams = [NSDictionary dictionary];
    switch (requestType) {
        case MallOrderRequetst_yetFahuo:
            prams = @{@"token":[TTXUserInfo shareUserInfos].token,
                      @"flag":@"2",
                      @"pageNo":@(self.yetFahuoPage),
                      @"pageSize":@(MacoPageSize)};
            break;
        case MallOrderRequetst_waitFahuo:
            prams = @{@"token":[TTXUserInfo shareUserInfos].token,
                      @"flag":@"1",
                      @"pageNo":@(self.waitFahuoPage),
                      @"pageSize":@(MacoPageSize)};
            
            break;
        case MallOrderRequetst_yetComplete:
            prams = @{@"token":[TTXUserInfo shareUserInfos].token,
                      @"flag":@"3",
                      @"pageNo":@(self.yetCompletePage),
                      @"pageSize":@(MacoPageSize)};
            break;
            
        default:
            break;
    }
    
    [HttpClient GET:@"mch/business/shopOrder" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [tableView.mj_header endRefreshing];
                [dataSouceArray removeAllObjects];
            }else{
                [tableView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"data"];
            for (NSDictionary *dic in array) {
                [dataSouceArray addObject:[MallOrderModel modelWithDic:dic]];
            }
            if (array.count > 0) {
                switch (requestType) {
                    case MallOrderRequetst_yetFahuo:
                        self.yetFahuoPage ++;
                        break;
                    case MallOrderRequetst_waitFahuo:
                        self.waitFahuoPage ++;
                        break;
                    case MallOrderRequetst_yetComplete:
                        [TTXUserInfo shareUserInfos].shopCompleteCount = @"0";
                        self.yetCompletePage ++;
                        break;
                        
                    default:
                        break;
                }
            }
  
            [tableView reloadData];
            [tableView judgeIsHaveDataSouce:dataSouceArray];
            return ;
        }
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (isHeader) {
            [tableView.mj_header endRefreshing];
        }else{
            [tableView.mj_footer endRefreshing];
        }
        [tableView judgeIsHaveDataSouce:dataSouceArray];

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
    return 3;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (nil == view) {
        view = [[UIView alloc] initWithFrame:swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    view.backgroundColor = [UIColor clearColor];
    swipeView.backgroundColor = [UIColor clearColor];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    switch (index) {
        case 0:
        {
            [self removeAllSubviews:view];
            [view addSubview:self.yetCompleteTableView];
//            self.yetCompleteTableView.backgroundColor = [UIColor greenColor];
            [self.yetCompleteTableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 1:
        {
            [self removeAllSubviews:view];
            [view addSubview:self.yetFahuoTableView];
//            self.yetFahuoTableView.backgroundColor = [UIColor orangeColor];
            [self.yetFahuoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 2:
        {
            [self removeAllSubviews:view];
            [view addSubview:self.waitFahuoTableView];
//            self.waitFahuoTableView.backgroundColor = [UIColor redColor];
            [self.waitFahuoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
//            [self.yetCompleteTableView.mj_header beginRefreshing];

            break;
        case 1:
//            [self.yetFahuoTableView.mj_header beginRefreshing];
            break;
        case 2:
//            [self.waitFahuoTableView.mj_header beginRefreshing];
            break;

        default:
            break;
    }
    [self.sortView selectItem:swipeView.currentItemIndex ];
    [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].shopCompleteCount integerValue] withIndex:0];
}




#pragma mark - UITableDataSouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.waitFahuoTableView) {
        return self.waitFahuoDataSouceArray.count;
    }else if (tableView == self.yetFahuoTableView){
        return self.yetFahuoDataSouceArray.count;
    }else{
        return self.yetCompleteDataSouceArray.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaitSendMchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WaitSendMchTableViewCell indentify]];
    if (!cell) {
        cell = [WaitSendMchTableViewCell newCell];
    }
    
    if (tableView == self.waitFahuoTableView) {
        if (self.waitFahuoDataSouceArray.count > 0) {
            cell.dataModel = self.waitFahuoDataSouceArray[indexPath.row];
            cell.orderType = MallOrderRequetst_waitFahuo;
        }
    }else if (tableView == self.yetFahuoTableView){
        if (self.yetFahuoDataSouceArray.count > 0) {
            cell.dataModel = self.yetFahuoDataSouceArray[indexPath.row];
            cell.orderType = MallOrderRequetst_yetFahuo;

        }
    }else{
        
        if (self.yetCompleteDataSouceArray.count > 0) {
            cell.dataModel = self.yetCompleteDataSouceArray[indexPath.row];
            cell.orderType = MallOrderRequetst_yetComplete;

        }
    }

    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 159;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != self.waitFahuoTableView) {
        return;
    }
    DeliveryViewController *deliverVC = [[DeliveryViewController alloc]init];
    if (self.waitFahuoDataSouceArray.count > 0 &&indexPath.row < self.waitFahuoDataSouceArray.count) {
        deliverVC.dataModel = self.waitFahuoDataSouceArray[indexPath.row];
        [self.navigationController pushViewController:deliverVC animated:YES];
    }
}



#pragma mark - 当用户停留在当前页面时收到后台推送的处理情况，不用页面跳转，直接改变swipeView位置，并且刷新数据

- (void)notificationWaitFahuo
{
    NSDictionary *parms = @{@"code":[TTXUserInfo shareUserInfos].code};
    [HttpClient GET:@"mch/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if ([jsonObject[@"data"][@"unreadMchMsgCountVo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *unreadMsgCountVo = jsonObject[@"data"][@"unreadMchMsgCountVo"];
                [TTXUserInfo shareUserInfos].messageCount = NullToNumber(unreadMsgCountVo[@"messageCount"]);
                [TTXUserInfo shareUserInfos].withdrawCount = NullToNumber(unreadMsgCountVo[@"withdrawCount"]);
                [TTXUserInfo shareUserInfos].settleCount = NullToNumber(unreadMsgCountVo[@"settleCount"]);
                [TTXUserInfo shareUserInfos].hasDeliveredCount = NullToNumber(unreadMsgCountVo[@"hasDeliveredCount"]);
                [TTXUserInfo shareUserInfos].shopCompleteCount = NullToNumber(unreadMsgCountVo[@"shopCompleteCount"]);
                
                [TTXUserInfo shareUserInfos].waitDeliverCount = NullToNumber(unreadMsgCountVo[@"waitDeliverCount"]);
                [TTXUserInfo shareUserInfos].accountCount = NullToNumber(unreadMsgCountVo[@"accountCount"]);
            }
            [TTXUserInfo shareUserInfos].bindingFlag = NullToNumber(jsonObject[@"data"][@"bankAccountFlag"]);
            [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].waitDeliverCount integerValue] withIndex:2];
            [self.waitFahuoTableView.mj_header beginRefreshing];
            self.swipeView.currentPage = 2;
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

- (void)notificationyetComplet
{
    NSDictionary *parms = @{@"code":[TTXUserInfo shareUserInfos].code};
    [HttpClient GET:@"mch/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if ([jsonObject[@"data"][@"unreadMchMsgCountVo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *unreadMsgCountVo = jsonObject[@"data"][@"unreadMchMsgCountVo"];
                [TTXUserInfo shareUserInfos].messageCount = NullToNumber(unreadMsgCountVo[@"messageCount"]);
                [TTXUserInfo shareUserInfos].withdrawCount = NullToNumber(unreadMsgCountVo[@"withdrawCount"]);
                [TTXUserInfo shareUserInfos].settleCount = NullToNumber(unreadMsgCountVo[@"settleCount"]);
                [TTXUserInfo shareUserInfos].hasDeliveredCount = NullToNumber(unreadMsgCountVo[@"hasDeliveredCount"]);
                [TTXUserInfo shareUserInfos].shopCompleteCount = NullToNumber(unreadMsgCountVo[@"shopCompleteCount"]);
                
                [TTXUserInfo shareUserInfos].waitDeliverCount = NullToNumber(unreadMsgCountVo[@"waitDeliverCount"]);
                [TTXUserInfo shareUserInfos].accountCount = NullToNumber(unreadMsgCountVo[@"accountCount"]);
            }
            [self.sortView setNumberForItem:[[TTXUserInfo shareUserInfos].shopCompleteCount integerValue] withIndex:0];
            [self.yetCompleteTableView.mj_header beginRefreshing];
            self.swipeView.currentPage = 0;
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
