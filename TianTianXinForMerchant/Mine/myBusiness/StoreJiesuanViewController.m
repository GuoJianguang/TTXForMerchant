//
//  StoreJiesuanViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "StoreJiesuanViewController.h"
#import "MyWallectCollectionViewCell.h"
#import "YetTimeTableViewDataSouce.h"
#import "JiesuanPayViewController.h"


@interface StoreJiesuanViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,YetTimeDelegate>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, assign)NSInteger page;

@property (nonatomic, strong)NSString *jiesuanTime;

@property(nonatomic, strong)UITableView *timeTableView;

@property(nonatomic, strong)YetTimeTableViewDataSouce *timeDataSouce;


@end

@implementation StoreJiesuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"结算统计";
    self.jiesuanTime = @"";
    self.totalSettleAmount.adjustsFontSizeToFitWidth = YES;
    self.totalAmount.adjustsFontSizeToFitWidth = YES;
    self.totalAmount.textColor = MacoColor;
    self.totalSettleAmount.textColor = MacoColor;
    self.time_label.textColor = MacoTitleColor;
    self.totalAmout_label.textColor = MacoTitleColor;
    self.totalSettleAmount_label.textColor = MacoTitleColor;
    self.timeDataSouce.tempSelect = @"全部时间";
    
    self.collectionView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getRequestIshHader:YES andTime:self.jiesuanTime];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getRequestIshHader:NO andTime:self.jiesuanTime];

    }];
    [self.collectionView addNoDatasouceWithCallback:^{
        [self.collectionView.mj_header beginRefreshing];
    } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
    
    self.timeTableView.delegate = self.timeDataSouce;
    self.timeTableView.dataSource = self.timeDataSouce;
    self.timeDataSouce.delegate = self;
    self.timeTableView.frame = CGRectMake(0, 64+45, TWitdh, 221);
    self.timeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.timeTableView.hidden = YES;
    [self.view addSubview:self.timeTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView.mj_header beginRefreshing];
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


- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

//我的邀请详情数据
#pragma mark - 数据请求
- (void)getRequestIshHader:(BOOL)isHeader andTime:(NSString *)timeStr
{
    NSDictionary *parms = @{@"token":[TTXUserInfo shareUserInfos].token,
                            @"settleTime":timeStr,
                            @"pageNo":@(self.page),
                            @"pageSize":@(MacoPageSize)};
    [HttpClient POST:@"mch/business/searchSettles" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        if (IsRequestTrue) {
            CGFloat totalAmount = [NullToNumber(jsonObject[@"data"][@"totalAmount"]) doubleValue];
            self.totalAmount.text =[NSString stringWithFormat:@"￥%.2f", totalAmount];
            CGFloat totalSettleAmout = [NullToNumber(jsonObject[@"data"][@"totalSettleAmount"]) doubleValue];
            self.totalSettleAmount.text = [NSString stringWithFormat:@"￥%.2f",totalSettleAmout];
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
            [self.collectionView judgeIsHaveDataSouce:self.dataSouceArray];
            
            [self.collectionView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isHeader) {
            [self.collectionView.mj_header endRefreshing];
        }else{
            [self.collectionView.mj_footer endRefreshing];
        }
    }];
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
    if (self.dataSouceArray.count > 0) {
        cell.jiesuanDataModel = self.dataSouceArray[indexPath.item];
    }
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AssociateJissuanModel *model = self.dataSouceArray[indexPath.item];
    if ([model.state isEqualToString:@"0"] || [model.state isEqualToString:@"2"]) {
        JiesuanPayViewController *jiesuanVC = [[JiesuanPayViewController alloc]init];
        jiesuanVC.dataModel = model;
        [self.navigationController pushViewController:jiesuanVC animated:YES];
    }
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = collectionView.bounds.size.width;
    return CGSizeMake((width - 2)/2, ((width - 2)/2)*1.2);
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

- (IBAction)selectTime:(id)sender {
    self.timeTableView.hidden = !self.timeTableView.hidden;
    if (self.timeTableView.hidden) {
        self.collectionView.scrollEnabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.markImage.transform=CGAffineTransformMakeRotation(0);
        }];
    }else{
        self.collectionView.scrollEnabled = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.markImage.transform=CGAffineTransformMakeRotation(M_PI);
        }];
    }
}


#pragma mark - YetTimeDelegate
- (void)selectTimeItem:(NSString *)time
{
    if ([time isEqualToString:@"全部时间"]) {
        self.jiesuanTime = @"";
    }else{
        self.jiesuanTime = time;
    }
    self.time_label.text = time;
    self.timeTableView.hidden=YES;
    self.collectionView.scrollEnabled = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.markImage.transform=CGAffineTransformMakeRotation(0);
    }];
    [self.collectionView.mj_header beginRefreshing];
}
@end
