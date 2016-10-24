//
//  InformationBannerTableViewCell.h
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationBannerTableViewCell : BaseTableViewCell

//滚动的广告

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;

@property (weak, nonatomic) IBOutlet UILabel *adDetailLabel;



@property (nonatomic, strong)NSMutableArray *dataArray;


@end
