//
//  UIView+SetGradient.m
//  天添薪
//
//  Created by ttx on 16/1/22.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "UIView+SetGradient.h"

@implementation UIView (SetGradient)

- (void)setGradiet
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0 , 0,self.bounds.size.width, self.bounds.size.height);
    
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    
    UIColor *statColor = [UIColor colorWithRed:244/255. green:91/255. blue:80/255. alpha:1.];
    UIColor *endColor = [UIColor colorWithRed:244/255. green:165/255. blue:80/255. alpha:1.];
    
    
    gradient.colors = [NSArray arrayWithObjects:
                       (id)statColor.CGColor,
                       (id)endColor.CGColor,
                       nil];
    if ([self.layer.sublayers[0] isKindOfClass:[CAGradientLayer class]]) {
        CAGradientLayer *oldlayer = (CAGradientLayer *)self.layer.sublayers[0];
        [oldlayer removeFromSuperlayer];
    }

    [self.layer insertSublayer:gradient atIndex:0];
}


- (void)cancelGraiedt
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0 , 0,self.bounds.size.width, self.bounds.size.height);
    
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    
    UIColor *statColor = [UIColor grayColor];
    UIColor *endColor = [UIColor grayColor];
    
    
    gradient.colors = [NSArray arrayWithObjects:
                       (id)statColor.CGColor,
                       (id)endColor.CGColor,
                       nil];
    if ([self.layer.sublayers[0] isKindOfClass:[CAGradientLayer class]]) {
        CAGradientLayer *oldlayer = (CAGradientLayer *)self.layer.sublayers[0];
        [oldlayer removeFromSuperlayer];
    }

    [self.layer insertSublayer:gradient atIndex:0];
}


@end
