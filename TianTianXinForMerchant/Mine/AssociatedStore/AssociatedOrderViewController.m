//
//  AssociatedOrderViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "AssociatedOrderViewController.h"
#import "AssociatedOrederTableViewCell.h"
#import "AssociatedTableViewDataSouce.h"
#import "TimeTableViewCell.h"

@interface AssociatedOrderViewController ()<UITableViewDataSource,UITableViewDelegate,AssociatedSelectDelegate>


@property (nonatomic, strong)UITableView *selectTalbeView;

@property (nonatomic, strong)AssociatedTableViewDataSouce *tableViewDatasouce;
@property (nonatomic, strong)NSMutableArray *dataSocueArray;

@property (nonatomic, strong)NSString *mchCode;
@property (nonatomic, strong)NSString *tranTime;
@property (nonatomic, assign)NSInteger page;

@end

@implementation AssociatedOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //Do any additional set up after loading the  view from its nib.
    self.naviBar.title = @"关联店铺订单";
    self.moneyLabel.textColor = MacoColor;
    self.storeName.textColor = MacoTitleColor;
    self.timeLabel.textColor = MacoTitleColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.selectTalbeView.frame = CGRectMake(0, 45+64, TWitdh, 230);
    [self.view addSubview:self.selectTalbeView];
    self.selectTalbeView.hidden = YES;
    self.selectTalbeView.delegate = self.tableViewDatasouce;
    self.selectTalbeView.dataSource = self.tableViewDatasouce;
    self.selectTalbeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewDatasouce.delegate = self;
    
    
    self.mchCode = @"";
    self.tranTime = @"";
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self associatedRequest:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self associatedRequest:NO];
        
    }];
    [self.tableView addNoDatasouceWithCallback:^{
        [self.tableView.mj_header beginRefreshing];
    } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickStore:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTime:)];
    self.storeName.userInteractionEnabled = YES;
    self.timeLabel.userInteractionEnabled = YES;
    [self.storeName addGestureRecognizer:tap1];
    [self.timeLabel addGestureRecognizer:tap2];
    [self myStoreRequest];
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

#pragma mark - 数据请求
//我的店铺查询
- (void)myStoreRequest
{
    NSDictionary *prams = @{@"token":[TTXUserInfo shareUserInfos].token};
    [HttpClient POST:@"mch/link/mchs" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            self.tableViewDatasouce.type = AssociatedSelcetType_store;
            [self.tableViewDatasouce.storeDataSouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"];
            for (NSDictionary *dic in array) {
                [self.tableViewDatasouce.storeDataSouceArray addObject:[MyStoreModel modelWithDic:dic]];
            }
            MyStoreModel *allStore = [[MyStoreModel alloc]init];
            allStore.mchCode = @"";
            allStore.mchName = @"全部店铺";
            [self.tableViewDatasouce.storeDataSouceArray insertObject:allStore atIndex:0];
            [self.selectTalbeView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {

    }];
}

//关联店铺订单数据查询
- (void)associatedRequest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"mchCode":self.mchCode,
                            @"tranTime":self.tranTime,
                            @"pageNo":@(self.page),
                            @"pageSize":@(MacoPageSize)};
    [HttpClient POST:@"mch/link/orders" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (self.page == 1) {
                self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[ NullToNumber(jsonObject[@"data"][@"sumAmount"]) doubleValue]];
            }
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

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

- (AssociatedTableViewDataSouce *)tableViewDatasouce
{
    if (!_tableViewDatasouce) {
        _tableViewDatasouce = [[AssociatedTableViewDataSouce alloc]init];
    }
    return _tableViewDatasouce;
}

- (UITableView *)selectTalbeView
{
    if (!_selectTalbeView) {
        _selectTalbeView = [[UITableView alloc]init];
    }
    return _selectTalbeView;
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


#pragma mark - 点击事件

- (void)clickStore:(UITapGestureRecognizer*)tap
{
    if (self.tableViewDatasouce.storeDataSouceArray.count == 0) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您暂时还没有关联店铺" duration:1.5];
        return;
    }
    
    self.tableViewDatasouce.type = AssociatedSelcetType_store;
    [UIView animateWithDuration:0.2 animations:^{
        self.mark2.transform=CGAffineTransformMakeRotation(0);
    }];
    self.tableViewDatasouce.tempStr = self.storeName.text;
    //计算高度
    if (self.tableViewDatasouce.storeDataSouceArray.count > 5) {
        self.selectTalbeView.frame = CGRectMake(0, 45+64, TWitdh, 44*5);
    }else{
        self.selectTalbeView.frame = CGRectMake(0, 45+64, TWitdh, 44*self.tableViewDatasouce.storeDataSouceArray.count);
    }
    [self.selectTalbeView reloadData];
    
    self.selectTalbeView.hidden = !self.selectTalbeView.hidden;
    if (self.selectTalbeView.hidden) {
        self.tableView.scrollEnabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.mark1.transform=CGAffineTransformMakeRotation(0);
        }];
    }else{
        self.tableView.scrollEnabled = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.mark1.transform=CGAffineTransformMakeRotation(M_PI);
        }];
    }
}


- (void)clickTime:(UITapGestureRecognizer*)tap
{
    self.tableViewDatasouce.type = AssociatedSelcetType_time;
    [UIView animateWithDuration:0.2 animations:^{
        self.mark1.transform=CGAffineTransformMakeRotation(0);
    }];
    [self.tableViewDatasouce.timeDataSouceArray removeAllObjects];
    [self.tableViewDatasouce.timeDataSouceArray addObjectsFromArray:[self createMonth]];
    self.tableViewDatasouce.tempStr = self.timeLabel.text;
    
    //计算高度
    if (self.tableViewDatasouce.timeDataSouceArray.count > 5) {
        self.selectTalbeView.frame = CGRectMake(0, 45+64, TWitdh, 44*5);
    }else{
        self.selectTalbeView.frame = CGRectMake(0, 45+64, TWitdh, 44*self.tableViewDatasouce.timeDataSouceArray.count);
    }
    
    [self.selectTalbeView reloadData];
    self.selectTalbeView.hidden = !self.selectTalbeView.hidden;
    if (self.selectTalbeView.hidden) {
        self.tableView.scrollEnabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.mark2.transform=CGAffineTransformMakeRotation(0);
        }];
    }else{
        self.tableView.scrollEnabled = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.mark2.transform=CGAffineTransformMakeRotation(M_PI);
        }];
    }
}



#pragma mark - AssociatedSelectDelegate
- (void)selectwithType:(AssociatedSelcetType)selcelType withselceName:(NSString *)name withMchCode:(NSString *)storeCode
{
    self.tableView.scrollEnabled = YES;
    switch (selcelType) {
        case AssociatedSelcetType_store:
        {
            self.storeName.text = name;
            [UIView animateWithDuration:0.2 animations:^{
                self.mark1.transform=CGAffineTransformMakeRotation(0);
            }];
        }
            break;
        case AssociatedSelcetType_time:
        {
            self.timeLabel.text = name;
            if ([name isEqualToString:@"全部时间"]) {
                self.tranTime = @"";
            }else{
                self.tranTime = name;
            }
            [UIView animateWithDuration:0.2 animations:^{
                self.mark2.transform=CGAffineTransformMakeRotation(0);
            }];
        }
            break;
        default:
            break;
    }
    self.selectTalbeView.hidden = YES;
    self.mchCode = storeCode;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 计算月份数
- (NSMutableArray *)createMonth
{
    NSString *newsDate = @"2015-11-01 00:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [NSDate date];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    int month=((int)time)/(3600*24*30)+1;
    
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger nowyear = [dateComponent year];
    NSInteger nowMonth = [dateComponent month];
    
    NSMutableArray *timeArray = [NSMutableArray array];
    
    
    for (int i = 0; i < month;  i++) {
        NSString *time = [NSString string];
        if (nowMonth < 10) {
            time = [NSString stringWithFormat:@"%ld.0%ld",nowyear,nowMonth];
        }else{
            time = [NSString stringWithFormat:@"%ld.%ld",nowyear,nowMonth];
        }
        TimeModel *model = [[TimeModel alloc]init];
        model.time_str = time;
        [timeArray addObject:model];
        nowMonth--;
        if (nowMonth == 0) {
            nowMonth = 12;
            nowyear--;
        }
    }
    TimeModel *allmodel = [[TimeModel alloc]init];
    allmodel.time_str = @"全部时间";
    [timeArray insertObject:allmodel atIndex:0];
    return timeArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
