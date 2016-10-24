//
//  BussessAllCommentViewController.m
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BussessAllCommentViewController.h"
#import "BussesscommentDetailTableViewCell.h"

@interface BussessAllCommentViewController ()<UITableViewDataSource,UITableViewDelegate,BasenavigationDelegate>
@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, assign)NSInteger page;

@end

@implementation BussessAllCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"所有评论";
    self.naviBar.delegate = self;
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 64, TWitdh, THeight-64);
    self.tableView.hidden = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    __weak BussessAllCommentViewController *weak_self = self;
    //优质商家的数据请求
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.page = 1;
        [weak_self commentReqest:YES];
    }];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self commentReqest:NO];
        
    }];

    [self.tableView.mj_header beginRefreshing];
    
    
    [self.tableView addNoDatasouceWithCallback:^{
        [weak_self.tableView.mj_header beginRefreshing];
    } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
    
    self.tableView.layer.cornerRadius = 8;
    self.tableView.layer.masksToBounds = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(relpaySuccess) name:@"replaySuccess" object:nil];


}
- (void)relpaySuccess
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"replaySuccess" object:nil];

}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
    }
    return _tableView;
}

//每页条数
static NSInteger pangeCount = 10;



- (void)commentReqest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"mchCode":self.code,
                            @"pageNo":@(self.page),
                            @"pageSize":@(pangeCount)};
    
    [HttpClient GET:@"mch/comment" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
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
            CGFloat tableHeight = 0;
            for (NSDictionary *dic in array) {
                BussessComment *comment = [BussessComment modelWithDic:dic];
                [self.dataSouceArray addObject:comment];
            }
            
            BussessComment *comment1 = [[BussessComment alloc]init];
            comment1.content = @"点击当会计课佳节快到家 记得哦我就到家当空间看大家快点放假啊姐姐地久服务看到就卡即可大家分开健康大家分开撒娇发的空间打开了减肥的空间当空间的空间打开垃圾的空间当空间疯狂啦时间的疯狂减肥的空间疯狂啦手机发的空间放的开减肥的空间发的快乐手机发的哭了说减肥的了空间打开减肥的空间fdklj";
            comment1.commentId = @"12";
            comment1.mchName = @"222";
            comment1.createTime = @"2016.2.3";
            comment1.userNickName = @"但都没看到";
//            [self.dataSouceArray addObject:comment1];
//            [self.dataSouceArray addObject:comment1];

//            [self.dataSouceArray removeAllObjects];
//            for (BussessComment *comment in self.dataSouceArray) {
//                tableHeight += tableHeight +[self cellHeight:comment.content];
//            }
//            if (tableHeight < THeight - 74 - 20) {
//                self.tableView.frame =CGRectMake(12, 75, TWitdh - 24, tableHeight);
//            }else{
//                self.tableView.frame = CGRectMake(12, 75, TWitdh - 24, THeight - 74-20);
//            }
            
//            if (self.dataSouceArray.count == 0) {
//                self.tableView.frame = CGRectMake(12, 75, TWitdh - 24, THeight - 74-20);
//            }
            //判断数据源有无数据
            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView showRereshBtnwithALerString:@"网络连接不好"];
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
}


- (NSMutableArray *)dataSouceArray
{
    if(!_dataSouceArray){
        _dataSouceArray = [NSMutableArray array];
    }
    
    return _dataSouceArray;
}

#pragma mark - UITableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSouceArray.count > 0) {
        BussessComment *comment = self.dataSouceArray[indexPath.row];
        if (comment.replyFlag) {
            return 60 +[self cellHeight:comment.content] + [self replayCellHeight:[NSString stringWithFormat:@"商家回复:%@",comment.replyContent]] + 14;
        }
        return 60 +[self cellHeight:comment.content] + 20;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BussesscommentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BussesscommentDetailTableViewCell indentify]];
    
    if (!cell) {
        cell = [BussesscommentDetailTableViewCell newCell];
    }
    if (self.dataSouceArray.count > 0) {
        cell.dataModel = self.dataSouceArray[indexPath.row];
        if (cell.dataModel.replyFlag) {
            cell.replayHeight.constant =  [self replayCellHeight:[NSString stringWithFormat:@"商家回复:%@",cell.dataModel.replyContent]] + 14;
        }
    }
    return cell;
}

- (CGFloat)cellHeight:(NSString *)textSting
{
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh  - 32, 0) font:[UIFont systemFontOfSize:12]];
    return size.height;
}


- (CGFloat)replayCellHeight:(NSString *)textSting
{
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh  - 48, 0) font:[UIFont systemFontOfSize:12]];
    return size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
