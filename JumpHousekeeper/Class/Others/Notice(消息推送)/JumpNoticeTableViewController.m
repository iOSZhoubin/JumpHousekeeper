//
//  JumpNoticeTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/4/10.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpNoticeTableViewController.h"
#import "JumpNoticeTableViewCell.h"

@interface JumpNoticeTableViewController ()

@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation JumpNoticeTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
    
    self.tableView.rowHeight = 100;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JumpNoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"JumpNoticeTableViewCell"];
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(message) loadMoreData:nil isBeginRefresh:YES];
    
    [KNotification addObserver:self selector:@selector(notifi:) name:@"JumpNoticeTableViewController" object:nil];

}

//接收到了发送来的消息
- (void)notifi:(NSNotification *)note{
    
    [self message];
}


#pragma mark --- UItableView数据源和代理

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JumpNoticeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"JumpNoticeTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    [cell refreshWithDict:dict];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    L2CWeakSelf(self);
    
    UITableViewRowAction *cancel = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"确认删除?" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction: [UIAlertAction actionWithTitle:@"确认" style: UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            //删除数组中的数据，并同步UserDefaults数据
            [weakself.dataArray removeObjectAtIndex:indexPath.row];
            
            [weakself.tableView reloadData];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:weakself.dataArray forKey:@"noticeList"];
            
            [defaults synchronize];
            
        }]];
        
        [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
        
        [weakself presentViewController:alertController animated:YES completion:nil];
        
    }];
    
    return @[cancel];
    
}



#pragma mark -- 消息

-(void)message{
    
    self.dataArray = [NSMutableArray array];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [defaults objectForKey:@"noticeList"];
    
    [self.dataArray addObjectsFromArray:array];
    
    if(self.dataArray.count < 1){
     
        [SVPShow showInfoWithMessage:@"暂无推送消息"];
    }

    [self.tableView.mj_header endRefreshing];

    [self.tableView reloadData];
}


@end
