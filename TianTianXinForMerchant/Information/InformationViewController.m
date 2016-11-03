//
//  InformationViewController.m
//  天添薪
//
//  Created by ttx on 16/1/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationBannerTableViewCell.h"
#import "InformationDetailTableViewCell.h"
#import "InformationDetailViewController.h"
#import "InformationBannerModel.h"

@interface InformationViewController ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong)NSMutableArray *bannerArray;

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, assign)NSInteger page;


@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.naviBar.title = @"资讯";
    self.naviBar.hiddenBackBtn = YES;
    self.tableView.backgroundColor = [UIColor clearColor];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self alldetailReqest:YES];
        [self getBannerRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self alldetailReqest:NO];

    }];

    [self.tableView.mj_header beginRefreshing];
    [self getBannerRequest];

    [self.tableView addNoDatasouceWithCallback:^{
        [self.tableView.mj_header beginRefreshing];
    } andAlertSting:@"暂时没有数据" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];

}
#pragma mark - 公告的请求
- (void)getTopInfoRequest
{
    [HttpClient POST:@"user/information/title/get" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];

}

#pragma mark - 获取所有滚动显示信息
- (NSMutableArray *)bannerArray
{
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

- (void)getBannerRequest
{
    [HttpClient POST:@"information/recommend" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.bannerArray removeAllObjects];
            NSArray *array = jsonObject[@"data"];
            for (NSDictionary *dic in array) {
                [self.bannerArray addObject:[InformationBannerModel modelWithDic:dic]];
            }
            [self.tableView reloadData];
            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray andBannerArray:self.bannerArray];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
   
    }];
    
}

#pragma mark - 所有资讯数据请求


- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}
//每页条数
static NSInteger pangeCount = 20;

- (void)alldetailReqest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":@(pangeCount)};
    
    [HttpClient GET:@"information/list" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshing];
 
            }
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.dataSouceArray addObject:[InformationBannerModel modelWithDic:dic]];
            }
            //判断数据源有无数据
            //            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray andBannerArray:self.bannerArray];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}




#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        InformationBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[InformationBannerTableViewCell indentify]];
        if (!cell) {
            cell = [InformationBannerTableViewCell newCell];
        }
        cell.dataArray = self.bannerArray;
        return cell;
    }else{
        InformationDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[InformationDetailTableViewCell indentify]];
        if (!cell) {
            cell = [InformationDetailTableViewCell newCell];
        }
        if (self.dataSouceArray.count > 0) {
                    cell.dataModel = self.dataSouceArray[indexPath.row -1];
        }
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return TWitdh*(210/420.)+50+ 8 ;
    }
    return 105;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row !=0 ) {
        InformationBannerModel *model = self.dataSouceArray[indexPath.row -1];
        InformationDetailViewController *detailVC = [[InformationDetailViewController alloc]init];
        detailVC.htmlUrl = model.detailUrl;
        detailVC.dataModel = model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
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
