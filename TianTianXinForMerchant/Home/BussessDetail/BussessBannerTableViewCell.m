//
//  BussessBannerTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BussessBannerTableViewCell.h"
#import "ImageViewer.h"

@interface BussessBannerTableViewCell()<SwipeViewDataSource,SwipeViewDelegate>

@end

@implementation BussessBannerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.swipeView.delegate = self;
    self.swipeView.dataSource = self;
//    self.swipeView.wrapEnabled = YES;
    
    self.name_label.textColor = MacoTitleColor;
    
    


}


- (void)setDataModel:(BussessDetailModel *)dataModel
{
    _dataModel = dataModel;
    self.page_view.numberOfPages = _dataModel.slidePic.count;
    if (_dataModel.slidePic.count == 0) {
        self.page_view.hidden = YES;
        _dataModel.slidePic = @[@"http://192.168.1.2/more.png"];
    }else{
        self.page_view.hidden = NO;

    }
    [self.swipeView reloadData];
    self.name_label.text = _dataModel.name;
    [[AutoScroller shareAutoScroller]autoSwipeView:self.swipeView WithPageView:self.page_view WithDataSouceArray:[NSMutableArray arrayWithArray:_dataModel.slidePic]];
}

//返回重用标示
+ (NSString *)indentify
{
    return @"BussessBannerTableViewCell";
}
//创建cell


+ (id)newCell
{
    NSArray *array  = [[NSBundle mainBundle]loadNibNamed:@"BussessBannerTableViewCell" owner:nil options:nil];
    return array[0];
}



#pragma mark - swipeView


- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.dataModel.slidePic.count;
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
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.slidePic[index]] placeholderImage:BannerLoadingErrorImage];
    
    return view;
}


- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    self.page_view.currentPage = swipeView.currentPage;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    //banner点击事件
    if (self.page_view.hidden) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"暂时没有更多图片" duration:1.5];
        return;
    }
    [ImageViewer sharedImageViewer].controller = self.viewController;
    [[ImageViewer sharedImageViewer]showImageViewer:[NSMutableArray arrayWithArray:self.dataModel.slidePic] withIndex:index andView:self];
}



@end
