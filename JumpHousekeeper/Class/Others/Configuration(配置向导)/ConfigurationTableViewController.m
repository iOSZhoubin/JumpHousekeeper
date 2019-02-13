//
//  ConfigurationTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "ConfigurationTableViewController.h"
#import "AccountDetailTableViewCell.h"
#import "JumpAgreementViewController.h"
#import "JumpTypeModel.h"

@interface ConfigurationTableViewController ()

@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation ConfigurationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(loadNewData) loadMoreData:nil isBeginRefresh:YES];
}

-(void)creatUI{
    
    if([self.type isEqualToString:@"1"]){
        
        self.navigationItem.title = @"配置向导";
        
    }else{
        
        self.navigationItem.title = @"常见问题";
    }
    
    self.dataArray = [NSMutableArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];
}



#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountDetailTableViewCell" forIndexPath:indexPath];
    
    JumpTypeModel *model = self.dataArray[indexPath.row];
    
    [cell refreshWithModel:model];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JumpTypeModel *model = self.dataArray[indexPath.row];

    JumpAgreementViewController *vc = [[JumpAgreementViewController alloc]init];
    
    vc.url = @"https://www.baidu.com";
    
    vc.titleName = model.cname;

    vc.isShow = NO;
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark --- 获取titleName

-(void)loadNewData{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"2";
    parameters[@"t"] = @"5";
    parameters[@"d"] = @"0";
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        
        if([SafeString(dict[@"message"]) isEqualToString:@"error"]){
            
            [SVPShow showInfoWithMessage:@"当前设备未登录"];
            
        }else{
            
            weakself.dataArray = [JumpTypeModel mj_objectArrayWithKeyValuesArray:dict[@"result"]];
        }
        
        [weakself.tableView.mj_header endRefreshing];
        
        [weakself.tableView reloadData];
        
    } faliure:^(id error) {
        
        JumpLog(@"%@",error);
        
        [weakself.tableView.mj_header endRefreshing];
    }];
}

@end
