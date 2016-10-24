//
//  ShowBussessImageViewController.m
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "ShowBussessImageViewController.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "Watch.h"

#define KSpace 5.

@interface ShowBussessImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


//瀑布的数据源
@property (nonatomic, strong)NSMutableArray *dataSouceArray;


@end

@implementation ShowBussessImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"商家图片";
    
    [self.view addSubview:self.collectView];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    Watch *watch1 = [[Watch alloc]init];
    watch1.img_small = @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg";
    watch1.height = @"60";
    
    Watch *watch2 = [[Watch alloc]init];
    watch2.img_small = @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg";
    watch2.height = @"200";
    
    Watch *watch3 = [[Watch alloc]init];
    watch3.img_small = @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg";
    watch3.height = @"300";
    
    [self.dataSouceArray addObject:watch1];
    [self.dataSouceArray addObject:watch2];
    [self.dataSouceArray addObject:watch3];
    [self.dataSouceArray addObject:watch1];
    [self.dataSouceArray addObject:watch1];
    [self.dataSouceArray addObject:watch2];
    [self.dataSouceArray addObject:watch2];
    [self.dataSouceArray addObject:watch3];
    [self.dataSouceArray addObject:watch3];
    [self.dataSouceArray addObject:watch3];


    [self.collectView reloadData];


    
}

- (UICollectionView *)collectView
{
    if (!_collectView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.minimumColumnSpacing = 3;
        layout.minimumInteritemSpacing = 3;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, TWitdh, THeight - 64) collectionViewLayout:layout];
        //        _showWatchView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectView.dataSource = self;
        _collectView.delegate = self;
        [_collectView registerClass:[CHTCollectionViewWaterfallCell class]
           forCellWithReuseIdentifier:@"WaterfallCell"];
        layout.collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectView;
}

//懒加载
- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSouceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"WaterfallCell"
                                                                                forIndexPath:indexPath];
    if (self.dataSouceArray.count != 0) {
        cell.watch = self.dataSouceArray[indexPath.item];
    }
    
    return cell;
}

//每个cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataSouceArray.count == 0) {
        return;
    }

}


#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (TWitdh - KSpace*3)/2;
//    NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg"]];
//    UIImage *image = [[UIImage alloc]initWithData:data];
//            CGFloat x = image.size.width/image.size.height;
//            CGFloat height = width/x;
//    
//            return CGSizeMake(width, height);
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg"] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        CGFloat x = image.size.width/image.size.height;
//        CGFloat height = width/x;
//        
//        return CGSizeMake(width, height);
//    }];
    
    return CGSizeMake(width, [((Watch *)self.dataSouceArray[indexPath.item]).height floatValue]);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
