//
//  SortButtonSwitchView.h
//  tiantianxin
//
//  Created by ttx on 16/4/6.
//  Copyright © 2016年 ttx. All rights reserved.
//
#import <Availability.h>
#undef weak_delegate
#if __has_feature(objc_arc) && __has_feature(objc_arc_weak)
#define weak_delegate weak
#else
#define weak_delegate unsafe_unretained
#endif


#import <UIKit/UIKit.h>
@protocol SortButtonSwitchViewDelegate;

@interface SortButtonSwitchView : UIView

@property (nonatomic, weak_delegate) IBOutlet id<SortButtonSwitchViewDelegate> delegate;

//分类名称的数组
@property (nonatomic, strong)NSArray *titleArray;

- (void )sortBtn:(UIButton *)sender;

//选中某个选项
- (void)selectItem:(NSInteger )index;


//显示当前个数

- (void)setNumberForItem:(NSInteger)num withIndex:(NSInteger)index;

@end


@protocol SortButtonSwitchViewDelegate <NSObject>


- (void)sortBtnDselect:(SortButtonSwitchView *)sortView withSortId:(NSString *)sortId;



@end
