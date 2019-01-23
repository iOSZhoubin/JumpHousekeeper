//
//  JumpMineTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpMineTableViewController.h"
#import "JumpMineTableViewCell.h"
#import "JumpAboutViewController.h"
#import "JumpAccountDetailTableViewController.h"
#import "JumpCollectionTableViewController.h"

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
        
        cell.textLabel.text = @"注销登录";
        
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
    
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.section == 0){
        
        //账户信息
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
        }
        
    }else if (indexPath.section == 2){
        //清除缓存
    }else if (indexPath.section == 3){
        //修改密码
    }else if (indexPath.section == 4){
        //注销登录
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
