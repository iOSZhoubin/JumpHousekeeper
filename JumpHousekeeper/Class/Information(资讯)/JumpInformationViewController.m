//
//  JumpInformationViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpInformationViewController.h"
#import "JumpInfomationTableViewCell.h"
#import "JumpAgreementViewController.h"
#import "SLBannerView.h"

@interface JumpInformationViewController ()<SLBannerViewDelegate,UITableViewDelegate,UITableViewDataSource>

//轮播图
@property (weak, nonatomic) IBOutlet UIView *headView;
//tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JumpInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}

-(void)setupUI{
    
    [self figurePicture];

    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JumpInfomationTableViewCell" bundle:nil] forCellReuseIdentifier:@"JumpInfomationTableViewCell"];
    
}


#pragma mark --- 轮播图

-(void)figurePicture{
    
    SLBannerView *banner = [SLBannerView bannerViewXib];

    banner.frame = CGRectMake(0, 0, kWidth, 160);
    
    //图片
    banner.slImages = @[@"photo1.png", @"photo2.png", @"photo3.png"];
    //标题
    banner.slTitles = @[@"WAF是一个软硬件一体化架构的系统",@"WAF是一个软硬件一体化架构的系统",@"WAF是一个软硬件一体化架构的系统"];
    
    //监听设置代理
    banner.delegate = self;
    //banner添加到UI上
    [self.headView addSubview:banner];
    //自定义动画时间，建议动画持续时间小于停留时间
    banner.durTimeInterval = 0.2;
    banner.imgStayTimeInterval = 2.5;
}



#pragma mark --- UItableView数据源和代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JumpInfomationTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"JumpInfomationTableViewCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JumpAgreementViewController *vc = [[JumpAgreementViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.isShow = YES;
    
    vc.url = @"https://www.baidu.com";
    
    vc.titleName = @"资讯详情";
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ---  SLBannerViewDelegate

/** 监听点击的图片 */
- (void)bannerView:(SLBannerView *)banner didClickImagesAtIndex:(NSInteger)index{
    
    JumpLog(@"点击了第%ld张图片",index);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
