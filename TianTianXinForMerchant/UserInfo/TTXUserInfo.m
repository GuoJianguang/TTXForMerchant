//
//  TTXUserInfo.m
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "TTXUserInfo.h"

static TTXUserInfo *instance;


@implementation TTXUserInfo


+ (TTXUserInfo *)shareUserInfos
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TTXUserInfo alloc]init];
    });
    return instance;
}


- (void)setUserinfoWithdic:(NSDictionary *)dic
{
    instance.avatar = NullToSpace(dic[@"avatar"]);
    instance.aviableBalance = NullToNumber(dic[@"balance"]);
    instance.city = NullToSpace(dic[@"city"]);
    instance.userid = NullToSpace(dic[@"id"]);
    instance.nickName = NullToSpace(dic[@"nickName"]);
    instance.province = NullToSpace(dic[@"province"]);
    instance.token = NullToSpace(dic[@"token"]);
    instance.totalConsumeAmount = NullToNumber(dic[@"totalConsumeAmount"]);
    instance.totalExpectAmount = NullToNumber(dic[@"totalExpectAmount"]);
    instance.zone = NullToSpace(dic[@"zone"]);
    
    instance.bindingFlag = NullToNumber(dic[@"bindingFlag"]);
    instance.grade = NullToNumber(dic[@"grade"]);
    instance.integral = NullToNumber(dic[@"integral"]);
    instance.bankAccount = NullToSpace(dic[@"bankAccount"]);
    instance.bankAccountRealName = NullToSpace(dic[@"bankAccountRealName"]);
    
    instance.messageCount = NullToNumber(dic[@"messageCount"]);
    instance.withdrawCount = NullToNumber(dic[@"withdrawCount"]);
    instance.settleCount = NullToNumber(dic[@"settleCount"]);
    
    NSString *notPay = NullToNumber(dic[@"notConsumeDays"]);
    instance.notConsumeDays = [notPay integerValue];
    instance.identityFlag = NullToNumber(dic[@"identityFlag"]);
    instance.wiatJoinAmunt = NullToNumber(dic[@"waitJoinAmount"]);
    
    instance.code = NullToSpace(dic[@"code"]);
    if ([NullToNumber(dic[@"locationUploadFlag"]) isEqualToString:@"1"]) {
        instance.locationUploadFlag  = YES;
    }else{
        instance.locationUploadFlag  = NO;

    }
    
    
    if ([dic[@"unreadMchMsgCountVo"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *unreadMsgCountVo = dic[@"unreadMchMsgCountVo"];
        instance.messageCount = NullToNumber(unreadMsgCountVo[@"messageCount"]);
        instance.withdrawCount = NullToNumber(unreadMsgCountVo[@"withdrawCount"]);
        instance.settleCount = NullToNumber(unreadMsgCountVo[@"settleCount"]);
        instance.hasDeliveredCount = NullToNumber(unreadMsgCountVo[@"hasDeliveredCount"]);
        instance.shopCompleteCount = NullToNumber(unreadMsgCountVo[@"shopCompleteCount"]);
        
        instance.waitDeliverCount = NullToNumber(unreadMsgCountVo[@"waitDeliverCount"]);
        instance.accountCount = NullToNumber(unreadMsgCountVo[@"accountCount"]);
    }
    
}

#pragma mark - 设置渐变色
+ (void)setjianpianColorwithView:(UIView *)backView withWidth:(CGFloat )width withHeight:(CGFloat)height
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0 , 0,width, height);
    
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    
    UIColor *statColor = [UIColor colorWithRed:244/255. green:91/255. blue:80/255. alpha:1.];
    UIColor *endColor = [UIColor colorWithRed:244/255. green:165/255. blue:80/255. alpha:1.];
    
    
    gradient.colors = [NSArray arrayWithObjects:
                       (id)statColor.CGColor,
                       (id)endColor.CGColor,
                       nil];
    [backView.layer insertSublayer:gradient atIndex:0];
}


@end
