//
//  HomeImageSwitchIndicatorView.m
//  Tourguide
//
//  Created by test on 15/3/8.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import "HomeImageSwitchIndicatorView.h"
#import "Colours.h"

@interface HomeImageSwitchIndicatorView ()

@property(nonatomic,strong) UIView *indicatorView;

@end

@implementation HomeImageSwitchIndicatorView


-(void)layoutSubviews {
    
    CGRect frame = self.frame;
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    if (_indicatorCounts > 0) {
        CGFloat indicaotorWidth = width / _indicatorCounts;
        self.indicatorView.backgroundColor = _indicatorColor;
        self.indicatorView.frame = CGRectMake(indicaotorWidth * _currentIndicatorIndex, height - _indicatorHeight, indicaotorWidth, _indicatorHeight);
    }
}

-(void) setUp {
    _indicatorCounts = 0;
    _currentIndicatorIndex = 0;
    _indicatorHeight = self.frame.size.height;
    _indicatorColor = [UIColor colorFromHexString:@"#0db09b"];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.indicatorView = [[UIView alloc] init];
    [self addSubview:self.indicatorView];
}


-(void)setIndicatorCounts:(NSUInteger)indicatorCounts {
    _indicatorCounts = indicatorCounts;
    
    [self setNeedsLayout];
}

-(void)setIndicatorHeight:(CGFloat)indicatorHeight {

    _indicatorHeight = indicatorHeight;
    
    [self setNeedsLayout];
}

-(void)setCurrentIndicatorIndex:(NSUInteger)currentIndicatorIndex {

    _currentIndicatorIndex = currentIndicatorIndex;

    __weak HomeImageSwitchIndicatorView *weak_self = self;
    [UIView animateWithDuration:0.3 delay:0. options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [weak_self setNeedsLayout];
    } completion:^(BOOL finished) {
        
    }];
}

-(instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    
    return self;
}


@end
