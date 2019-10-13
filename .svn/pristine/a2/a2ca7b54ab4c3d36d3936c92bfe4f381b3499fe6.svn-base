//
//  JumpSafeTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/10/9.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpSafeTableViewController.h"
#import "AccountDetailTableViewCell.h"


@interface JumpSafeTableViewController ()

@property (strong,nonatomic) NSDictionary *dictory;

@end

@implementation JumpSafeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"安全监控";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(loadData) loadMoreData:nil isBeginRefresh:YES];

}

#pragma mark --- UITableViewDelegate And DataSource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return SafeString(self.dictory[@"servername"]);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountDetailTableViewCell" forIndexPath:indexPath];
    
    [cell refreshSafeWithDict:self.dictory ftype:self.ftype indexPath:indexPath];
    
    return cell;
}


#pragma mark --- 安全监控

-(void)loadData{
    
    L2CWeakSelf(self);
    
    [SVPShow show];
    
    NSString *url = [NSString stringWithFormat:@"%@?m=2&t=7&d=%@",BaseUrl,SafeString(self.deviceId)];
    
    [AFNHelper get:url parameter:nil success:^(id responseObject) {
        
        JumpLog(@"%@",responseObject);
        
        NSArray *array = responseObject[@"result"];
        
        if(array.count > 0){
            
            weakself.dictory = array[0];
            
        }else{
            
            [SVPShow showInfoWithMessage:@"暂无信息"];
        }
        
        [weakself.tableView reloadData];
        
        [SVPShow disMiss];
        
        [weakself.tableView.mj_header endRefreshing];
        
    } faliure:^(id error) {
        
        [SVPShow showInfoWithMessage:@"请求服务器失败"];
        
        [weakself.tableView.mj_header endRefreshing];

    }];
    
}

@end
