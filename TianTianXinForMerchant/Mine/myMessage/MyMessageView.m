//
//  MyMessageView.m
//  天添薪
//
//  Created by ttx on 16/1/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyMessageView.h"
#import "MyMessageTableViewCell.h"



@interface MyMessageView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *datasouceArray;

@property (nonatomic, assign)NSInteger page;


@end

@implementation MyMessageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"MyMessageView" owner:nil options:nil][0];

        self.backgroundColor = MacoGrayColor;
        self.tableView.backgroundColor = MacoGrayColor;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        __unsafe_unretained __typeof(self) weakSelf = self;

        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [weakSelf alldetailReqest:YES];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self alldetailReqest:NO];
        }];
        [self.tableView addNoDatasouceWithCallback:^{
            [self.tableView.mj_header beginRefreshing];
        } andAlertSting:@"暂无历史记录" andErrorImage:@"pic_2" andRefreshBtnHiden:YES];
        [self.tableView.mj_header beginRefreshing];
    }
    return self;
}

- (void)updataInfo
{
    [self awakeFromNib];
}

- (void)awakeFromNib
{
    self.page = 1;
    [self alldetailReqest:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];


}

- (NSMutableArray *)datasouceArray
{
    if (!_datasouceArray) {
        _datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}

static NSInteger pangeCount = 20;

- (void)alldetailReqest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":@(pangeCount),
                            @"token":[TTXUserInfo shareUserInfos].token};
    [HttpClient GET:@"mch/message/get" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.datasouceArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView hiddenNoDataSouce];
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.datasouceArray addObject:[MessafeModel modelWithDic:dic]];
            }
            //判断数据源有无数据
            [self.tableView judgeIsHaveDataSouce:self.datasouceArray];
            [self.tableView reloadData];
            return;
        }
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView showRereshBtnwithALerString:@"请刷新重试"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView showRereshBtnwithALerString:@"网络连接不好，请刷新重试"];
    }];
}


#pragma mark - UITableView


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasouceArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datasouceArray.count > 0) {
        MessafeModel *model = self.datasouceArray[indexPath.row];
        CGFloat height = [self cellHeight:model.content];
        return 31+25 + height + 16 + 8 + 20 + 20;
    }
    return 31+25 + 100 + 16 + 8 + 20 + 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMessageTableViewCell *cell = (MyMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[MyMessageTableViewCell indentify]];
    if (!cell) {
        cell = [MyMessageTableViewCell newCell];
    }
    cell.item_view.layer.cornerRadius = 8;
    cell.item_view.layer.masksToBounds = YES;
    if (self.datasouceArray.count > 0) {
        cell.dataModel = self.datasouceArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)cellHeight:(NSString *)textSting
{
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh - 20 - 30, 0) font:[UIFont systemFontOfSize:13]];
    return size.height;
}


@end
