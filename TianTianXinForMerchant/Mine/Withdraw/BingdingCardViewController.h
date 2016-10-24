//
//  BingdingCardViewController.h
//  天添薪
//
//  Created by ttx on 16/1/8.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"
#import "EBTFormatterTextFieldWithSpace.h"

@interface BingdingCardViewController : BaseViewController

//@property (weak, nonatomic) IBOutlet EBTFormatterTextFieldWithSpace *bankCardNu;

@property (weak, nonatomic) IBOutlet UITextField *bankCardNu;

@property (weak, nonatomic) IBOutlet UITextField *bankLabel;

- (IBAction)banLabelBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *provincesTF;
- (IBAction)provincesBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;


@property (weak, nonatomic) IBOutlet UITextField *idCardNUTF;

@property (weak, nonatomic) IBOutlet UIView *sureView;

- (IBAction)bingdingBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *editView;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;




@end
