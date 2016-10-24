//
//  WatchBannerModel.h
//  Tourguide
//
//  Created by 郭建光 on 15/3/24.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Watch : NSObject

@property (nonatomic, strong)NSString *record_id;//打望纪录id
@property (nonatomic, strong)NSString *author;//打望上传者
@property (nonatomic, strong)NSString *upload_time;//上传时间
@property (nonatomic, strong)NSString *like_cout;//点赞数目
@property (nonatomic, strong)NSString *img_small;//打望的图片（url）
@property (nonatomic, strong)NSString *height;//图片高度
@property (nonatomic, strong)NSString *width;//图片宽度
@property (nonatomic, strong)NSString *content;//打望详情
@property (nonatomic, strong)NSString *comment_count;//评论条数
@property (nonatomic, strong)NSString *num;//图片张数

//@property (nonatomic, strong)UIImage *image;

//图片的高度
@property (nonatomic, assign)CGFloat h;
+ (Watch *)watchWithDic:(NSDictionary *)obj;


@end
