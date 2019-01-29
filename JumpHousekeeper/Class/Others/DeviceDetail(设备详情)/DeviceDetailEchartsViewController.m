//
//  DeviceDetailEchartsViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/25.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "DeviceDetailEchartsViewController.h"
#import "SecurityThingsViewController.h"
#import "DeviceHeadView.h"
#import "AccountDetailTableViewCell.h"
#import "DeviceDetailModel.h"

@interface DeviceDetailEchartsViewController ()

@property (strong,nonatomic) DeviceHeadView *headView;

@property (strong,nonatomic) DeviceDetailModel *model;

@end

@implementation DeviceDetailEchartsViewController

- (DeviceHeadView *)headView {
    
    if (!_headView) {
        
        _headView = [DeviceHeadView loadViewFromXib];
        
        _headView.frame = CGRectMake(0, 0, kWidth, 400);
        
    }
    
    return _headView;
}


- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.navigationItem.title = @"设备详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];
    
}

#pragma mark --- UITableView And DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 400;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountDetailTableViewCell" forIndexPath:indexPath];
    
    [cell refreshDeviceWithModel:self.model indexPath:indexPath];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row == 1){
        
        SecurityThingsViewController *vc = [[SecurityThingsViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
