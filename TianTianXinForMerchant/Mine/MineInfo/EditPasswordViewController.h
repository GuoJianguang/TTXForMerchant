//
//  EditPasswordViewController.h
//  天添薪
//
//  Created by ttx on 16/1/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"

@interface EditPasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *oldPassword_view;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword_tf;

@property (weak, nonatomic) IBOutlet UIView *password_view;
@property (weak, nonatomic) IBOutlet UITextField *pasword_tf;
@property (weak, nonatomic) IBOutlet UIView *surePassword_view;

@property (weak, nonatomic) IBOutlet UIView *sure_view;

@property (weak, nonatomic) IBOutlet UITextField *surePassword_tf;

- (IBAction)sure_btn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *verifBtn;
- (IBAction)verifBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *verif_tf;


@end
