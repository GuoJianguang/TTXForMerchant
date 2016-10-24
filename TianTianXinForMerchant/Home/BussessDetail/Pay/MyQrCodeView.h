//
//  MyQrCodeView.h
//  tiantianxin
//
//  Created by ttx on 16/3/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyQrCodeView : UIView

@property (weak, nonatomic) IBOutlet UIView *itmeView;

- (IBAction)deletBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImage;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (nonatomic, strong)UIImage *qrImage;


@end
