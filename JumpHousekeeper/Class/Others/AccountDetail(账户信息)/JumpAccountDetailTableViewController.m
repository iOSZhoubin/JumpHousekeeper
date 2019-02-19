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

@interface JumpAccountDetailTableViewController ()<OpinionTextDelegate>

//是否可以编辑
@property (copy,nonatomic) NSString *isEnabel;
//模型
@property (strong,nonatomic) NSMutableArray *dataArray;

@property (strong,nonatomic) JumpAccountDetailModel *model;

@end

@implementation JumpAccountDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"帐户信息";
    
    self.isEnabel = @"0"; //默认不可编辑
    
    self.dataArray = [NSMutableArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(enabel:)];
    
    [self refresh];
}

-(void)refresh{
    
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
    
    cell.delegate = self;
    
    if(self.dataArray.count > 0){
     
        self.model = self.dataArray[0];
        
        [cell refreshWithModel:self.model isEnabel:self.isEnabel indexPath:indexPath];
        
    }else{
        
        [cell refreshWithModel:nil isEnabel:self.isEnabel indexPath:indexPath];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    L2CWeakSelf(self);
    
    if(indexPath.row == 5){
        //详细地址
            
        ExperienceViewController *vc = [[ExperienceViewController alloc]init];
        
        BOOL isEditor;
        
        if([self.isEnabel isEqualToString:@"1"]){
            
            isEditor = YES;
            
        }else{
            
            isEditor = NO;
        }
        
        self.model = self.dataArray[0];

        vc.isEnditor = isEditor;
        
        vc.vcTitle = @"详细地址";
        
        vc.saveText = self.model.address;
        
        vc.block = ^(NSString *backstr) {
            
            weakself.model.address = backstr;
            
            [weakself.tableView reloadData];
        };
        
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
        
        [self saveAction];
    }
    
    [self.tableView reloadData];
}


#pragma mark --- 保存方法

-(void)saveAction{
    
    L2CWeakSelf(self);
    
    [self.view endEditing:YES];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"nickname"] = SafeString(self.model.nickname);
    parameters[@"truename"] = SafeString(self.model.truename);
    parameters[@"phonenum"] = SafeString(self.model.phonenum);
    parameters[@"mailnum"] = SafeString(self.model.mailnum);
    parameters[@"address"] = SafeString(self.model.address);

    [SVPShow show];
    
    NSString *url = [NSString stringWithFormat:@"%@?m=4&t=3",BaseUrl];
 
    [AFNHelper post:url parameters:parameters success:^(id responseObject) {
        
        if([SafeString(responseObject[@"result"]) isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"保存成功"];

            [weakself refresh];

        }else{
            
            [SVPShow showFailureWithMessage:@"保存失败"];
        }
        
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"保存失败"];
    }];

}

#pragma mark --- cell的代理方法

-(void)contentDetail:(NSString *)content andCell:(AccountDetailTableViewCell *)cell{
    
    if(SafeString(content).length > 0){
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        switch (indexPath.row) {
            case 0://昵称
                self.model.nickname = SafeString(content);
                break;
            case 2://真实姓名
                self.model.truename = SafeString(content);
                break;
            case 4://邮箱
                self.model.mailnum = SafeString(content);
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
            
            weakself.model = weakself.dataArray[0];
        }
        
        [weakself.tableView.mj_header endRefreshing];
        
        [weakself.tableView reloadData];
        
    } faliure:^(id error) {
        
        [weakself.tableView.mj_header endRefreshing];

    }];
}

@end
