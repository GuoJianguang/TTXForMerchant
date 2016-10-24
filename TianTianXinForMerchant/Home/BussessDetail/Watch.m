//
//  WatchBannerModel.m
//  Tourguide
//
//  Created by 郭建光 on 15/3/24.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import "Watch.h"

@implementation Watch

+ (Watch *)watchWithDic:(NSDictionary *)obj
{
    Watch *watch = [[Watch alloc]init];
    watch.author = NullToSpace([obj objectForKey:@"author"]);
    watch.record_id = NullToSpace([obj objectForKey:@"record_id"]);
    watch.upload_time = NullToSpace([obj objectForKey:@"upload_time"]);
//    NSString *str = [NSString stringWithFormat:@"%@%@",HttpClient_IMAGE_BASE_URL,NullToSpace([obj objectForKey:@"img_small"])];
//    watch.img_small = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    watch.like_cout = NullToSpace([obj objectForKey:@"zan"]);
    watch.height = NullToSpace([obj objectForKey:@"height"]);
    watch.width = NullToSpace([obj objectForKey:@"width"]);
    watch.content = NullToSpace([obj objectForKey:@"content"]);
    watch.comment_count = NullToSpace([obj objectForKey:@"comment_count"]);
    watch.num = NullToSpace([obj objectForKey:@"num"]);
    return watch;
}

@end
