//
//  WithDrawalResultView.m
//  天添薪
//
//  Created by ttx on 16/1/8.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "WithDrawalResultView.h"
#import "MoView.h"
#import "OrderEntryViewController.h"


@implementation WithDrawalResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"WithDrawalResultView" owner:nil options:nil][0];
        
        self.anmintionView = [[MoView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.moView addSubview:self.anmintionView];
        self.anmintionView.center = CGPointMake(CGRectGetWidth(self.moView.frame)/2, CGRectGetHeight(self.moView.frame)/2);
        self.anmintionView.backgroundColor = [UIColor orangeColor];
        self.anmintionView.layer.cornerRadius = CGRectGetHeight(self.anmintionView.bounds)/2;
        self.anmintionView.layer.masksToBounds = YES;
        [self buttonAction];
//        [TTXUserInfo setjianpianColorwithView:self.sureView withWidth:CGRectGetWidth(self.sureView.bounds) withHeight:CGRectGetHeight(self.sureView.bounds)];
        
        self.sureView.backgroundColor = [UIColor clearColor];
        self.sureView.layer.cornerRadius = TWitdh*(235/927.)/2;
        self.sureView.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)buttonAction
{
    if (self.anmintionView) {
        [self.anmintionView startLoading];
        
        [self.anmintionView success:^{
            
        }];
    }
}

- (IBAction)sureBtn:(UIButton *)sender {
    if (self.isorderEntry) {
        ((OrderEntryViewController *)self.viewController).isResultView = NO;
        [self removeFromSuperview];
        return;
    }
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
@end
