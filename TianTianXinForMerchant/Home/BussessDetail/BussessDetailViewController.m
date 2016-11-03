//
//  BussessDetailViewController.m
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BussessDetailViewController.h"
#import "BussessBannerTableViewCell.h"
#import "BussessInfoTableViewCell.h"
#import "BussessinfoDetailTableViewCell.h"
#import "BussessCommentTableViewCell.h"
#import "BussessDetailModel.h"
#import "BussesscommentDetailTableViewCell.h"
#import "UIImage+ColorImage.h"
#import "InformationViewController.h"
#import "MineViewController.h"
#import "PayQrCodeViewController.h"




@interface BussessDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate,BasenavigationDelegate>

@property (nonatomic, strong)NSDictionary *dataSouceDic;

@property (nonatomic, strong)BussessDetailModel *dataModel;

@property (nonatomic, strong)NSMutableArray *commentArray;
@end

@implementation BussessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"我的店铺";
    self.naviBar.hiddenBackBtn = YES;
    self.tabBarController.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.naviBar.delegate = self;
    self.naviBar.detailTitle = @"收款";
    self.naviBar.hiddenDetailBtn = NO;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSString *bussissCode = [[NSUserDefaults standardUserDefaults]objectForKey:MyBussinssCode];
        [self detailRequest:bussissCode];
        [self commentRequest:bussissCode];
    }];
    
    [self.tableView.mj_header beginRefreshing];

    UIColor *itemSelectTintColor = MacoColor;
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      itemSelectTintColor,
      NSForegroundColorAttributeName,
      [UIFont boldSystemFontOfSize:15],
      NSFontAttributeName
      ,nil] forState:UIControlStateSelected];
    self.tabBarController.tabBar.tintColor = itemSelectTintColor;
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:itemSelectTintColor frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(relpaySuccess) name:@"replaySuccess" object:nil];

}

- (void)relpaySuccess
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.tableView reloadData];
    
}
#pragma mark - 商户评论接口请求

- (void)commentRequest:(NSString *)code
{
    NSDictionary *parms = @{@"mchCode":code,
                            @"pageNo":@"1",
                            @"pageSize":@"5"};
    [HttpClient POST:@"mch/comment" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.commentArray removeAllObjects];
            NSArray *array = jsonObject[@"data"][@"data"];
            for (NSDictionary *dic in array) {
                [self.commentArray addObject:[BussessComment modelWithDic:dic]];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

#pragma mark - 商户详情接口请求
- (void)detailRequest:(NSString *)code
{
    NSDictionary *parms = @{@"code":code};
    [HttpClient GET:@"mch/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            self.dataSouceDic = jsonObject[@"data"];
            self.dataModel = [BussessDetailModel modelWithDic:jsonObject[@"data"]];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - UITableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            return TWitdh*(474/750.);
            
            break;
        case 1:
            return 86 + [self cellHeight:self.dataModel.address];
            break;
        case 2:
            return 134 + [self cellHeight:self.dataModel.desc];
            break;
        case 3:
        {
            CGFloat commentHeight = 0;
            for (BussessComment *comment in self.commentArray) {
                if (comment.replyFlag) {
                    commentHeight += 130;
                }else{
                    commentHeight += 100;
                }
            }
            return 110 + commentHeight ;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            BussessBannerTableViewCell *cell = (BussessBannerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[BussessBannerTableViewCell indentify]];
            if (!cell) {
                cell = [BussessBannerTableViewCell newCell];
            }
            cell.dataModel = self.dataModel;
            return cell;
            
        }
            break;
        case 1:
        {
            BussessInfoTableViewCell *cell = (BussessInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[BussessInfoTableViewCell indentify]];
            if (!cell) {
                cell = [BussessInfoTableViewCell newCell];
            }
            cell.dataModel = self.dataModel;
            return cell;
        }
            break;
        case 2:
        {
            BussessinfoDetailTableViewCell *cell = (BussessinfoDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[BussessinfoDetailTableViewCell indentify]];
            if (!cell) {
                cell = [BussessinfoDetailTableViewCell newCell];
            }
            cell.dataModel = self.dataModel;
            return cell;
        }
            break;
        case 3:
        {
            BussessCommentTableViewCell *cell = (BussessCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[BussessCommentTableViewCell indentify]];
            if (!cell) {
                cell = [BussessCommentTableViewCell newCell];
            }
            cell.dataModel = self.dataModel;
            cell.commentArray = self.commentArray;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)cellHeight:(NSString *)textSting
{
    if ([textSting isEqualToString:@""]) {
        textSting = @"这家商家很神秘，什么也没有留下，要不要去探索一下？";
    }
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh - 20 - 30, 0) font:[UIFont systemFontOfSize:13]];
    return size.height;

}
#pragma mark - UITabBarDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isMemberOfClass:[InformationViewController class]]) {
        NSLog(@"information");
        //        if (![TTXUserInfo shareUserInfos].currentLogined) {
        //            //判断是否先登录
        //            [self loginController];
        //            return NO;
        //        }
    }else if([viewController isMemberOfClass:[MineViewController class]]){
        
        if (![TTXUserInfo shareUserInfos].currentLogined) {
            //判断是否先登录
            [self loginController];
            return NO;
        }
        
    }
    return YES;
}

#pragma mark - 登录
- (void)loginController
{
    UINavigationController *navc = [LoginViewController controller];
    [self presentViewController:navc animated:YES completion:NULL];
}

#pragma  mark - 收款
- (void)detailBtnClick
{
    PayQrCodeViewController *payVC = [[PayQrCodeViewController alloc]init];
    payVC.dataModel = self.dataModel;
    [self.navigationController pushViewController:payVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
