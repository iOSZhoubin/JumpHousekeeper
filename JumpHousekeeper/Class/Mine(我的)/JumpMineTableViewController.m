//
//  JumpMineTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpMineTableViewController.h"
#import "JRSandBoxPath.h"
#import "CleanCaches.h"
#import "JumpMineTableViewCell.h"
#import "JumpAboutViewController.h"
#import "JumpAccountDetailTableViewController.h"
#import "JumpCollectionTableViewController.h"
#import "JumpFeedbackTableViewController.h"
#import "ChangePassWordViewController.h"
#import "JumpBaseTabBarViewController.h"
#import "JumpLoginViewController.h"

@interface JumpMineTableViewController ()

@end

@implementation JumpMineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}


-(void)setupUI{
    
    self.view.backgroundColor = BackGroundColor;
        
    [self.tableView registerNib:[UINib nibWithNibName:@"JumpMineTableViewCell" bundle:nil] forCellReuseIdentifier:@"JumpMineTableViewCell"];
        
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}


#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 1){
        
        return 3;
    }
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 4){
        
        static NSString *identifier = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.textLabel.text = @"退出登录";
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.textLabel.textColor = CustomerRed;
        
        return cell;
    }
    
    JumpMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JumpMineTableViewCell" forIndexPath:indexPath];
    
    [cell refreshWithIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0.01;
    }
    
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.section == 0){
        
        //帐户信息
        JumpAccountDetailTableViewController *vc = [[JumpAccountDetailTableViewController alloc]init];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 1){
        
        if(indexPath.row == 0){
            
            //我的收藏
            JumpCollectionTableViewController *vc = [[JumpCollectionTableViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 1){
            
            //关于我们
            JumpAboutViewController *vc = [[JumpAboutViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            //意见反馈
            JumpFeedbackTableViewController *vc = [[JumpFeedbackTableViewController alloc]init];
           
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section == 2){
        //清除缓存
        [self cleanRubbish];
        
    }else if (indexPath.section == 3){
        //修改密码
        ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
        
        vc.type = @"2";
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 4){
        //退出登录
       
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否退出登录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self exitLogin];
   
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        }];
        
        [alertController addAction:cancel];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
}


#pragma mark --- 清理缓存

-(void)cleanRubbish{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认清理缓存?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //获得要删除的path
        NSString *path = [JRSandBoxPath getCachesDirectory];
        //清空指定文件夹
        [CleanCaches clearCachesFromDirectoryPath:path];
        
        //清除UIWebView的缓存
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSURLCache * cache = [NSURLCache sharedURLCache];
        [cache removeAllCachedResponses];
        [cache setDiskCapacity:0];
        [cache setMemoryCapacity:0];
        
        [SVPShow showSuccessWithMessage:@"清理缓存成功"];

        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark --- 退出登录

-(void)exitLogin{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"0";
    parameters[@"t"] = @"2";

    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([SafeString(responseObject[@"result"]) isEqualToString:@"1"]){
            
            //退出登录后只保存账户名
            NSDictionary *userDict = [JumpKeyChain getKeychainDataForKey:@"userInfo"];
            
            NSString *account = SafeString(userDict[@"account"]);
            
            NSDictionary *userInfo = @{@"account":account,@"password":@"",@"isLogin":@"0"};
            
            [JumpKeyChain addKeychainData:userInfo forKey:@"userInfo"];
            
            JumpLoginViewController *vc = [[JumpLoginViewController alloc]init];
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            appdelegate.window.rootViewController = nav;
            
        }else{
            
            [SVPShow showFailureWithMessage:@"退出登录失败"];

        }
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"请求服务器失败"];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
