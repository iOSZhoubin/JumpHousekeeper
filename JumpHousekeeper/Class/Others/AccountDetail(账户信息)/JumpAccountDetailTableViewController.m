//
//  JumpAccountDetailTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpAccountDetailTableViewController.h"
#import "AccountDetailTableViewCell.h"
#import "JumpAccountDetailModel.h"
#import "ExperienceViewController.h"

@interface JumpAccountDetailTableViewController ()

@end

@implementation JumpAccountDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户信息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];
    
}

#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountDetailTableViewCell" forIndexPath:indexPath];
    
    [cell refreshWithModel:nil indexPath:indexPath];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row == 5){
        //详细地址
            
        ExperienceViewController *vc = [[ExperienceViewController alloc]init];
        
        vc.vcTitle = @"详细地址";
        
        vc.saveText = @"陕西省西安市高新技术产业开发区科技二路西安交大捷普网络科技有限公司";
        
        [self.navigationController pushViewController:vc animated:YES];

    }
}



@end
