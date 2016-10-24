//
//  AboutUsViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/3/1.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UIActionSheetDelegate>

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"关于天添薪";
    self.versionLabel.text = [NSString stringWithFormat:@"版本 %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    self.aboutsLabel.text = @"四川天添薪电子商务有限公司\n * Copyright©2009-2016，All Rights Reserverd 版权所有\nICP备案号：川B2-20150180 ";
    self.logTop.constant = ((128+124)/1334.)*THeight;
    self.versionTop.constant = (52/1334.)*THeight;
    self.itemTop.constant = (68/1334.)*THeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)companyWebsite:(UIButton *)sender {
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.tiantianxcn.com"]]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"暂时不能浏览官网" duration:1.5];
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.tiantianxcn.com"]];
}

- (IBAction)weixin:(UIButton *)sender {
    
}
- (IBAction)contactUs:(UIButton *)sender {
//    UIWebView *webView = (UIWebView*)[self.view viewWithTag:1000];
//    if (!webView) {
//        webView = [[UIWebView alloc]init];
//    }
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4001028997"]]]];
//    [self.view addSubview:webView];
    NSArray *arry =  @[@"02862908389",@"02862908390",@"02862908391",@"02862908392"];
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"拨打客服电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
    for (int i = 0; i < arry.count; i ++) {
        [sheet addButtonWithTitle:arry[i]];
    }
    [sheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://%@",[actionSheet buttonTitleAtIndex:buttonIndex]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
