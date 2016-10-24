//
//  UIImage+FrameSize.m
//  Tourguide
//
//  Created by inphase on 15/9/14.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import "UIImage+FrameSize.h"

@implementation UIImage (FrameSize)


-(UIImage *) resizeImageWithSize:(CGSize) size {

    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

-(UIImage *)lessThanFrameSize:(CGSize)frameSize weightSize:(NSInteger)weightSize {

    // 比规定宽度宽 按照宽度缩小
    if (self.size.width > frameSize.width) {

        CGFloat widthScale = self.size.width / frameSize.width;
        CGFloat height = self.size.height / widthScale;
        
        UIImage *image = [self resizeImageWithSize:CGSizeMake(frameSize.width, height)];
        if (image.size.height > frameSize.height) {
            CGFloat heightScale = image.size.height / frameSize.height;
            CGFloat width = image.size.width / heightScale;
            image = [self resizeImageWithSize:CGSizeMake(width, frameSize.height)];
        }
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1.);
        if (!imageData) {
            imageData = UIImagePNGRepresentation(image);
        }
        CGFloat imageWeight = imageData.length;
        if (imageWeight > weightSize) {
            CGFloat weightScale = weightSize/imageWeight;
            NSData *newImageData = UIImageJPEGRepresentation(image, weightScale);
            image = [[UIImage alloc]initWithData:newImageData];
        }
        
        return image;
    }
    
    NSData *imageData = UIImageJPEGRepresentation(self, 1.);
    if (!imageData) {
        imageData = UIImagePNGRepresentation(self);
    }
    CGFloat imageWeight = imageData.length;
    if (imageWeight != 0 &&  imageWeight > weightSize) {
        CGFloat weightScale = weightSize/imageWeight;
        NSData *newImageData = UIImageJPEGRepresentation(self, weightScale);
        UIImage *image = [[UIImage alloc]initWithData:newImageData];
        return image;
    }
    
    return self;
}


-(UIImage *)imageResizeWithHeightScaleSize:(CGSize)frameSize {
    // 比规定高度宽 按照高度缩小
    if (self.size.width > frameSize.width) {
        
        CGFloat heightScale = self.size.height / frameSize.height;
        CGFloat width = self.size.width / heightScale;
        UIImage *image = [self resizeImageWithSize:CGSizeMake(width, frameSize.height)];
        return image;
    }
    
    return self;
}

-(UIImage *)imageResizeWithWidthScaleSize:(CGSize)frameSize {
    // 比规定宽度宽 按照宽度缩小
    if (self.size.width > frameSize.width) {
        
        CGFloat widthScale = self.size.width / frameSize.width;
        CGFloat height = self.size.height / widthScale;
        UIImage *image = [self resizeImageWithSize:CGSizeMake(frameSize.width, height)];
        return image;
    }
    
    return self;
}

-(UIImage *)imageWithSize:(CGSize)size {

    return [self lessThanFrameSize:size weightSize:0];
}

@end
































