//
//  InformationDetailViewController.m
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "InformationDetailViewController.h"
#import <UShareUI/UShareUI.h>

@interface InformationDetailViewController ()<BasenavigationDelegate>

@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation InformationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviBar.title = self.dataModel.title;
    self.naviBar.title = @"资讯详情";

    self.naviBar.hiddenDetailBtn = NO;
    [self.naviBar.detail_btn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    self.naviBar.delegate = self;
    
    
    self.imageView.frame = CGRectMake(50, 50, 100, 100);
    self.imageView.hidden = YES;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.cover] placeholderImage:AppIconImage options:SDWebImageRefreshCached];
    [self.webView addSubview:self.imageView];
    
    
    
    //设置用户自定义的平台
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               ]];

}


- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

#pragma mark - 分享
- (void)detailBtnClick
{
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self runShareWithType:platformType];
    }];
}

- (void)runShareWithType:(UMSocialPlatformType)type
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  self.dataModel.cover;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.dataModel.title descr:self.dataModel.title thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = self.dataModel.detailUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [[JAlertViewHelper shareAlterHelper]showTint:@"分享失败，请重试..." duration:2.];
//        [self alertWithError:error];
    }];

}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
