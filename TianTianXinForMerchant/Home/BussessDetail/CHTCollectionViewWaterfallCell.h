//
//  UICollectionViewWaterfallCell.h
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Watch;

@interface CHTCollectionViewWaterfallCell : UICollectionViewCell
@property (nonatomic, copy) NSString *displayString;
@property (nonatomic, strong) IBOutlet UILabel *displayLabel;


@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)Watch *watch;

@end
