//
//  MyWallectCollectionViewCell.h
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - 提现记录的Model

@interface MYWallectTixianModel : BaseModel
@property (nonatomic, assign)double withdrawAmout ;
@property (nonatomic, copy)NSString *successTime ;
//提现状态 0待审核  1审核通过  2提现中   3提现成功  4提现失败 
@property (nonatomic, copy)NSString *state;

@end
#pragma mark - 邀请的Model

@interface AssociateJissuanModel : BaseModel
/**
 * 商户名称
 */
@property (nonatomic,copy)NSString *mchName;

//应结算
@property (nonatomic,copy)NSString *settleAmount;
/**
 * 商户号
 */
@property (nonatomic,copy)NSString *settleId;

/**
 * 时间
 */
@property (nonatomic,copy)NSString *settleTime;
/**
 * 状态 0未扣款 1成功 2扣款失败 3.扣款结果不确定 4逾期 5人工冻结 6 成功
 */
@property (nonatomic,copy)NSString *state;
/**
 * 状态描述 0未扣款 1成功 2扣款失败 3.扣款结果不确定 4逾期 5人工冻结 6 成功
 */
@property (nonatomic,copy)NSString *stateDesc;
//营业额
@property (nonatomic, copy)NSString *totalAmount;


@end



@interface MyWallectCollectionViewCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *detail_label;

@property (weak, nonatomic) IBOutlet UILabel *name_label;

@property (weak, nonatomic) IBOutlet UILabel *stauts_label;

//邀请的model
@property (nonatomic, strong)AssociateJissuanModel *jiesuanDataModel;

@property (nonatomic, strong)MYWallectTixianModel *tixianModel;


@end
