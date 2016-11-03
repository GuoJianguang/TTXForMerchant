//
//  MyInfoEditViewController.m
//  天添薪
//
//  Created by ttx on 16/1/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MyInfoEditViewController.h"
#import "MyWalletTableViewCell.h"
#import "EditPasswordViewController.h"
#import "ZLPhoto.h"
#import <QiniuSDK.h>
#import "LogOutTableViewCell.h"
#import "AboutUsViewController.h"
#import "AboutUsNewViewController.h"


@interface MyInfoEditViewController()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong)NSMutableArray *datasouceArray;
@property (nonatomic,strong) UIActionSheet *actionSheet;

@end

@implementation MyInfoEditViewController

- (UIActionSheet *)actionSheet
{
    if(_actionSheet == nil)
    {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"您确定要退出登录吗？" delegate:self cancelButtonTitle:@"点错了" destructiveButtonTitle:nil otherButtonTitles:@"退出", nil];
    }
    
    return _actionSheet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"基本设置";
    
    NSDictionary *dic1 = @{@"titel":@"修改密码",@"image_name":@"icon_change-password",@"count":@"0"};
    MyWalletViewModel *model1 = [MyWalletViewModel dataWithDic:dic1];
    NSDictionary *dic2 = @{@"titel":@"关于天添薪",@"image_name":@"icon_about",@"count":@"0"};
    MyWalletViewModel *model2 = [MyWalletViewModel dataWithDic:dic2];
   
    self.datasouceArray = [NSMutableArray arrayWithArray:@[model1,model2,model1]];
    [self.tableView reloadData];
    self.tableView.backgroundColor = [UIColor clearColor];
    
}

- (NSMutableArray *)datasouceArray
{
    if (!_datasouceArray) {
        _datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasouceArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 160;
    }
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        LogOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LogOutTableViewCell indentify]];
        if (!cell) {
            cell = [LogOutTableViewCell newCell];
        
        }
        return cell;
    }
    MyWalletTableViewCell *cell = (MyWalletTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[MyWalletTableViewCell indentify]];
    if (!cell) {
        cell = [MyWalletTableViewCell newCell];
    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.layer.cornerRadius = 8;
    cell.dataModel = self.datasouceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {

        case 0://修改密码
        {
            EditPasswordViewController *passwordVC = [[EditPasswordViewController alloc]init];
            [self.navigationController pushViewController:passwordVC animated:YES];
        }
            break;
        case 1://关于天添薪
        {
//            AboutUsNewViewController *aboutsVC = [[AboutUsNewViewController alloc]init];
//            [self.navigationController pushViewController:aboutsVC animated:YES];
            AboutUsViewController *aboutsVC = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutsVC animated:YES];
        }
            break;
        case 2://退出登录
        {
            if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                NSArray *titles = @[@"退出"];
                [self addActionTarget:alert titles:titles];
                [self addCancelActionTarget:alert title:@"取消"];
                // 会更改UIAlertController中所有字体的内容（此方法有个缺点，会修改所以字体的样式）
                UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
                UIFont *font = [UIFont systemFontOfSize:15];
                [appearanceLabel setFont:font];
                
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                [self.actionSheet showInView:self.view];
            }
//            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"您确认要退出登录吗？" delegate:self cancelButtonTitle:@"不，点错了" destructiveButtonTitle:nil otherButtonTitles:@"确认", nil];
//            [sheet showInView:self.view];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            [HttpClient POST:@"mch/logout" parameters:@{@"token":[TTXUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];
            [TTXUserInfo shareUserInfos].currentLogined = NO;
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:LoginUserPassword];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:IsFirstLaunch];
            //统计新增用户
            [MobClick profileSignOff];
            [[NSUserDefaults standardUserDefaults]synchronize];
//            [[NSNotificationCenter defaultCenter]postNotificationName:LogOutNSNotification object:nil userInfo:nil];
          [self presentViewController:[[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"] animated:YES completion:^{
          }] ;
        }
            break;
        default:
            break;
    }
}
// 添加其他按钮
- (void)addActionTarget:(UIAlertController *)alertController titles:(NSArray *)titles
{
    for (NSString *title in titles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [HttpClient POST:@"mch/logout" parameters:@{@"token":[TTXUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            }];
            [TTXUserInfo shareUserInfos].currentLogined = NO;
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:LoginUserPassword];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:IsFirstLaunch];
            //统计新增用户
            [MobClick profileSignOff];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self presentViewController:[[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"] animated:YES completion:^{
            }] ;
        }];
//        [action setValue:MacoColor forKey:@"_titleTextColor"];
        [alertController addAction:action];
    }
}

// 取消按钮
- (void)addCancelActionTarget:(UIAlertController *)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
//    [action setValue:MacoTitleColor forKey:@"_titleTextColor"];
    [alertController addAction:action];
}



- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for ( id subViwe in actionSheet.subviews) {
        if ([subViwe isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)subViwe;
            [button setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
