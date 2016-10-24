//
//  YetTimeTableViewDataSouce.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject

@property (nonatomic, copy)NSString *time_str;
@property (nonatomic, assign)BOOL isSelect;

@end


@protocol YetTimeDelegate <NSObject>

- (void)selectTimeItem:(NSString *)time;

@end


@interface YetTimeTableViewDataSouce : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSString *tempSelect;

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, assign)id<YetTimeDelegate> delegate;

@end
