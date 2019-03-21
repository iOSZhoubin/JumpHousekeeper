//
//  DeviceDetailEchartsViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/25.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "DeviceDetailEchartsViewController.h"
#import "DeviceHeadView.h"
#import "AccountDetailTableViewCell.h"
#import "DeviceDetailModel.h"
#import "SafeThingsTableViewController.h"

@interface DeviceDetailEchartsViewController ()

@property (strong,nonatomic) DeviceHeadView *headView;

@property (strong,nonatomic) DeviceDetailModel *model;

@property (strong,nonatomic) NSMutableDictionary *dict;

@end

@implementation DeviceDetailEchartsViewController

- (DeviceHeadView *)headView {
    
    if (!_headView) {
        
        _headView = [DeviceHeadView loadViewFromXib];
        
        [_headView deviceDetailWitdId:self.deviceId];
        
        _headView.frame = CGRectMake(0, 0, kWidth, 480);
        
    }
    
    return _headView;
}


- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.navigationItem.title = @"设备详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];

    [self loadData];
    
    [self infoStatus];
    
}



#pragma mark --- UITableView And DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSString *status = [NSString stringWithFormat:@"%@",self.dict[@"online"]];

    if([status isEqualToString:@"1"]){

        return 480;

    }else{
        
        return 150;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountDetailTableViewCell" forIndexPath:indexPath];
    
    NSString *status = [NSString stringWithFormat:@"%@",self.dict[@"online"]];
    
    [cell refreshDeviceWithModel:self.model status:SafeString(status) indexPath:indexPath];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row == 7){
        
        SafeThingsTableViewController *vc = [[SafeThingsTableViewController alloc]init];
        
        vc.deviceId = self.deviceId;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark ---- 设备详情

-(void)loadData{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"2";
    parameters[@"t"] = @"3";
    parameters[@"d"] = self.deviceId;

    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        weakself.model = [DeviceDetailModel mj_objectWithKeyValues:responseObject[@"result"]];

        [weakself.tableView reloadData];
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"设备详情获取失败"];
        
    }];
}


#pragma mark --- 获取CPU，内存和设备状态

-(void)infoStatus{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"2";
    parameters[@"t"] = @"1";
    parameters[@"d"] = self.deviceId;
    parameters[@"p"] = @"1";

    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        JumpLog(@"设备信息：====%@",responseObject);
            
        weakself.dict = responseObject[@"result"];
        
        NSString *status = [NSString stringWithFormat:@"%@",weakself.dict[@"online"]];
        
        [weakself.headView refreshCpu:SafeString(weakself.dict[@"cpu"]) memory:SafeString(weakself.dict[@"mem"]) andStatus:status];
        
        [weakself.tableView reloadData];
        
    } faliure:^(id error) {
        
        [SVPShow showInfoWithMessage:@"请求服务器失败"];
        
    }];
    
}




@end
