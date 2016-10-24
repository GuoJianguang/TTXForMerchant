//
//  MineViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/18.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MineViewController.h"
#import "MyWalletView.h"
#import "MyWithDrawalView.h"
#import "MyBusinessView.h"
#import "MyAssociatedStore.h"
#import "MyMessageView.h"
#import "MyInfoEditViewController.h"


@interface MineViewController ()<BasenavigationDelegate>


//我的钱包
@property (nonatomic, strong)MyWalletView *myWalletView;

//我的提现
@property (nonatomic, strong)MyWithDrawalView *myWithDrawalView;
//我的店铺营业
@property (nonatomic, strong)MyBusinessView *myBussinessView;
//关联店铺
@property (nonatomic, strong)MyAssociatedStore *myAssociatedStoreView;
//我的消息
@property (nonatomic, strong)MyMessageView *myMessageView;

@end


@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"我的";
    self.naviBar.backTitle = @"联系客服";
    self.naviBar.hiddenBackBtn = YES;
    self.naviBar.hiddenBackBtnImage = YES;
    self.naviBar.delegate = self;
    self.naviBar.hiddenDetailBtn = NO;
    [self.naviBar.detail_btn setImage:[UIImage imageNamed:@"icon_set"] forState:UIControlStateNormal];
    self.mark1.hidden = NO;
    self.mark2.hidden = YES;self.mark3.hidden = YES;self.mark4.hidden = YES;self.mark5.hidden = YES;
    [self functionItem:self.myWallet withImageNamed:@"icon_wallet_sel" title:@"我的钱包"];
    [self functionItem:self.mywithdrawal withImageNamed:@"icon_withdraw_nor" title:@"我的提现"];
    [self functionItem:self.myBusiness withImageNamed:@"icon_shop-business_nor" title:@"店铺营业"];
    [self functionItem:self.myAssociatedStore withImageNamed:@"icon_associated_nor" title:@"关联店铺"];
    [self functionItem:self.myMessage withImageNamed:@"icon_message_nor" title:@"消息"];
    self.myWallet.textColor = MacoColor;
    [self.item_view sendSubviewToBack:self.blackView];
    self.backImageView.image = [UIImage imageNamed:@"my_center_backgound"];
    self.backImageView.layer.masksToBounds = YES;
    self.backHeght.constant = THeight*(394/1334.);
    [self addWalletView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logout:) name:LogOutNSNotification object:nil];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSDictionary *parms = @{@"code":[TTXUserInfo shareUserInfos].code};
    [HttpClient GET:@"mch/get" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
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
            
//            [[TTXUserInfo shareUserInfos] setUserinfoWithdic:jsonObject[@"data"]];
            
            self.mywithdrawal.showAlerNumber = NO;
            if ([[TTXUserInfo shareUserInfos].bindingFlag isEqualToString:@"1"]) {
                self.mywithdrawal.showAlerLabel = NO;
            }else{
                self.mywithdrawal.showAlerLabel = YES;
            }
            //设置我的消息气泡提示
            self.myMessage.alerTitle = [TTXUserInfo shareUserInfos].messageCount;
            if ([self.myMessage.alerTitle isEqualToString:@"0"]) {
                self.myMessage.showAlerLabel = NO;
            }else{
                self.myMessage.showAlerLabel = YES;
            }
            //设置我的钱包气泡提示 
            NSInteger mywalletCount = [[TTXUserInfo shareUserInfos].withdrawCount integerValue] + [[TTXUserInfo shareUserInfos].accountCount integerValue];
            self.myWallet.alerTitle = [NSString stringWithFormat:@"%ld",(long)mywalletCount];
            if ([self.myWallet.alerTitle isEqualToString:@"0"]) {
                self.myWallet.showAlerLabel = NO;
            }else{
                self.myWallet.showAlerLabel = YES;
            }
            [self.myWalletView updataInfo];
            [self.myWithDrawalView updataInfo];
            //设置我的店铺营业气泡提示
            
            self.myBusiness.alerTitle = [NSString stringWithFormat:@"%d",[[TTXUserInfo shareUserInfos].waitDeliverCount integerValue] + [[TTXUserInfo shareUserInfos].hasDeliveredCount integerValue] + [[TTXUserInfo shareUserInfos].shopCompleteCount integerValue]];
            if ([self.myBusiness.alerTitle isEqualToString:@"0"]) {
                self.myBusiness.showAlerLabel = NO;
            }else{
                self.myBusiness.showAlerLabel = YES;
            }
            [self.myBussinessView updataInfo];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

- (void)viewAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    }


- (void)logout:(NSNotification *)notification
{
    self.tabBarController.selectedIndex = 0;
}


#pragma mark - 设置分类

-(void) functionItem:(HomeVerticalBtn*)item withImageNamed:(NSString*) imageName title:(NSString*)title{
    item.imageView.image = [UIImage imageNamed:imageName];
    item.textLabel.text = title;
}

#pragma mark - 联系客服
- (void)backBtnClick
{
    UIWebView *webView = (UIWebView*)[self.view viewWithTag:1000];
    if (!webView) {
        webView = [[UIWebView alloc]init];
    }
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4001028997"]]]];
    [self.view addSubview:webView];
}


#pragma mark - 设置
- (void)detailBtnClick
{
    MyInfoEditViewController *editVC = [[MyInfoEditViewController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
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


- (IBAction)itemAction:(id)sender {
    NSInteger tag = ((UIButton *)sender).tag;
    for (int i = 100; i < 105; i ++) {
        ((HomeVerticalBtn *)[self.item_view viewWithTag:i]).textColor = [UIColor whiteColor];
    }
    ((HomeVerticalBtn *)[self.item_view viewWithTag:tag + 90]).textColor = MacoColor;
    switch (tag) {
        case 10://我的钱包
        {
            [self addWalletView];
            self.mark1.hidden = NO;
            self.mark2.hidden = YES;self.mark3.hidden = YES;self.mark4.hidden = YES;self.mark5.hidden = YES;
            [self functionItem:self.myWallet withImageNamed:@"icon_wallet_sel" title:@"我的钱包"];
            [self functionItem:self.mywithdrawal withImageNamed:@"icon_withdraw_nor" title:@"我的提现"];
            [self functionItem:self.myBusiness withImageNamed:@"icon_shop-business_nor" title:@"店铺营业"];
            [self functionItem:self.myAssociatedStore withImageNamed:@"icon_associated_nor" title:@"关联店铺"];
            [self functionItem:self.myMessage withImageNamed:@"icon_message_nor" title:@"消息"];
        }
            break;
        case 11://我的提现
        {
            [self addwihtDaraView];
            self.mark1.hidden = YES;
            self.mark2.hidden = NO;self.mark3.hidden = YES;self.mark4.hidden = YES;self.mark5.hidden = YES;
            [self functionItem:self.myWallet withImageNamed:@"icon_wallet_nor" title:@"我的钱包"];
            [self functionItem:self.mywithdrawal withImageNamed:@"icon_withdraw_sel" title:@"我的提现"];
            [self functionItem:self.myBusiness withImageNamed:@"icon_shop-business_nor" title:@"店铺营业"];
            [self functionItem:self.myAssociatedStore withImageNamed:@"icon_associated_nor" title:@"关联店铺"];
            [self functionItem:self.myMessage withImageNamed:@"icon_message_nor" title:@"消息"];
        }
            break;
        case 12://店铺营业
        {
            [self addBussinessView];
            self.mark1.hidden = YES;
            self.mark2.hidden = YES;self.mark3.hidden = NO;self.mark4.hidden = YES;self.mark5.hidden = YES;
            [self functionItem:self.myWallet withImageNamed:@"icon_wallet_nor" title:@"我的钱包"];
            [self functionItem:self.mywithdrawal withImageNamed:@"icon_withdraw_nor" title:@"我的提现"];
            [self functionItem:self.myBusiness withImageNamed:@"icon_shop-business_sel" title:@"店铺营业"];
            [self functionItem:self.myAssociatedStore withImageNamed:@"icon_associated_nor" title:@"关联店铺"];
            [self functionItem:self.myMessage withImageNamed:@"icon_message_nor" title:@"消息"];
        }
            
            break;
        case 13://关联店铺
        {
            [self addAssociatedStoreView];
            self.mark1.hidden = YES;
            self.mark2.hidden = YES;self.mark3.hidden = YES;self.mark4.hidden = NO;self.mark5.hidden = YES;
            [self functionItem:self.myWallet withImageNamed:@"icon_wallet_nor" title:@"我的钱包"];
            [self functionItem:self.mywithdrawal withImageNamed:@"icon_withdraw_nor" title:@"我的提现"];
            [self functionItem:self.myBusiness withImageNamed:@"icon_shop-business_nor" title:@"店铺营业"] ;
            [self functionItem:self.myAssociatedStore withImageNamed:@"icon_associated_sel" title:@"关联店铺"];
            [self functionItem:self.myMessage withImageNamed:@"icon_message_nor" title:@"消息"];
        }
            break;
        case 14://消息
        {
            [TTXUserInfo shareUserInfos].messageCount = @"0";
            self.myMessage.showAlerLabel = NO;
            self.mark1.hidden = YES;
            self.mark2.hidden = YES;self.mark3.hidden = YES;self.mark4.hidden = YES;self.mark5.hidden = NO;
            [self functionItem:self.myWallet withImageNamed:@"icon_wallet_nor" title:@"我的钱包"];
            [self functionItem:self.mywithdrawal withImageNamed:@"icon_withdraw_nor" title:@"我的提现"];
            [self functionItem:self.myBusiness withImageNamed:@"icon_shop-business_nor" title:@"店铺营业"];
            [self functionItem:self.myAssociatedStore withImageNamed:@"icon_associated_nor" title:@"关联店铺"];
            [self functionItem:self.myMessage withImageNamed:@"icon_message_sel" title:@"消息"];
            [self addmyMessageView];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 我的钱包
- (MyWalletView *)myWalletView
{
    if (!_myWalletView) {
        _myWalletView = [[MyWalletView alloc]init];
    }
    return _myWalletView;
}

//加载钱包的view
- (void)addWalletView
{
    for (UIView *view in self.detailView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.detailView addSubview:self.myWalletView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.myWalletView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.detailView).insets(insets);
    }];
    [self.myWalletView updataInfo];
}


#pragma mark - 我的提现
- (MyWithDrawalView *)myWithDrawalView
{
    if (!_myWithDrawalView) {
        _myWithDrawalView = [[MyWithDrawalView alloc]init];
    }
    return _myWithDrawalView;
}

- (void)addwihtDaraView
{
    for (UIView *view in self.detailView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.detailView addSubview:self.myWithDrawalView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.myWithDrawalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.detailView).insets(insets);
    }];
    [self.myWithDrawalView updataInfo];

}


#pragma mark - 店铺营业

- (MyBusinessView *)myBussinessView
{
    if (!_myBussinessView) {
        _myBussinessView = [[MyBusinessView alloc]init];
    }
    return _myBussinessView;
}

- (void)addBussinessView
{
    for (UIView *view in self.detailView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.detailView addSubview:self.myBussinessView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.myBussinessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.detailView).insets(insets);
    }];
    [self.myBussinessView updataInfo];
}

#pragma mark - 关联店铺
- (MyAssociatedStore *)myAssociatedStoreView
{
    if (!_myAssociatedStoreView) {
        _myAssociatedStoreView = [[MyAssociatedStore alloc]init];
    }
    return _myAssociatedStoreView;

}

- (void)addAssociatedStoreView
{
    for (UIView *view in self.detailView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.detailView addSubview:self.myAssociatedStoreView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.myAssociatedStoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.detailView).insets(insets);
    }];
}


#pragma mark - 我的消息
- (MyMessageView *)myMessageView
{
    if (!_myMessageView) {
        _myMessageView = [[MyMessageView alloc]init];
    }
    return _myMessageView;
}

- (void)addmyMessageView
{
    for (UIView *view in self.detailView.subviews) {
        [view removeFromSuperview];
    }
    [self.detailView addSubview:self.myMessageView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.myMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.detailView).insets(insets);
    }];
    [self.myMessageView updataInfo];
}


@end
