//
//  JumpCollectionTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpCollectionTableViewController.h"
#import "JumpAgreementViewController.h"
#import "JumpInfomationTableViewCell.h"

@interface JumpCollectionTableViewController ()

@end

@implementation JumpCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JumpInfomationTableViewCell" bundle:nil] forCellReuseIdentifier:@"JumpInfomationTableViewCell"];

}



#pragma mark --- UItableView数据源和代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JumpInfomationTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"JumpInfomationTableViewCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JumpAgreementViewController *vc = [[JumpAgreementViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.isShow = NO;
    
    vc.url = @"https://www.baidu.com";
    
    vc.titleName = @"资讯详情";
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
