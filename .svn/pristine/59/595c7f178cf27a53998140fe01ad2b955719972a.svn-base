//
//  MyWalletTableViewCell.h
//  天添薪
//
//  Created by ttx on 16/1/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWalletViewModel : NSObject

@property (nonatomic, strong)NSString *titel;
@property (nonatomic, strong)NSString *image_name;
@property (nonatomic, strong)NSString *count;

+ (MyWalletViewModel *)dataWithDic:(NSDictionary *)dic;

@end




@interface MyWalletTableViewCell : UITableViewCell

//返回重用标示
+ (NSString *)indentify;
//创建xib中的cell
+ (id)newCell;

@property (nonatomic, strong)MyWalletViewModel *dataModel;


@property (weak, nonatomic) IBOutlet UIImageView *mark_image;

@property (weak, nonatomic) IBOutlet UILabel *detail_titel;
@property (weak, nonatomic) IBOutlet UILabel *count_label;
@property (weak, nonatomic) IBOutlet UIView *item_view;

@end
