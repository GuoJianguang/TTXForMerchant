//
//  AssociatedTableViewDataSouce.h
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,AssociatedSelcetType){
    AssociatedSelcetType_store = 1,//账户返现
    AssociatedSelcetType_time = 2,//账户消费
};

@protocol AssociatedSelectDelegate <NSObject>

- (void)selectwithType:(AssociatedSelcetType)selcelType withselceName:(NSString *)name withMchCode:(NSString *)storeCode;

@end

@interface AssociatedTableViewDataSouce : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *timeDataSouceArray;

@property (nonatomic, strong)NSMutableArray *storeDataSouceArray;


@property (nonatomic, assign)AssociatedSelcetType type;

@property (nonatomic, assign)id<AssociatedSelectDelegate> delegate;

@property (nonatomic, copy)NSString *tempStr;


@end
