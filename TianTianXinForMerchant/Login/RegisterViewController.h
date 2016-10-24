//
//  RegisterViewController.h
//  天添薪
//
//  Created by ttx on 16/1/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *phone_num_view;

@property (weak, nonatomic) IBOutlet UITextField *phone_num_tf;

@property (weak, nonatomic) IBOutlet UIView *verifiCode_view;

@property (weak, nonatomic) IBOutlet UITextField *verifi_tf;


@property (weak, nonatomic) IBOutlet UIButton *verifi_btn;

- (IBAction)verifi_btn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *password_view;

@property (weak, nonatomic) IBOutlet UITextField *password_tf;

@property (weak, nonatomic) IBOutlet UIView *surePassword_view;

@property (weak, nonatomic) IBOutlet UITextField *surePassword_tf;
@property (weak, nonatomic) IBOutlet UIView *login_view;
- (IBAction)login_btn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distance1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distance2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distance3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sureBtnHeight;



@end
