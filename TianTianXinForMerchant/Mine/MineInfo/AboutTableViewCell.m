//
//  AboutTableViewCell.m
//  tiantianxin
//
//  Created by ttx on 16/5/17.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "AboutTableViewCell.h"


@interface AboutTableViewCell()<UIAlertViewDelegate>

@end

@implementation AboutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor clearColor];
    self.versionLabel.text = [NSString stringWithFormat:@"版本 %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    self.visionAlert.layer.cornerRadius = self.visionAlert.bounds.size.height/2;
    self.visionAlert.layer.masksToBounds = YES;
    self.visionAlert.backgroundColor = MacoColor;
    self.visionAlert.text = @"";
    
    self.logTop.constant = (124/1334.)*THeight;
    self.versionTop.constant = (52/1334.)*THeight;
    self.itemTop.constant = (68/1334.)*THeight;
    NSDictionary *parms = @{@"deviceType":@"ios",
                            @"type":@"1"};
    [HttpClient POST:@"appVersion/lastAppVersion/get" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        NSString *newVersion = NullToSpace(jsonObject[@"data"][@"newVersion"]);
        NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if (![newVersion isEqualToString:nowVersion] && ![newVersion isEqualToString:@""]) {
            self.visionAlert.hidden = NO;
        }else{
            self.visionAlert.hidden = YES;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.visionAlert.hidden = YES;
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)visionBtn:(UIButton *)sender {
    
    NSDictionary *parms = @{@"deviceType":@"ios",
                            @"type":@"1"};
    [HttpClient POST:@"appVersion/lastAppVersion/get" parameters:parms success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        NSString *newVersion = NullToSpace(jsonObject[@"data"][@"newVersion"]);
        NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if (![newVersion isEqualToString:nowVersion] && ![newVersion isEqualToString:@""]) {
            UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"检查到有新版本，是否前往appStore更新" delegate:self cancelButtonTitle:@"暂时不要" otherButtonTitles:@"去更新", nil];
            self.visionAlert.hidden = NO;
            [alerView show];
        }else{
            [[JAlertViewHelper shareAlterHelper]showTint:@"当前已经是最新版本" duration:2.];
            self.visionAlert.hidden = YES;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.visionAlert.hidden = YES;
    }];
    
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
    UIWebView *webView = (UIWebView*)[self.viewController.view viewWithTag:1000];
    if (!webView) {
        webView = [[UIWebView alloc]init];
    }
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4001028997"]]]];
    [self.viewController.view addSubview:webView];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        {
            if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:AppStoreDetailUrl]]) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"暂时不能浏览官网" duration:1.5];
                return;
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppStoreDetailUrl]];
        }
            break;
            
        default:
            break;
    }
}

@end
