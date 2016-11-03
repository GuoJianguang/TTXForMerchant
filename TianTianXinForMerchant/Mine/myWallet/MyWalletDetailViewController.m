//
//  MyWalletDetailViewController.m
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyWalletDetailViewController.h"
#import "MyWallectCollectionViewCell.h"


@interface MyWalletDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,BasenavigationDelegate>

@property (nonatomic, assign)NSInteger page;//页数

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@end

@implementation MyWalletDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.selectType) {
        case MYWallecttype_accountIn:
        {
            self.naviBar.title = @"账户收入";
            self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                self.page = 1;
                [self accountInRequestIsHeader:YES];
            }];
            self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                [self accountInRequestIsHeader:NO];
            }];
            [self.collectionView addNoDatasouceWithCallback:^{
                [self.collectionView.mj_header beginRefreshing];
            } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
        }
            break;
        case MYWallecttype_tixian:
        {
            self.naviBar.title = @"账户提现";
            self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                self.page = 1;
                [self tixianRequestIsHeader:YES];
            }];
            self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                [self tixianRequestIsHeader:NO];
            }];
            [self.collectionView addNoDatasouceWithCallback:^{
                [self.collectionView.mj_header beginRefreshing];
            } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
        }
            break;
        default:
            break;
    }
    
    [self.collectionView addNoDatasouceWithCallback:^{
        [self.collectionView.mj_header beginRefreshing];
    } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
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


#pragma mark - 导航栏右边按钮点击事件
- (void)detailBtnClick
{
    BaseHtmlViewController *htmlVC = [[BaseHtmlViewController alloc]init];
    htmlVC.htmlUrl = @"http://www.tiantianxcn.com/html5/forapp/getMoney-roler.html";
    htmlVC.htmlTitle = @"返现规则";
    [self.navigationController pushViewController:htmlVC animated:YES];
}


#pragma mark - 数据请求


static NSInteger pageSize = 10;
//账户收入
- (void)accountInRequestIsHeader:(BOOL)isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":@(pageSize),
                            @"token":[TTXUserInfo shareUserInfos].token};
    [HttpClient POST:@"mch/withdraw/list" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.collectionView.mj_header endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
//            for (NSDictionary *dic in array) {
//                [self.dataSouceArray addObject:[XiaofeiModel modelWithDic:dic]];
//            }
            //判断数据源有无数据
            [self.collectionView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.collectionView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (isHeader) {
            [self.collectionView.mj_header endRefreshing];
        }else{
            [self.collectionView.mj_footer endRefreshing];
        }
        [self.collectionView showRereshBtnwithALerString:@"网络连接不好"];

    }];
}

//提现记录
- (void)tixianRequestIsHeader:(BOOL)isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":@(pageSize),
                            @"token":[TTXUserInfo shareUserInfos].token};
    [HttpClient POST:@"mch/withdraw/list" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.collectionView.mj_header endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.dataSouceArray addObject:[MYWallectTixianModel modelWithDic:dic]];
            }
            //判断数据源有无数据
            [self.collectionView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.collectionView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (isHeader) {
            [self.collectionView.mj_header endRefreshing];
        }else{
            [self.collectionView.mj_footer endRefreshing];
        }
        [self.collectionView showRereshBtnwithALerString:@"网络连接不好"];
    }];
}




#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
//    return 10;
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
    switch (self.selectType) {
        case MYWallecttype_accountIn:
//            cell.fanXianDataModel = self.dataSouceArray[indexPath.item];
            break;
        case MYWallecttype_tixian:
            cell.tixianModel = self.dataSouceArray[indexPath.item];
            break;
        default:
            break;
    }
    nibri=NO;
    return cell;
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



//每个cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
