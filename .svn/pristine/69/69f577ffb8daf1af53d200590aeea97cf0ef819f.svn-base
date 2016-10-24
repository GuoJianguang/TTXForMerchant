//
//  UIViewController+MBHud.m
//  SCar
//
//  Created by mobao_ios on 15/4/2.
//  Copyright (c) 2015年 yfb. All rights reserved.
//

#import "UIViewController+hud.h"

@implementation UIViewController (hud)

-(void)showHudWithDescription:(NSString *)string
{
    [self hidHUDProgress];
    UIWindow *keyWindow;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:keyWindow];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    [keyWindow addSubview:hud];
    [hud show:YES];
}

-(void)showHUDAndHidWithDescription:(NSString *)string
{
    [self hidHUDProgress];
    UIWindow *keyWindow;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    [keyWindow addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.5f];
}

-(void)showHUDAndHidWithDescription:(NSString *)string font:(UIFont *)font
{
    [self hidHUDProgress];
    UIWindow *keyWindow;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    hud.labelFont = font;
    [keyWindow addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.5f];
}

-(void)showHUDProgress{
    [self hidHUDProgress];
    UIWindow *keyWindow;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:keyWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    [keyWindow addSubview:hud];
    [hud show:YES];
    
}

-(void)showHUDProgressWithString:(NSString *)string{
    [self hidHUDProgress];
    UIWindow *keyWindow;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:keyWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = string;
    [keyWindow addSubview:hud];
    [hud show:YES];
    
}

-(void)showHUDProgressInSelfViewWithString:(NSString *)string{
    [self hidHUDProgress];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = string;
    [self.view addSubview:hud];
    [hud show:YES];
}

-(void)hidHUDProgress
{
    UIWindow *keyWindow;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
    [MBProgressHUD hideAllHUDsForView:keyWindow animated:NO];
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}

-(void)showHUDWithStr:(NSString *)str andHideAfterDelay:(NSTimeInterval)time didDismiss:(void(^)())didDismiss
{
    [self hidHUDProgress];
    UIWindow *keyWindow;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
	MBProgressHUD *hud = [[MBProgressHUD alloc] init];
	hud.mode = MBProgressHUDModeText;
	hud.labelText = str;
	[keyWindow addSubview:hud];
	[hud show:YES];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [hud hide:YES];
        if (didDismiss) {
            didDismiss();
        }
    });
}

@end
