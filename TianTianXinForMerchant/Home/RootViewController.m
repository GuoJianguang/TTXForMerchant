//
//  RootViewController.m
//  天添薪
//
//  Created by ttx on 16/1/19.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "RootViewController.h"
#import "MyWalletDetailViewController.h"
#import "StoreJiesuanViewController.h"
#import "MyMessageListViewController.h"
#import "MyAccountInDetailViewController.h"
#import "MallOrderViewController.h"


static NSString *infomation  = @"infomation";//消息列表
static NSString *settle  = @"settle";//结算统计
static NSString *withdraw  = @"withdraw";//账户提现
static NSString *account  = @"account";//账户收入
static NSString *mchWaitDeliver  = @"mchWaitDeliver";//待发货
static NSString *hasComplete  = @"hasComplete";//已完成

@interface RootViewController ()<UIAlertViewDelegate>

@property (nonatomic, copy)NSString *turnType;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self autoLogin];
    //接收的推送
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fanxian:) name:Upush_Notifi object:nil];
    
    //自动登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLogin) name:AutoLoginAfterGetDeviceToken object:nil];

}

#pragma mark - 当进入程序有推送的时候执行此方法
- (void)notifica:(NSDictionary *)notifiInfo
{
    if ([TTXUserInfo shareUserInfos].currentLogined) {
        self.turnType = NullToSpace(notifiInfo[@"page"]);
        NSString *alerInfo = NullToSpace(notifiInfo[@"aps"][@"alert"]);
        if (![self.turnType isEqualToString:infomation] &&![self.turnType isEqualToString:settle]&&![self.turnType isEqualToString:withdraw]&&![self.turnType isEqualToString:account]&&![self.turnType isEqualToString:mchWaitDeliver]&&![self.turnType isEqualToString:hasComplete]) {
            UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [showView show];
            showView.tag = 20;
            return;
        }
        [self getRefrshOrderInfo];
        UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去看看", nil];
        showView.tag = 10;
        [showView show];
    }
}

//接收返现信息的推送
- (void)fanxian:(NSNotification *)faication
{
    if ([TTXUserInfo shareUserInfos].currentLogined) {
        self.turnType = NullToSpace(faication.userInfo[@"page"]);
        NSString *alerInfo = NullToSpace(faication.userInfo[@"aps"][@"alert"]);
        if (![self.turnType isEqualToString:infomation] &&![self.turnType isEqualToString:settle]&&![self.turnType isEqualToString:withdraw]&&![self.turnType isEqualToString:account]&&![self.turnType isEqualToString:hasComplete]&&![self.turnType isEqualToString:mchWaitDeliver]) {
            UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            showView.tag = 20;
            
            [showView show];
            return;
        }
        [self getRefrshOrderInfo];
        UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去看看", nil];
        showView.tag = 10;
        [showView show];
    }
}
//账户提现信息推送

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10 && buttonIndex == 1) {
        if ([self.turnType isEqualToString:infomation]) {//消息列表
            MyMessageListViewController *listVC = [[MyMessageListViewController alloc]init];
            [self pushViewController:listVC animated:YES];
        }else if([self.turnType isEqualToString:withdraw]){//账户提现
            MyWalletDetailViewController *detailVC = [[MyWalletDetailViewController alloc]init];
            detailVC.selectType = MYWallecttype_tixian;
            [self pushViewController:detailVC animated:YES];
        }else if([self.turnType isEqualToString:settle]){//结算统计
            StoreJiesuanViewController *jiesuanVC = [[StoreJiesuanViewController alloc]init];
            [self pushViewController:jiesuanVC animated:YES];
        }else if([self.turnType isEqualToString:account]){//账户收入
            MyAccountInDetailViewController *detailVC = [[MyAccountInDetailViewController alloc]init];
            [self pushViewController:detailVC animated:YES];
        }else if([self.turnType isEqualToString:mchWaitDeliver]){//商城订单待发货
            if ([self.topViewController isKindOfClass:[MallOrderViewController class]]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"notificationWaitFahuo" object:nil userInfo:nil];
                
                return;
            }
            MallOrderViewController *mallVC = [[MallOrderViewController alloc]init];
            mallVC.orderType = MallOrderRequetst_waitFahuo;
            [self pushViewController:mallVC animated:YES];
        }else if([self.turnType isEqualToString:hasComplete]){//商城订单已完成
            if ([self.topViewController isKindOfClass:[MallOrderViewController class]]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"notificationyetComplet" object:nil userInfo:nil];

                return;
            }
            MallOrderViewController *mallVC = [[MallOrderViewController alloc]init];
            mallVC.orderType = MallOrderRequetst_yetComplete;
            [self pushViewController:mallVC animated:YES];
        }
        return;
    }else if(alertView.tag == 20){
        return;
    }else if(alertView.tag == 10 && buttonIndex == 0){
        return;
    }else{
        //去登录
            UINavigationController *logvc = [LoginViewController controller];
            [self presentViewController:logvc animated:YES completion:NULL];
    }
}

#pragma mark - 自动登录
- (void)autoLogin
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:LoginUserPassword]) {
        NSString *password = [[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserPassword],PasswordKey]md5_32];
        NSDictionary *parms = @{
                                @"phone":[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName],
                                @"deviceToken":[TTXUserInfo shareUserInfos].devicetoken,
                                @"deviceType":@"ios",
                                @"password":password};
        [HttpClient POST:@"mch/login" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                //设置用户信息
                [TTXUserInfo shareUserInfos].currentLogined = YES;
                [[TTXUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
                //统计新增用户
                [MobClick profileSignInWithPUID:[TTXUserInfo shareUserInfos].userid];
                if ([TTXUserInfo shareUserInfos].islaunchFormNotifi) {
                    [self notifica:[TTXUserInfo shareUserInfos].notificationParms];
                    [TTXUserInfo shareUserInfos].islaunchFormNotifi = NO;
                }
                return ;
            }
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:IsFirstLaunch
             ];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //接收的推送
    [[NSNotificationCenter defaultCenter]removeObserver:self name:Upush_Notifi object:nil];
    //自动登录
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AutoLoginAfterGetDeviceToken object:nil];
}


#pragma mark - 更新本地订单数据
- (void)getRefrshOrderInfo
{
//    self.navigationController
    NSDictionary *parms = @{@"code":NullToSpace([TTXUserInfo shareUserInfos].code)};
    [HttpClient GET:@"mch/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
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
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}


@end
