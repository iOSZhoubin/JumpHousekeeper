//
//  JumpTypeTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpTypeTableViewController.h"
#import "JumpTypeModel.h"

@interface JumpTypeTableViewController ()

//数据源
@property (strong,nonatomic) NSMutableArray *muArray;
//选择的数据
@property (strong,nonatomic) NSDictionary *selectDict;

@end

@implementation JumpTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(loadNewData) loadMoreData:nil isBeginRefresh:YES];
    
    [self setupUI];
    
}



-(void)setupUI{

    if([self.type isEqualToString:@"1"]){
        
        self.navigationItem.title = @"设备类型";
        
    }else{
        
        self.navigationItem.title = @"问题类型";
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureAction:)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.muArray = [NSMutableArray array];
    
//    for(NSInteger i=0;i<10;i++){
//        
//        NSString *str = [NSString stringWithFormat:@"类型标题%ld",i + 1];
//        NSString *strId = [NSString stringWithFormat:@"%ld",i];
//
//        NSDictionary *dict = @{@"title":str,@"id":strId};
//        
//        [self.muArray addObject:dict];
//    }
    
}


#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.muArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    JumpTypeModel *model = self.muArray[indexPath.row];
    JumpTypeModel *selectModel = [JumpTypeModel mj_objectWithKeyValues:self.selectDict];
    
    cell.textLabel.text = SafeString(model.fname);
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    if([SafeString(model.fid) isEqualToString:SafeString(selectModel.fid)]){
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    self.selectDict = self.muArray[indexPath.row];
    
    [self.tableView reloadData];
    
}



#pragma mark --- 点击确定的方法

-(void)sureAction:(UIBarButtonItem *)item{
    
    if(self.block){
        
        JumpTypeModel *selectModel = [JumpTypeModel mj_objectWithKeyValues:self.selectDict];

        NSString *title = SafeString(selectModel.fname);
        NSString *titleId = SafeString(selectModel.fid);
        
        NSDictionary *muDict = @{@"title":title,@"id":titleId};

        self.block(muDict);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark ---  获取类型

-(void)loadNewData{
    
    L2CWeakSelf(self);
    
    if([self.type isEqualToString:@"1"]){
        //设备类型
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        parameters[@"m"] = @"2";
        parameters[@"t"] = @"5";
        parameters[@"d"] = @"0";

        [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
            
            JumpLog(@"%@",responseObject);
            
            weakself.muArray = [JumpTypeModel mj_objectArrayWithKeyValuesArray:responseObject];
            
            [weakself.tableView.mj_header endRefreshing];
            
            [weakself.tableView reloadData];
            
        } faliure:^(id error) {
            
            JumpLog(@"%@",error);
            
            [weakself.tableView.mj_header endRefreshing];
        }];
        
    }else{
        //问题类型
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        parameters[@"m"] = @"4";
        parameters[@"t"] = @"0";
        parameters[@"p"] = @"0";
        
        [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
            
            JumpLog(@"%@",responseObject);
            
            weakself.muArray = [JumpTypeModel mj_objectArrayWithKeyValuesArray:responseObject];
            
            [weakself.tableView.mj_header endRefreshing];
            
            [weakself.tableView reloadData];
            
        } faliure:^(id error) {
            
            JumpLog(@"%@",error);
            
            [weakself.tableView.mj_header endRefreshing];

        }];
    }
}

@end
