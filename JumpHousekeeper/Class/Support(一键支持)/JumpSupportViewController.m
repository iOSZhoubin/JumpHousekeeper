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

#pragma mark --- 打电话，邮件

- (IBAction)callPhone:(UIButton *)sender {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"快捷支持" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"拨打电话:029-88333000" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:029-88333000"]];
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"拨打电话:800-840-9939" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:8008409939"]];
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"发送邮件:support@jump.net.cn" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
       [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto://support@jump.net.cn"]];
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"访问网站:http://www.jump.net.cn" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jump.net.cn"]];
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
   
}

@end
