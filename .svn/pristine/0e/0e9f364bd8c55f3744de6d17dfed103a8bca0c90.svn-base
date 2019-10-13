//
//  JumpMoreTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/10/9.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpMoreTableViewController.h"
#import "AccountDetailTableViewCell.h"
#import "JumpMoreModel.h"
#import "JumpSafeTableViewController.h"

@interface JumpMoreTableViewController ()

@property (strong,nonatomic) JumpMoreModel *model;

@end

@implementation JumpMoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设备详情";

    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(loadData) loadMoreData:nil isBeginRefresh:YES];
}



#pragma mark --- UITableViewDelegate And DataSource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 2){
            //激活模块
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"已激活模块" message:SafeString(self.model.activemodule) preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];

            [alertController addAction:ok];

            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }else if (indexPath.row == 7){
            //安全监控
            JumpSafeTableViewController *vc = [[JumpSafeTableViewController alloc]init];
            
            vc.deviceId = self.deviceId;
            
            vc.ftype = self.ftype;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 8;
    }
    
    NSInteger num = [AccountDetailTableViewCell returnModelArray:self.model].count;
    
    return num;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        
        return @"设备引擎状态";
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0.01;
    }
    
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDetailTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AccountDetailTableViewCell" forIndexPath:indexPath];
    
    [cell refreshMoreVcWithModel:self.model indexPath:indexPath];
    
    return cell;
}


#pragma mark --- 请求数据

-(void)loadData{
    
    L2CWeakSelf(self);
    
    NSString *url = [NSString stringWithFormat:@"%@?m=2&t=6&d=%@",BaseUrl,SafeString(self.deviceId)];
    
    [AFNHelper get:url parameter:nil success:^(id responseObject) {
        
        JumpLog(@"%@",responseObject);
        
        weakself.model = [JumpMoreModel mj_objectWithKeyValues:responseObject[@"result"]];
        
        [weakself.tableView reloadData];
        
        [weakself.tableView.mj_header endRefreshing];

    } faliure:^(id error) {
        
        [SVPShow showInfoWithMessage:@"请求服务器失败"];
        
        [weakself.tableView.mj_header endRefreshing];

    }];
}





@end
