//
//  JumpFeedbackTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpFeedbackTableViewController.h"
#import "AccountDetailTableViewCell.h"
#import "ExperienceViewController.h"
#import "JumpTypeTableViewController.h"
#import "JumpquestionTypeTableViewController.h"

@interface JumpFeedbackTableViewController ()<OpinionTextDelegate>

//发送按钮
@property (strong,nonatomic) UIButton *toolBarBtn;
//存储内容的字典
@property (strong,nonatomic) NSMutableDictionary *contentDict;

@end

@implementation JumpFeedbackTableViewController

-(UIButton *)toolBarBtn{
    
    if (!_toolBarBtn) {
        
        _toolBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, kWidth-60, 40)];
        
        _toolBarBtn.layer.cornerRadius =  5;
        
        _toolBarBtn.layer.borderWidth = 1;
        
        _toolBarBtn.layer.borderColor = CustomerBlue.CGColor;
        
        [_toolBarBtn setTitleColor:CustomerBlue forState:UIControlStateNormal];
        
        [_toolBarBtn setTitle:@"发 送" forState:UIControlStateNormal];
        
        [_toolBarBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _toolBarBtn;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    kToolbarAppearItem(self.toolBarBtn);
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    kToolbarDisappearItem;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

-(void)setupUI{
    
    self.navigationItem.title = @"意见反馈";
    
    self.contentDict = [NSMutableDictionary dictionary];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountDetailTableViewCell"];
    
}



#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 1;
    }
    
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0.01;
    }
    
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountDetailTableViewCell" forIndexPath:indexPath];
    
    cell.delegate = self;
    
    [cell refreshOpinionWithContent:self.contentDict indexPath:indexPath];
    
    return cell;
}


#pragma mark --- cell代理方法

-(void)contentDetail:(NSString *)content andCell:(AccountDetailTableViewCell *)cell{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if(content.length > 0){
        
        if(indexPath.section == 2){
            
            if(indexPath.row == 0){
                
                self.contentDict[@"contactName"] = content;
                
            }else if (indexPath.row == 1){
                
                self.contentDict[@"contactNumber"] = content;

            }
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    L2CWeakSelf(self);
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self.view endEditing:YES];
    
    if(indexPath.section == 0){
        
        JumpLog(@"设备类型");
        JumpTypeTableViewController *vc = [[JumpTypeTableViewController alloc]init];
        
        vc.block = ^(NSDictionary *selectDict) {
            
            weakself.contentDict[@"deviceType"] = SafeString(selectDict[@"title"]);
            weakself.contentDict[@"deviceTypeId"] = SafeString(selectDict[@"id"]);
            
            [weakself.tableView reloadData];
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 1){
        
        if(indexPath.row == 0){
            
            JumpLog(@"问题类型");
            JumpquestionTypeTableViewController *vc = [[JumpquestionTypeTableViewController alloc]init];
            
            vc.block = ^(NSDictionary *selectDict) {
                
                weakself.contentDict[@"problemType"] = SafeString(selectDict[@"title"]);
                weakself.contentDict[@"problemTypeId"] = SafeString(selectDict[@"id"]);
                
                [weakself.tableView reloadData];
            };
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            JumpLog(@"问题描述");
            
            L2CWeakSelf(self);
            
            ExperienceViewController *vc = [[ExperienceViewController alloc]init];
            
            vc.vcTitle = @"问题描述";
            
            vc.ploText = @"请输入问题描述";
            
            vc.isEnditor = YES;
            
            vc.textLength = 250;
            
            vc.block = ^(NSString *backstr) {
                
                weakself.contentDict[@"remark"] = backstr;
                
                [weakself.tableView reloadData];
            };
            
            [self.navigationController pushViewController:vc animated:YES];

        }
        
    }
}


#pragma mark --- 发送

-(void)sendAction:(UIButton *)sender{
    
    JumpLog(@"发送");
    
    [self.view endEditing:YES];
}


@end
