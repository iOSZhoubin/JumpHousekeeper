//
//  JumpCollectionTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpCollectionTableViewController.h"
#import "JumpAgreementViewController.h"
#import "JumpInfomationTableViewCell.h"
#import "JumpInformationModel.h"

@interface JumpCollectionTableViewController ()

@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation JumpCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JumpInfomationTableViewCell" bundle:nil] forCellReuseIdentifier:@"JumpInfomationTableViewCell"];
    
    [self refresh];
}

-(void)refresh{
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(getCollectionList) loadMoreData:nil isBeginRefresh:YES];

}


#pragma mark --- UItableView数据源和代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JumpInfomationTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"JumpInfomationTableViewCell" forIndexPath:indexPath];
    
    JumpInformationModel *model = self.dataArray[indexPath.row];
    
    [cell refreshWithModel:model];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    L2CWeakSelf(self);
    
    JumpInformationModel *model = self.dataArray[indexPath.row];
    
    UITableViewRowAction *cancel = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"确认取消收藏?" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction: [UIAlertAction actionWithTitle:@"确认" style: UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            JumpLog(@"确认");
            [weakself deleteAction:SafeString(model.fid)];
            
        }]];
        
        [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
        
        [weakself presentViewController:alertController animated:YES completion:nil];
        
    }];
    
    return @[cancel];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JumpInformationModel *model = self.dataArray[indexPath.row];
    
    JumpAgreementViewController *vc = [[JumpAgreementViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.isShow = NO;
    
    vc.url = [NSString stringWithFormat:@"%@%@",ImageBaseUrl,model.uri];
    
    vc.titleName = SafeString(model.title);
    
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark --- 获取收藏列表

-(void)getCollectionList{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"1";
    parameters[@"t"] = @"3";
    parameters[@"s"] = @"1";
    parameters[@"id"] = @"0";
    parameters[@"c"] = @"10";
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        
        if([SafeString(dict[@"message"]) isEqualToString:@"error"]){
            
            [SVPShow showInfoWithMessage:@"当前设备未登录"];
            
        }else{
            
            weakself.dataArray = [JumpInformationModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];

            
            [weakself.tableView reloadData];

        }
        
        [weakself.tableView.mj_header endRefreshing];
        
    } faliure:^(id error) {
        
        [weakself.tableView.mj_header endRefreshing];
        
    }];
}

#pragma mark -- 删除收藏信息

-(void)deleteAction:(NSString *)collectionId{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"1";
    parameters[@"t"] = @"3";
    parameters[@"s"] = @"3";
    parameters[@"id"] = collectionId;

    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([responseObject[@"result"] isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"取消收藏成功"];
        
            [weakself refresh];
            
        }else{
            
            [SVPShow showSuccessWithMessage:@"取消收藏失败"];
        }
        
    } faliure:^(id error) {
        
        [SVPShow showSuccessWithMessage:@"请求服务器失败"];
        
    }];
}

@end
