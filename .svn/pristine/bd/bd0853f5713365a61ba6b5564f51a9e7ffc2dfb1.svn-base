//
//  InformationDetailViewController.m
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "InformationDetailViewController.h"
#import "UMSocial.h"

@interface InformationDetailViewController ()<BasenavigationDelegate,UMSocialUIDelegate>

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
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.dataModel.detailUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.dataModel.detailUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = nil;

    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    //先判断bundleId是什么（有企业版）
    NSString *bundleID =  [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleID isEqualToString:@"com.ttx.tiantianxcn"]) {
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:YoumengKey_Inhouse
                                          shareText:self.dataModel.title
                                         shareImage:self.imageView.image
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                           delegate:self];
        return;
    }
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:YoumengKey
                                      shareText:self.dataModel.title
                                     shareImage:self.imageView.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
}


-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
//    UMSocialWXMessageTypeWeb
//    if (platformName == UMShareToQzone) {
//        socialData.shareText = @"分享到QQ空间的文字内容";
//        socialData.shareImage = LoadingErrorImage;
//    }
//    else{
//        
//    }
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
