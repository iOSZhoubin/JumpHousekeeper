//
//  JumpDeviceTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpDeviceTableViewController.h"
#import "SwitchDeviceTableViewCell.h"

@interface JumpDeviceTableViewController ()

@property (strong,nonatomic) UIButton *toolBarBtn;

@end

@implementation JumpDeviceTableViewController

-(UIButton *)toolBarBtn{
    
    if (!_toolBarBtn) {
        
        _toolBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, kWidth-60, 40)];
        
        _toolBarBtn.backgroundColor = BackGroundColor;
        
        _toolBarBtn.layer.cornerRadius =  5;
        
        [_toolBarBtn setTitle:@"   添加新设备" forState:UIControlStateNormal];
        
        [_toolBarBtn setImage:[UIImage imageNamed:@"scanningImage"] forState:UIControlStateNormal];
        
        [_toolBarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_toolBarBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _toolBarBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}


-(void)setupUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchDeviceTableViewCell" bundle:nil] forCellReuseIdentifier:@"SwitchDeviceTableViewCell"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}

#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SwitchDeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchDeviceTableViewCell" forIndexPath:indexPath];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    L2CWeakSelf(self);
    
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"确认删除?" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction: [UIAlertAction actionWithTitle:@"删除" style: UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            JumpLog(@"删除");
            
        }]];
        
        [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
        
        [weakself presentViewController:alertController animated:YES completion:nil];
        
        
    }];
    
//    UITableViewRowAction *editor = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//
//    }];
//
//    editor.backgroundColor = RGB(184, 215, 254, 1);
    
    return @[delete];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark --- 添加新设备

-(void)addAction:(UIButton *)sender{
    
    JumpLog(@"添加新设备");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
