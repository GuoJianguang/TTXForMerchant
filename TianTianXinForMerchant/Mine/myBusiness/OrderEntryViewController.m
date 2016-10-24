//
//  OrderEntryViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "OrderEntryViewController.h"
#import "Verify.h"
#import "LBXScanViewStyle.h"
#import "SubLBXScanViewController.h"
#import "WithDrawalResultView.h"
#import "SureOrderView.h"
#import "OrderEntryTableViewCell.h"

@interface OrderEntryViewController ()<UITextFieldDelegate,BasenavigationDelegate,SureOrderDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)WithDrawalResultView *resultView;
@property (nonatomic, strong)SureOrderView *sureOrderView;

@end

@implementation OrderEntryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"订单录入";
    self.naviBar.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.isResultView = NO;;
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 520;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OrderEntryTableViewCell indentify]];
    if (!cell) {
        cell = [OrderEntryTableViewCell newCell];
    }
    return cell;
}


- (WithDrawalResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[WithDrawalResultView alloc]init];
        _resultView.alerLabel.text = @"录入成功";
        
    }
    return _resultView;
}

- (SureOrderView *)sureOrderView
{
    if (!_sureOrderView) {
        _sureOrderView = [[SureOrderView alloc]init];
    }
    return _sureOrderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backBtnClick
{
    if (self.isResultView) {
        [self.resultView removeFromSuperview];
        self.isResultView = NO;
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"scanResultSuccess" object:nil];
}

#pragma mark - 扫二维码
- (void)scan
{
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)withDrawalSuccess
{
    [self.view addSubview:self.resultView];
    self.isResultView = YES;
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)addSureOrderView:(NSString *)phone withOrderMoney:(NSString *)orderMoney withyuePay:(NSString *)yuePayStr withCash:(NSString *)cash withTime:(NSString *)time withIsYestoday:(BOOL)isYestoDay;
{
    self.sureOrderView.delegate = self;
    self.sureOrderView.phoneLabel.text = phone;
    self.sureOrderView.balanceMoneyLabel.text = orderMoney;
    self.sureOrderView.balancePay.text = yuePayStr;
    self.sureOrderView.cashLabel.text = cash;
    self.sureOrderView.timeLabel.text = time;
    if (isYestoDay) {
        self.sureOrderView.isYestodayOder = 1;
    }else{
        self.sureOrderView.isYestodayOder = 0;
    }
    [self.navigationController.view addSubview:self.sureOrderView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.sureOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationController.view).insets(insets);
    }];
}


#pragma mark - SureOrderDelegate
- (void)sureSuccess
{
    [self.sureOrderView removeFromSuperview];
    self.resultView.isorderEntry = YES;
    [self withDrawalSuccess];
    [self.tableView reloadData];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
