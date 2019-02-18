//
//  JumpAccountDetailTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpAccountDetailTableViewController.h"
#import "AccountDetailTableViewCell.h"
#import "JumpAccountDetailModel.h"
#import "ExperienceViewController.h"

@interface JumpAccountDetailTableViewController ()

//是否可以编辑
@property (copy,nonatomic) NSString *isEnabel;
//模型
@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation JumpAccountDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户信息";
    
    self.isEnabel = @"0"; //默认不可编辑
    
    self.dataArray = [NSMutableArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(enabel:)];
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(getAccountDetail) loadMoreData:nil isBeginRefresh:YES];
}

#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountDetailTableViewCell" forIndexPath:indexPath];
    
    if(self.dataArray.count > 0){
     
        JumpAccountDetailModel *model = self.dataArray[0];
        
        [cell refreshWithModel:model isEnabel:self.isEnabel indexPath:indexPath];
        
    }else{
        
        [cell refreshWithModel:nil isEnabel:self.isEnabel indexPath:indexPath];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row == 5){
        //详细地址
            
        ExperienceViewController *vc = [[ExperienceViewController alloc]init];
        
        BOOL isEditor;
        
        if([self.isEnabel isEqualToString:@"1"]){
            
            isEditor = YES;
            
        }else{
            
            isEditor = NO;
        }
        
        JumpAccountDetailModel *model = self.dataArray[0];

        vc.isEnditor = isEditor;
        
        vc.vcTitle = @"详细地址";
        
        vc.saveText = model.address;
        
        [self.navigationController pushViewController:vc animated:YES];

    }
}


#pragma mark --- 编辑功能

-(void)enabel:(UIBarButtonItem *)item{
    
    if([item.title isEqualToString:@"编辑"]){
        
        item.title = @"保存";
        
        self.isEnabel = @"1";
        
    }else{
        
        item.title = @"编辑";
        
        self.isEnabel = @"0";
    }
    
    [self.tableView reloadData];
}

#pragma mark --- cell的代理方法

-(void)contentDetail:(NSString *)content andCell:(AccountDetailTableViewCell *)cell{
    
    if(SafeString(content).length > 0){
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        JumpAccountDetailModel *model = self.dataArray[0];
        
        switch (indexPath.row) {
            case 0://昵称
                model.nickname = SafeString(content);
                break;
            case 2://真实姓名
                model.truename = SafeString(content);
                break;
            case 4://邮箱
                model.mailnum = SafeString(content);
                break;
                
            default:
                break;
        }

    }
}


#pragma mark --- 获取账户信息详情

-(void)getAccountDetail{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"m"] = @"4";
    parameters[@"t"] = @"2";
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        
        if([SafeString(dict[@"message"]) isEqualToString:@"error"]){
            
            [SVPShow showInfoWithMessage:@"当前设备未登录"];
            
        }else{
            
            weakself.dataArray = [JumpAccountDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
        [weakself.tableView.mj_header endRefreshing];
        
        [weakself.tableView reloadData];
        
    } faliure:^(id error) {
        
        [weakself.tableView.mj_header endRefreshing];

    }];
}

@end
