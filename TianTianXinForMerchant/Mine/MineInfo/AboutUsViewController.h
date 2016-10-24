//
//  AboutUsViewController.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/3/1.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutUsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *aboutsLabel;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)companyWebsite:(UIButton *)sender;

- (IBAction)weixin:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *contactUs;
- (IBAction)contactUs:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *versionTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemTop;


@end
