//
//  InformationViewController.h
//  天添薪
//
//  Created by ttx on 16/1/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"
#import "MarqueeLabel.h"


@interface InformationViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
