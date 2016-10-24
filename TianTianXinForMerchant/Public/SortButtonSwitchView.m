//
//  SortButtonSwitchView.m
//  tiantianxin
//
//  Created by ttx on 16/4/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "SortButtonSwitchView.h"

@interface SortButtonSwitchView()
{
    NSInteger mark;
}

@end

@implementation SortButtonSwitchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        mark = 1;
        [self setUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        mark = 1;
        [self setUI];
    }
    return self;
}

- (void )setUI
{


    self.backgroundColor = [UIColor whiteColor];
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;

    for (int i = 0; i < _titleArray.count; i++) {
        //点击的按钮
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 11 + i;
        [btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:MacoColor forState:UIControlStateSelected];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [self addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(sortBtn:) forControlEvents:UIControlEventTouchUpInside];
        //显示的数量的Label
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:12];
        label.backgroundColor = MacoColor;
        label.textColor = [UIColor whiteColor];
        label.tag = 1001 + i;
        label.hidden = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    //默认选中第一个
    ((UIButton *)[self viewWithTag:11]).selected = YES;
    for (int i = 1; i < _titleArray.count; i ++) {
        UIView *view = [[UIView alloc]init];
        view.tag = 20 + i;
        [self addSubview:view];
        view.backgroundColor = MacoDetailColor;
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = MacoDetailColor;
    view.tag = 100;
    [self addSubview:view];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!_titleArray) {
        _titleArray = @[@"3"];
    }
    CGFloat btnWidth = TWitdh/_titleArray.count;
    CGFloat btnHeight = self.frame.size.height;
    CGFloat segmentWidth = 1;
    CGFloat segmentHeight = 18;
    for (int i = 0; i < _titleArray.count; i++) {
        [self viewWithTag:i + 11].frame = CGRectMake(i*btnWidth , 0, btnWidth, btnHeight);
        [self viewWithTag:i + 21].frame = CGRectMake( (i+1) *btnWidth, (btnHeight - segmentHeight)/2, segmentWidth, segmentHeight);
        [self viewWithTag:i + 1001].frame = CGRectMake((i+1) *btnWidth - 30 , (btnHeight - segmentHeight)/2, segmentHeight, segmentHeight);
        [self viewWithTag:i + 1001].layer.cornerRadius = segmentHeight/2;
        [self viewWithTag:i + 1001].layer.masksToBounds = YES;

    }
    
    [self viewWithTag:100].frame = CGRectMake(0, self.bounds.size.height-1, TWitdh, 1);
}

- (void )sortBtn:(UIButton *)sender
{
    if (sender.tag == 15) {
        if ([self.delegate respondsToSelector:@selector(sortBtnDselect:withSortId:)]&&!sender.selected) {
            [self.delegate sortBtnDselect:self withSortId:[NSString stringWithFormat:@"%d",5]];
        }
        return;
        
    }
    mark = sender.tag  - 10;
    
    if ([self.delegate respondsToSelector:@selector(sortBtnDselect:withSortId:)]&&!sender.selected) {
        [self.delegate sortBtnDselect:self withSortId:[NSString stringWithFormat:@"%d",mark]];
    }
    for (int i = 11; i < _titleArray.count + 11; i ++) {
        ((UIButton *)[self viewWithTag:i]).selected = NO;
    }
    sender.selected = YES;
    
    
    [self setNeedsLayout];
}

- (void)selectItem:(NSInteger )index
{
    //    [self sortBtn:(UIButton *)[self viewWithTag:index + 11]];
    
    mark = index + 1;
    for (int i = 11; i < _titleArray.count + 11; i ++) {
        ((UIButton *)[self viewWithTag:i]).selected = NO;
    }
    ((UIButton *)[self viewWithTag:index + 11]).selected = YES;
    [self setNeedsLayout];
}


#pragma mark -
- (void)setNumberForItem:(NSInteger)num withIndex:(NSInteger)index
{
    if (num == 0) {
        [self viewWithTag:1001 + index].hidden = YES;
        return;
    }
    [self viewWithTag:1001 + index].hidden = NO;
    ((UILabel *)[self viewWithTag:1001 + index]).text = [NSString stringWithFormat:@"%ld",num];


}


@end
