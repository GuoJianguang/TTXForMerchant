//
//  AssociatedTableViewDataSouce.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/23.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "AssociatedTableViewDataSouce.h"
#import "TimeTableViewCell.h"

@interface AssociatedTableViewDataSouce()

@end


@implementation AssociatedTableViewDataSouce

- (NSMutableArray *)timeDataSouceArray
{
    if (!_timeDataSouceArray) {
        _timeDataSouceArray = [NSMutableArray array];
    }
    return _timeDataSouceArray;
}


- (NSMutableArray *)storeDataSouceArray
{
    if (!_storeDataSouceArray) {
        _storeDataSouceArray = [NSMutableArray array];
    }
    return _storeDataSouceArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.type == AssociatedSelcetType_store) {
        return self.storeDataSouceArray.count;
    }
    
    return self.timeDataSouceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TimeTableViewCell indentify]];
    if (!cell) {
        cell = [TimeTableViewCell newCell];
    }
    if (self.type == AssociatedSelcetType_store) {
        cell.storeModel = self.storeDataSouceArray[indexPath.row];
        if ([self.tempStr isEqualToString:cell.storeModel.mchName]) {
            cell.timeLabel.textColor =MacoColor;
        }else{
            cell.timeLabel.textColor = MacoTitleColor;
        }
    }else{
        cell.dataModel = self.timeDataSouceArray[indexPath.row];
        if ([self.tempStr isEqualToString:cell.dataModel.time_str]) {
            cell.timeLabel.textColor =MacoColor;
        }else{
            cell.timeLabel.textColor = MacoTitleColor;
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *mchCode = [NSString string];
    if (self.type == AssociatedSelcetType_store) {
        mchCode = ((MyStoreModel*)self.storeDataSouceArray[indexPath.row]).mchCode;
    }
    if ([self.delegate respondsToSelector:@selector(selectwithType:withselceName: withMchCode:)]) {
        [self.delegate selectwithType:self.type withselceName:cell.timeLabel.text withMchCode:mchCode];
    }
    
}


@end
