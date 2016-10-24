//
//  JiesuanTongJiViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "JiesuanTongJiViewController.h"
#import "MyWallectCollectionViewCell.h"
#import "AssociatedTableViewDataSouce.h"
#import "TimeTableViewCell.h"

@interface JiesuanTongJiViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,AssociatedSelectDelegate>

@property(nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, strong)UITableView *selectTalbeView;
@property (nonatomic, strong)AssociatedTableViewDataSouce *tableViewDatasouce;

@property (nonatomic, strong)NSString *mchCode;
@property (nonatomic, strong)NSString *tranTime;
@property (nonatomic, assign)NSInteger page;

@end

@implementation JiesuanTongJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"结算统计";
    self.totalMoney.textColor = MacoColor;
    self.jiesuanmoney.textColor = MacoColor;
    self.jiesuanmoney.adjustsFontSizeToFitWidth = YES;
    self.totalMoney.adjustsFontSizeToFitWidth = YES;
    
    self.selectTalbeView.frame = CGRectMake(0, 45+64, TWitdh, 230);
    [self.view addSubview:self.selectTalbeView];
    self.selectTalbeView.hidden = YES;
    self.selectTalbeView.delegate = self.tableViewDatasouce;
    self.selectTalbeView.dataSource = self.tableViewDatasouce;
    self.selectTalbeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewDatasouce.delegate = self;

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickStore:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTime:)];
    self.storeName.userInteractionEnabled = YES;
    self.timeLabel.userInteractionEnabled = YES;
    [self.storeName addGestureRecognizer:tap1];
    [self.timeLabel addGestureRecognizer:tap2];
    
    
    self.mchCode = @"";
    self.tranTime = @"";
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getSearchorderRequest:YES];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getSearchorderRequest:NO];
        
    }];
    [self.collectionView addNoDatasouceWithCallback:^{
        [self.collectionView.mj_header beginRefreshing];
    } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
    [self getAllOrderRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
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
#pragma mark - 数据请求

//获取所有数据
- (void)getAllOrderRequest
{
    NSDictionary *prams = @{@"token":[TTXUserInfo shareUserInfos].token};
    [HttpClient POST:@"mch/link/settles" parameters:prams success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        if (IsRequestTrue) {
            self.totalMoney.text = [NSString stringWithFormat:@"￥%.2f",[ NullToNumber(jsonObject[@"data"][@"totalAmount"]) doubleValue]];
            self.jiesuanmoney.text = [NSString stringWithFormat:@"￥%.2f",[ NullToNumber(jsonObject[@"data"][@"totalSettleAmount"]) doubleValue]];
            self.tableViewDatasouce.type = AssociatedSelcetType_store;
            [self.tableViewDatasouce.storeDataSouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"][@"linkMchVo"];
            for (NSDictionary *dic in array) {
                [self.tableViewDatasouce.storeDataSouceArray addObject:[MyStoreModel modelWithDic:dic]];
            }
            MyStoreModel *allStore = [[MyStoreModel alloc]init];
            allStore.mchCode = @"";
            allStore.mchName = @"全部店铺";
            [self.tableViewDatasouce.storeDataSouceArray insertObject:allStore atIndex:0];
            [self.selectTalbeView reloadData];
            
            NSArray *orderArray = jsonObject[@"data"][@"settleList"][@"data"];
            [self.dataSouceArray removeAllObjects];
            for (NSDictionary *dic in orderArray) {
                [self.dataSouceArray addObject:[AssociateJissuanModel modelWithDic:dic]];
            }
            [self.collectionView reloadData];
            [self.collectionView judgeIsHaveDataSouce:self.dataSouceArray];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView showRereshBtnwithALerString:@"服务器忙，请刷新重试"];
    }];
}

//按条件查询
- (void)getSearchorderRequest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"mchCode":self.mchCode,
                            @"settleTime":self.tranTime,
                            @"pageNo":@(self.page),
                            @"pageSize":@(MacoPageSize)};
    
    [HttpClient POST:@"mch/link/searchSettles" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (self.page == 1) {
                self.totalMoney.text = [NSString stringWithFormat:@"￥%.2f",[ NullToNumber(jsonObject[@"data"][@"totalAmount"]) doubleValue]];
                self.jiesuanmoney.text = [NSString stringWithFormat:@"￥%.2f",[ NullToNumber(jsonObject[@"data"][@"totalSettleAmount"]) doubleValue]];
            }
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.collectionView.mj_header endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"settleList"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.dataSouceArray addObject:[AssociateJissuanModel modelWithDic:dic]];
            }
            [self.collectionView reloadData];
            [self.collectionView judgeIsHaveDataSouce:self.dataSouceArray];
            return ;
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isHeader) {
            [self.collectionView.mj_header endRefreshing];
        }else{
            [self.collectionView.mj_footer endRefreshing];
        }
        [self.collectionView showRereshBtnwithALerString:@"服务器忙，请刷新重试"];

    }];

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
        self.collectionView.scrollEnabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.mark1.transform=CGAffineTransformMakeRotation(0);
        }];
    }else{
        self.collectionView.scrollEnabled = NO;
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
        self.collectionView.scrollEnabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.mark2.transform=CGAffineTransformMakeRotation(0);
        }];
    }else{
        self.collectionView.scrollEnabled = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.mark2.transform=CGAffineTransformMakeRotation(M_PI);
        }];
    }
}

#pragma mark - AssociatedSelectDelegate
- (void)selectwithType:(AssociatedSelcetType)selcelType withselceName:(NSString *)name withMchCode:(NSString *)storeCode
{
    self.collectionView.scrollEnabled = YES;
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
    [self.collectionView.mj_header beginRefreshing];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier =[MyWallectCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [MyWallectCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    MyWallectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.jiesuanDataModel = self.dataSouceArray[indexPath.item];
    nibri=NO;
    return cell;
}



//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = collectionView.bounds.size.width;
    return CGSizeMake((width - 2)/2, ((width - 2)/2)*1.1);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    int month=((int)time)/(3600*24*30) + 1;
    
    
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

@end
