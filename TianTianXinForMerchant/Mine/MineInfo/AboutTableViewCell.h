//
//  AboutTableViewCell.h
//  tiantianxin
//
//  Created by ttx on 16/5/17.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutTableViewCell : BaseTableViewCell



@property (weak, nonatomic) IBOutlet UILabel *aboutsLabel;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)companyWebsite:(UIButton *)sender;

- (IBAction)weixin:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *contactUs;
- (IBAction)contactUs:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *visionBtn;

- (IBAction)visionBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *visionright;

@property (weak, nonatomic) IBOutlet UILabel *visionAlert;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *versionTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemTop;

@end
