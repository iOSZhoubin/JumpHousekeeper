//
//  SafeThingsTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/3/20.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "SafeThingsTableViewController.h"
#import "SafeThingsTableViewCell.h"
#import "SafeThingsModel.h"

@interface SafeThingsTableViewController()

@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation SafeThingsTableViewController

-(NSMutableArray *)dataArray{
    
    if(!_dataArray){
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"最新安全事件";
    
    self.tableView.rowHeight = 120;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SafeThingsTableViewCell" bundle:nil] forCellReuseIdentifier:@"SafeThingsTableViewCell"];
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(safeThings) loadMoreData:nil isBeginRefresh:YES];
}


#pragma mark --- UItableView数据源和代理


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SafeThingsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"SafeThingsTableViewCell" forIndexPath:indexPath];
    
    SafeThingsModel *model = self.dataArray[indexPath.row];
    
    [cell refreshWithSafeModel:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}



#pragma mark --- 获取安全信息

-(void)safeThings{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"2";
    parameters[@"t"] = @"2";
    parameters[@"d"] = self.deviceId;
    parameters[@"p"] = @"1";
    parameters[@"c"] = @"5";
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        NSArray *array = responseObject[@"result"][@"result"];
                
        weakself.dataArray = [SafeThingsModel mj_objectArrayWithKeyValuesArray:array];

        [weakself.tableView reloadData];
        
        [weakself.tableView.mj_header endRefreshing];

    } faliure:^(id error) {
        
        [SVPShow showInfoWithMessage:@"请求服务器失败"];
        
        [weakself.tableView.mj_header endRefreshing];

    }];
}

@end
