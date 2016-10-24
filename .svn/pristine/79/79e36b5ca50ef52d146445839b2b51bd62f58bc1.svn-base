//
//  TTXUserInfo.h
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


//用于保存登录信息

@interface TTXUserInfo : NSObject

+ (TTXUserInfo *)shareUserInfos;

//是否处于登录状态
@property (nonatomic,assign) BOOL currentLogined;
//设备token
@property (nonatomic, copy)NSString *devicetoken;

//我的商户号
@property (nonatomic, copy)NSString *code;

//头像路径
@property (nonatomic, copy)NSString *avatar;
//余额
@property (nonatomic, copy)NSString *aviableBalance;
@property (nonatomic, copy)NSString *userid;
//昵称
@property (nonatomic, copy)NSString *nickName;
//省
@property (nonatomic, copy)NSString *province;
//会话标识，用于获取用户登录信息
@property (nonatomic, copy)NSString *token;
//总消费金额
@property (nonatomic, copy)NSString *totalConsumeAmount;
//待返现金额
@property (nonatomic, copy)NSString *totalExpectAmount;
//未参与返现金额
@property (nonatomic, copy)NSString *wiatJoinAmunt;
//区县
@property (nonatomic, copy)NSString *zone;
//市
@property (nonatomic, copy)NSString *city;
//是否绑定银行卡
@property (nonatomic, copy)NSString *bindingFlag;
//等级
@property (nonatomic, copy)NSString *grade;
//积分
@property (nonatomic, copy)NSString *integral;
//银行卡账户
@property (nonatomic, copy)NSString *bankAccount;
//银行卡所属姓名
@property (nonatomic, copy)NSString *bankAccountRealName;
/**
 * 我的消息
 */
@property (nonatomic, copy)NSString *messageCount;
/**
 * 我的钱包账户提现
 */
@property (nonatomic, copy)NSString *withdrawCount;
/**
 * 我的钱包账户收入
 */
@property (nonatomic, copy)NSString *accountCount;
/**
 * 店铺营业的结算数量
 */
@property (nonatomic, copy)NSString *settleCount;

/**
 waitDeliverCount  待发货订单数
 **/
@property (nonatomic, copy)NSString *waitDeliverCount;

/**
 ShopCompleteCount   已完成订单数
 **/
@property (nonatomic, copy)NSString *shopCompleteCount;

/**
 hasDeliveredCount  已发货订单数
 **/
@property (nonatomic, copy)NSString *hasDeliveredCount;

//（多少天没有消费） 登录里新增返回字段
@property (nonatomic, assign)NSInteger notConsumeDays;

//记录当前位置
@property (nonatomic, assign)CLLocationCoordinate2D locationCoordinate;

//1已经填写身份证号   2没有填写
@property (nonatomic, copy)NSString *identityFlag ;

//是否已上传坐标
@property (nonatomic, assign)BOOL locationUploadFlag ;






//记录启动的时候有没有通知
@property (nonatomic, strong)NSDictionary *notificationParms;
@property (nonatomic, assign)BOOL islaunchFormNotifi;



- (void)setUserinfoWithdic:(NSDictionary *)dic;

//设置渐变色
+ (void)setjianpianColorwithView:(UIView *)backView withWidth:(CGFloat )width withHeight:(CGFloat)height;

@end
