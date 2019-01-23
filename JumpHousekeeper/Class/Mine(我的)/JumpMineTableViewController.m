//
//  JumpMineTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpMineTableViewController.h"
#import "JumpMineTableViewCell.h"

@interface JumpMineTableViewController ()

@end

@implementation JumpMineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}


-(void)setupUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JumpMineTableViewCell" bundle:nil] forCellReuseIdentifier:@"JumpMineTableViewCell"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}


#pragma mark --- UITableViewDelegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 7){
        
        static NSString *identifier = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.textLabel.text = @"注销登录";
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.textLabel.textColor = CustomerRed;
        
        return cell;
    }
    
    JumpMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JumpMineTableViewCell" forIndexPath:indexPath];
    
    [cell refreshWithIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 150;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 150)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 150)];
    
    imageView.image = [UIImage imageNamed:@"photo3"];
    
    [headView addSubview:imageView];
    
    headView.backgroundColor = CustomerBlue;
    
    return headView;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row == 0){
        //账户信息
    }else if (indexPath.row == 1){
        //设备列表
    }else if (indexPath.row == 2){
        //我的收藏
    }else if (indexPath.row == 3){
        //关于我们
    }else if (indexPath.row == 4){
        //意见反馈
    }else if (indexPath.row == 5){
        //清除缓存
    }else if (indexPath.row == 6){
        //修改密码
    }else if (indexPath.row == 7){
        //注销登录
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
