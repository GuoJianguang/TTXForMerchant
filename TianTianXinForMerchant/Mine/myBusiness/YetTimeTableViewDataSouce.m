//
//  YetTimeTableViewDataSouce.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/2/25.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "YetTimeTableViewDataSouce.h"
#import "TimeTableViewCell.h"


@implementation TimeModel



@end


@implementation YetTimeTableViewDataSouce

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.dataSouceArray = [self createMonth];
    return self.dataSouceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TimeTableViewCell indentify]];
    if (!cell) {
        cell = [TimeTableViewCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];
    if ([cell.dataModel.time_str isEqualToString:self.tempSelect]) {
        cell.timeLabel.textColor = MacoColor;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeModel *model = self.dataSouceArray[indexPath.row];
    self.tempSelect = model.time_str;
    [tableView reloadData];
    if ([self.delegate respondsToSelector:@selector(selectTimeItem:)]) {
        [self.delegate selectTimeItem:model.time_str];
    }

}

#pragma mark - 计算月份数
- (NSMutableArray *)createMonth
{
    NSString *newsDate = @"2015-11-01 00:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [NSDate date];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    int month=((int)time)/(3600*24*30)+1;
    
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger nowyear = [dateComponent year];
    NSInteger nowMonth = [dateComponent month];
    
    NSMutableArray *timeArray = [NSMutableArray array];
    
    
    for (int i = 0; i < month;  i++) {
        NSString *time = [NSString string];
        if (nowMonth < 10) {
            time = [NSString stringWithFormat:@"%ld.0%ld",nowyear,nowMonth];
        }else{
            time = [NSString stringWithFormat:@"%ld.%ld",nowyear,nowMonth];
        }
        TimeModel *model = [[TimeModel alloc]init];
        model.time_str = time;
        [timeArray addObject:model];
        nowMonth--;
        if (nowMonth == 0) {
            nowMonth = 12;
            nowyear--;
        }
    }
    TimeModel *allmodel = [[TimeModel alloc]init];
    allmodel.time_str = @"全部时间";
    [timeArray insertObject:allmodel atIndex:0];
    return timeArray;
}



@end
