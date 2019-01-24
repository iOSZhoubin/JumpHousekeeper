//
//  ConfigurationTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "ConfigurationTableViewController.h"
#import "AccountDetailTableViewCell.h"
#import "JumpAgreementViewController.h"

@interface ConfigurationTableViewController ()

@end

@implementation ConfigurationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
}

-(void)creatUI{
    
    if([self.type isEqualToString:@"1"]){
        
        self.navigationItem.title = @"配置向导";
        
    }else{
        
        self.navigationItem.title = @"常见问题";
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];
}



#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountDetailTableViewCell" forIndexPath:indexPath];
    
    [cell refreshWithindexPath:indexPath];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSArray *titleArray = @[@"Web应用防火墙",@"入侵检测",@"入侵防御",@"漏洞扫描",@"防火墙",@"信息审计",@"服务器维护",@"数据库审计",@"SSLVPN",@"SOC"];

    JumpAgreementViewController *vc = [[JumpAgreementViewController alloc]init];
    
    vc.url = @"https://www.baidu.com";
    
    vc.titleName = titleArray[indexPath.row];

    vc.isShow = NO;
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
