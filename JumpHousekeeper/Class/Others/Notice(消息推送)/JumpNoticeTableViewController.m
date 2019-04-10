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

#pragma mark -- 消息

-(void)message{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.dataArray = [defaults objectForKey:@"noticeList"];
    
    if(self.dataArray.count < 1){
     
        [SVPShow showInfoWithMessage:@"暂无推送消息"];
    }

    [self.tableView.mj_header endRefreshing];

    [self.tableView reloadData];
}


@end
