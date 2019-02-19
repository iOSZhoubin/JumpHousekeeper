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
#import "JumpInformationModel.h"

@interface JumpInformationViewController ()<SLBannerViewDelegate,UITableViewDelegate,UITableViewDataSource>

//轮播图
@property (weak, nonatomic) IBOutlet UIView *headView;
//tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//数据源(底部信息)
@property (strong,nonatomic) NSMutableArray *dataArray;
//数据源(轮播图)
@property (strong,nonatomic) NSMutableArray *newsArray;

@end

@implementation JumpInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}

-(void)setupUI{
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.dataArray = [NSMutableArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JumpInfomationTableViewCell" bundle:nil] forCellReuseIdentifier:@"JumpInfomationTableViewCell"];
    
    [RefreshHelper refreshHelperWithScrollView:self.tableView target:self loadNewData:@selector(loadList) loadMoreData:nil isBeginRefresh:YES];
    
}


#pragma mark --- 轮播图

-(void)figurePicture{
    
    SLBannerView *banner = [SLBannerView bannerViewXib];

    banner.frame = CGRectMake(0, 0, kWidth, 160);

    NSMutableArray *cycleImageArray = [NSMutableArray array];
    NSMutableArray *cycleTitleArray = [NSMutableArray array];
    
    for (JumpInformationModel *model in self.dataArray) {
        
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",ImageBaseUrl,SafeString(model.img)];
        
        [cycleImageArray addObject:imageUrl];
        [cycleTitleArray addObject:SafeString(model.title)];
    }

    banner.slImages =  cycleImageArray;
    banner.slTitles =  cycleTitleArray;

    //图片
//    banner.slImages = @[@"photo1.png", @"photo2.png", @"photo3.png"];
//    banner.slImages = @[@"http://img.zcool.cn/community/01c8c859f04db5a801202b0c544b28.jpg@2o.jpg", @"http://img.zcool.cn/community/01c8e3554473d80000019ae9961675.jpg", @"http://i0.hdslb.com/bfs/article/5e9cac17dcbb75d8b1af4e4435f53366f32a3e45.jpg"];
//
    //标题
//    banner.slTitles = @[@"WAF是一个软硬件一体化架构的系统",@"WAF是一个软硬件一体化架构的系统",@"WAF是一个软硬件一体化架构的系统"];
    
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
    
    return self.newsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JumpInfomationTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"JumpInfomationTableViewCell" forIndexPath:indexPath];
    
    JumpInformationModel *model = self.newsArray[indexPath.row];
    
    [cell refreshWithModel:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JumpInformationModel *model = self.newsArray[indexPath.row];
    
    JumpAgreementViewController *vc = [[JumpAgreementViewController alloc]init];
    
    vc.isShow = YES;
    
    vc.url = [NSString stringWithFormat:@"%@%@",ImageBaseUrl,model.uri];
    
    vc.titleName = @"资讯详情";
    
    vc.informationId = model.fid;
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ---  SLBannerViewDelegate

/** 监听点击的图片 */
- (void)bannerView:(SLBannerView *)banner didClickImagesAtIndex:(NSInteger)index{
    
    JumpLog(@"点击了第%ld张图片",index);
    
    JumpInformationModel *model = self.newsArray[index];
    
    JumpAgreementViewController *vc = [[JumpAgreementViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.isShow = YES;
    
    vc.url = [NSString stringWithFormat:@"%@%@",ImageBaseUrl,model.uri];
    
    vc.titleName = @"资讯详情";
    
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark --- 资讯列表

-(void)loadList{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"1";
    parameters[@"t"] = @"1";
    parameters[@"id"] = @"0";
    parameters[@"c"] = @"10";

    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        JumpLog(@"%@",responseObject);
        
        NSDictionary *dict = responseObject;
  
        if([SafeString(dict[@"message"]) isEqualToString:@"error"]){
            
            [SVPShow showInfoWithMessage:@"当前设备未登录"];
            
        }else{
            
            weakself.dataArray = [JumpInformationModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"images"]];

            weakself.newsArray = [JumpInformationModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"news"]];
            
            [self figurePicture];

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
    // Dispose of any resources that can be recreated.
}



@end
