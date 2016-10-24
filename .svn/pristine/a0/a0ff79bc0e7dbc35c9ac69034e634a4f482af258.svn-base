//
//  MyQrCodeView.m
//  tiantianxin
//
//  Created by ttx on 16/3/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyQrCodeView.h"
#import "LBXScanWrapper.h"

@implementation MyQrCodeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"MyQrCodeView" owner:nil options:nil][0];
    }
    return self;
}
- (void)setQrImage:(UIImage *)qrImage
{
    _qrImage = qrImage;
    self.qrCodeImage.image = _qrImage;
}


- (void)awakeFromNib
{
    
    [self sendSubviewToBack:self.backView];
    self.itmeView.layer.cornerRadius = 4;
    self.itmeView.layer.masksToBounds = YES;
    self.itmeView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
//    NSString *phone =NullToNumber([[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName]);
//    UIImage *qrImg = [LBXScanWrapper createQRWithString:phone size:self.qrCodeImage.bounds.size];
//    self.qrCodeImage.image = [LBXScanWrapper addImageLogo:qrImg centerLogoImage:nil logoSize:CGSizeMake(0, 0)];
    
    [self shakeToShow:self.itmeView];
}

- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}


- (IBAction)deletBtn:(UIButton *)sender {
    [self removeFromSuperview];
}
@end
