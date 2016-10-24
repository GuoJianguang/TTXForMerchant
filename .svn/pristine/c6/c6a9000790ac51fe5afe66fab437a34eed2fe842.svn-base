//
//  InformationBannerTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "InformationBannerTableViewCell.h"
#import "InformationBannerModel.h"
#import "InformationDetailViewController.h"

@interface InformationBannerTableViewCell()<SwipeViewDataSource,SwipeViewDelegate>



@end

@implementation InformationBannerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.adDetailLabel.textColor = MacoDetailColor;

    

}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
    
    if (_dataArray.count > 0) {
        InformationBannerModel *model = self.dataArray[self.swipeView.currentItemIndex];
        self.adDetailLabel.text = model.title;
    }

    [[AutoScroller shareAutoScroller]autoSwipeView:self.swipeView WithPageView:self.pageView WithDataSouceArray:self.dataArray];
    self.pageView.numberOfPages = self.dataArray.count;
    [self.swipeView reloadData];
    
}


#pragma mark - swipeView
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.dataArray.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    if (nil == view) {
        view = [[UIView alloc] initWithFrame:swipeView.bounds];
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.bounds = CGRectMake(0, 0, TWitdh, self.swipeView.bounds.size.height);
        imageView.center = swipeView.center;
        imageView.tag = 10;
        [view addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
    }else {
        imageView = (UIImageView*)[view viewWithTag:10];
    }
    InformationBannerModel *model = self.dataArray[index];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:BannerLoadingErrorImage];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:BannerLoadingErrorImage options:SDWebImageRefreshCached];
    
    return view;
}


- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    self.pageView.currentPage = swipeView.currentPage;
    InformationBannerModel *model = self.dataArray[swipeView.currentItemIndex];
    self.adDetailLabel.text = model.title;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    //banner点击事件
    InformationBannerModel *model = self.dataArray[index];
    InformationDetailViewController *detailVC = [[InformationDetailViewController alloc]init];
    detailVC.htmlUrl = model.detailUrl;
    detailVC.dataModel = model;
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
}

@end
