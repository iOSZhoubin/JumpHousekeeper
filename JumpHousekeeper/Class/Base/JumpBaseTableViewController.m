//
//  JumpBaseTableViewController.m
//  Jump
//
//  Created by jumpapp1 on 2019/1/2.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpBaseTableViewController.h"

@interface JumpBaseTableViewController ()

@end

@implementation JumpBaseTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.view.backgroundColor = BackGroundColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}

- (void)backAction {
    
    [SVPShow disMiss];
    
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
