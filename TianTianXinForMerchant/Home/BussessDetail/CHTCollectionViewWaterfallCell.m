//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallCell.h"
#import "Watch.h"

@implementation CHTCollectionViewWaterfallCell

#pragma mark - Accessors
- (UILabel *)displayLabel {
  if (!_displayLabel) {
    _displayLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    _displayLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _displayLabel.backgroundColor = [UIColor lightGrayColor];
    _displayLabel.textColor = [UIColor whiteColor];
    _displayLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _displayLabel;
}

- (void)setDisplayString:(NSString *)displayString {
  if (![_displayString isEqualToString:displayString]) {
    _displayString = [displayString copy];
    self.displayLabel.text = _displayString;
  }
}

#pragma mark - Life Cycle
- (void)dealloc {
  [_displayLabel removeFromSuperview];
  _displayLabel = nil;
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
   
      self.layer.borderWidth = 1;
      self.layer.cornerRadius = 10;
      self.layer.borderColor = [UIColor whitegrayColor].CGColor;
      self.clipsToBounds = YES;
    UIImageView *imageView = [[UIImageView alloc] init];
    // Scale with fill for contents when we resize.
    imageView.contentMode = UIViewContentModeScaleAspectFill;

    // Scale the imageview to fit inside the contentView with the image centered:
    CGRect imageViewFrame = CGRectZero;
    imageView.frame = imageViewFrame;
//    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
//      imageView.layer.cornerRadius = 10;
      imageView.contentMode = UIViewContentModeScaleAspectFill;
      imageView.layer.masksToBounds = YES;
    self.imageView = imageView;
      

  }
  return self;
}

- (void)setWatch:(Watch *)watch
{
    _watch = watch;

    CGFloat h = self.bounds.size.width*([_watch.height floatValue]/[_watch.width floatValue]);
    
    if ([_watch.width isEqualToString:@""]) {
        h = 150;
    }
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_watch.img_small] placeholderImage:[UIImage imageNamed:LoadingErrorImage] options:SDWebImageRefreshCached];

}




@end
