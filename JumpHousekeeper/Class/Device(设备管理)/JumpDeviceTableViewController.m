//
//  JumpDeviceTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpDeviceTableViewController.h"
#import "SwitchDeviceTableViewCell.h"
#import "ScanningDeviceViewController.h"
#import "DeviceDetailEchartsViewController.h"
#import "JumpDeviceModel.h"

@interface JumpDeviceTableViewController ()

//添加设备
@property (strong,nonatomic) UIButton *toolBarBtn;
//数据源
@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation JumpDeviceTableViewController

-(UIButton *)toolBarBtn{
    
    if (!_toolBarBtn) {
        
        _toolBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, kWidth-60, 40)];
        
        _toolBarBtn.layer.cornerRadius =  5;
        
        [_toolBarBtn setTitle:@"添加新设备" forState:UIControlStateNormal];
        
//        [_toolBarBtn setImage:[UIImage imageNamed:@"scanningImage"] forState:UIControlStateNormal];
        
        [_toolBarBtn setTitleColor:CustomerBlue forState:UIControlStateNormal];
        
        [_toolBarBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
    [KNotification addObserver:self selector:@selector(notifi:) name:@"JumpDeviceTableViewController" object:nil];

}


- (void)notifi:(NSNotification *)note{

    [self refresh];
}

-(void)setupUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchDeviceTableViewCell" bundle:nil] forCellReuseIdentifier:@"SwitchDeviceTableViewCell"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.view.backgroundColor = BackGroundColor;
    
    self.dataArray = [NSMutableArray array];
    
    [self refresh];
}

-(void)refresh{
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(getDeviceList) loadMoreData:nil isBeginRefresh:YES];

}

#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    SwitchDeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchDeviceTableViewCell" forIndexPath:indexPath];
//
    JumpDeviceModel *model = self.dataArray[indexPath.row];
//
//    [cell refreshWithDeviceModel:model];
//
//    return cell;

    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = model.fname;
    
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
            
            JumpDeviceModel *model = self.dataArray[indexPath.row];
            
            [weakself getDeviceCode:model.fname];//删除设备
            
        }]];
        
        [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
        
        [weakself presentViewController:alertController animated:YES completion:nil];
        
        
    }];
    
    
    return @[delete];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JumpDeviceModel *model = self.dataArray[indexPath.row];
    
    DeviceDetailEchartsViewController *vc = [[DeviceDetailEchartsViewController alloc]init];
    
    vc.deviceId = SafeString(model.fid);
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --- 添加新设备

-(void)addAction:(UIButton *)sender{
    
    JumpLog(@"添加新设备");
//    %@/iosapi.php?m=0&t=6&d=%@", __BASE_URL__,equipmentNum]
    
    BOOL isopen = [JumpPublicAction isopenCamera];
    
    if(isopen){
        
        ScanningDeviceViewController *vc = [[ScanningDeviceViewController alloc]init];
        
        vc.type = @"2";
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"去开启访问相机权限?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [JumpPublicAction openfromSetting];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        }];
        
        [alertController addAction:cancel];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark --- 删除设备

-(void)getDeviceCode:(NSString *)deviceName{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parametets = [NSMutableDictionary dictionary];
    
    parametets[@"m"] = @"0";
    parametets[@"t"] = @"7";
    parametets[@"d"] = SafeString(deviceName);
    
    [SVPShow show];
    
    [AFNHelper get:BaseUrl parameter:parametets success:^(id responseObject) {
        
        NSString *code = SafeString(responseObject[@"result"]);
        
        [weakself deleteDevice:deviceName andCode:code];
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"删除失败"];

    }];

}

-(void)deleteDevice:(NSString *)deviceName andCode:(NSString *)code{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parametets = [NSMutableDictionary dictionary];
    
    parametets[@"m"] = @"0";
    parametets[@"t"] = @"7";
    parametets[@"d"] = SafeString(deviceName);
    parametets[@"c"] = SafeString(code);

    [AFNHelper get:BaseUrl parameter:parametets success:^(id responseObject) {
        
        [SVPShow showSuccessWithMessage:@"删除成功"];
        
        [weakself refresh];
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"删除失败"];

    }];
}



#pragma mark --- 获取设备列表

-(void)getDeviceList{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"2";
    parameters[@"t"] = @"0";
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        JumpLog(@"%@",responseObject);
        
        NSDictionary *dict = responseObject;
        
        if([SafeString(dict[@"message"]) isEqualToString:@"error"]){
            
            [SVPShow showInfoWithMessage:@"当前设备未登录"];
            
        }else{
            
            weakself.dataArray = [JumpDeviceModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
        [weakself.tableView.mj_header endRefreshing];
        
        [weakself.tableView reloadData];
        
    } faliure:^(id error) {
        
        JumpLog(@"%@",error);
        
        [weakself.tableView.mj_header endRefreshing];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    
    [KNotification removeObserver:self];
}


@end
