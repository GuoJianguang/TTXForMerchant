//
//  UIImage+FrameSize.h
//  Tourguide
//
//  Created by inphase on 15/9/14.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FrameSize)


-(UIImage *) lessThanFrameSize:(CGSize) frameSize weightSize:(NSInteger)weightSize;

-(UIImage*) imageWithSize:(CGSize) size;

// 按照宽度压缩
-(UIImage *) imageResizeWithWidthScaleSize:(CGSize) size;
// 按照高度压缩
-(UIImage *) imageResizeWithHeightScaleSize:(CGSize) size;

@end
