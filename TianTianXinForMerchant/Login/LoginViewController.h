//
//  LoginViewController.h
//  天添薪
//
//  Created by ttx on 16/1/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : BaseViewController


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usertop;
@property (weak, nonatomic) IBOutlet UIView *user_view;

@property (weak, nonatomic) IBOutlet UIView *login_view;

@property (weak, nonatomic) IBOutlet UIView *password_view;

@property (weak, nonatomic) IBOutlet UITextField *user_tf;

- (IBAction)login_btn:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITextField *password_tf;


- (IBAction)cancelLogin:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginTop;
+ (UINavigationController *)controller;


@property (weak, nonatomic) IBOutlet UIImageView *passwordImage;

@property (weak, nonatomic) IBOutlet UIImageView *usernameImage;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)forgetBtn:(UIButton *)sender;



@end
