//
//  CommentReplayViewController.m
//  TianTianXinForMerchant
//
//  Created by ttx on 16/8/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "CommentReplayViewController.h"

@interface CommentReplayViewController ()<BasenavigationDelegate,UITextViewDelegate>

@end

@implementation CommentReplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"评论详情";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailTitle = @"提交";
    self.naviBar.delegate = self;
    
    self.replayTF.delegate = self;
    self.name.text = _dataModel.userNickName;
    self.detail.text = _dataModel.content;
    self.name.textColor = MacoTitleColor;
    self.detail.textColor = self.replayTF.textColor= MacoDetailColor;
    
    
    self.height.constant = [self cellHeight:_dataModel.content] + 40 + 10 + 140;
}

- (void)detailBtnClick
{
    if ([self.replayTF.text isEqualToString:@""] || !self.replayTF.text) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入回复内容" duration:1.5];
        return;
    }
    
    
    if (![TTXUserInfo shareUserInfos].currentLogined) {
        //判断是否先登录
        [self loginController];
        return;
    }
    
    NSDictionary *parms = @{@"id":_dataModel.commentId,
                            @"token":[TTXUserInfo shareUserInfos].token,
                            @"replyContent":self.replayTF.text};
    [SVProgressHUD showWithStatus:@"正在提交请求..."];
    [HttpClient POST:@"mch/comment/reply" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"replaySuccess" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        
    }];
    
}

- (void)backBtnClick
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""] || !textView.text) {
        self.alerLabel.hidden = NO;
    }else{
        self.alerLabel.hidden = YES;
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (textView.text.length > 101 && ! [text isEqualToString:@""]) {
        return NO;
    }
    return YES;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.alerLabel.hidden = YES;
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.replayTF resignFirstResponder];
    
}


- (CGFloat)cellHeight:(NSString *)textSting
{
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh  - 30, 0) font:[UIFont systemFontOfSize:13]];
    return size.height;
}


#pragma mark - 登录
- (void)loginController
{
    UINavigationController *navc = [LoginViewController controller];
    [self presentViewController:navc animated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
