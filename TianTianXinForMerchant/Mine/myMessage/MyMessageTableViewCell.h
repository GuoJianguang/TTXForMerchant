//
//  MyMessageTableViewCell.h
//  天添薪
//
//  Created by ttx on 16/1/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessafeModel : BaseModel

/**
 * 消息id
 */
@property (nonatomic, copy)NSString *messageid;
/**
 * 标题
 */
@property (nonatomic, copy)NSString *title;
/**
 * 内容
 */
@property (nonatomic, copy)NSString *content;
/**
 * 创建时间
 */
@property (nonatomic, copy)NSString *createTime;
/**
 * 类型
 */
@property (nonatomic, copy)NSString *type;



@end


@interface MyMessageTableViewCell : UITableViewCell

//返回重用标示
+ (NSString *)indentify;
//创建xib中的cell
+ (id)newCell;
@property (nonatomic, strong)MessafeModel *dataModel;

@property (weak, nonatomic) IBOutlet UILabel *titel_label;
@property (weak, nonatomic) IBOutlet UILabel *detail_label;

@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UIView *item_view;





@end
