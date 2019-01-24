//
//  JumpSupportViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpSupportViewController.h"
#import "ConfigurationTableViewController.h"

@interface JumpSupportViewController ()

@end

@implementation JumpSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark --- 配置向导

- (IBAction)configurationAction:(UIButton *)sender {
    
    JumpLog(@"配置向导");
    
    ConfigurationTableViewController *vc = [[ConfigurationTableViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.type = @"1";
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- 常见问题

- (IBAction)problemAction:(UIButton *)sender {
   
    JumpLog(@"常见问题");
    
    ConfigurationTableViewController *vc = [[ConfigurationTableViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.type = @"2";
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
