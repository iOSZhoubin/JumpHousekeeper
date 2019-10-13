//
//  JumpSupportViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpSupportViewController.h"
#import "ConfigurationTableViewController.h"
#import "SupportModel.h"

@interface JumpSupportViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;

@property (strong,nonatomic) SupportModel *model;
//电话1
@property (weak, nonatomic) IBOutlet UILabel *telephone1;
//电话2
@property (weak, nonatomic) IBOutlet UILabel *telephone2;
//邮箱
@property (weak, nonatomic) IBOutlet UILabel *email;
//邮编
@property (weak, nonatomic) IBOutlet UILabel *code;
//网址
@property (weak, nonatomic) IBOutlet UILabel *webStr;
//地址
@property (weak, nonatomic) IBOutlet UILabel *address;

@end

@implementation JumpSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.topH.constant = L2C_StatusBarAndNavigationBarHeight;
    
    [self getCompanyMessage];
}


#pragma mark --- 配置向导

- (IBAction)configurationAction:(UIButton *)sender {
    
    JumpLog(@"配置向导");
    
    ConfigurationTableViewController *vc = [[ConfigurationTableViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.type = @"1";
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- 常见问题

- (IBAction)problemAction:(UIButton *)sender {
   
    JumpLog(@"常见问题");
    
    ConfigurationTableViewController *vc = [[ConfigurationTableViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.type = @"2";
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- 打电话，邮件

- (IBAction)callPhone:(UIButton *)sender {
    
    NSString *str1 = [NSString stringWithFormat:@"拨打电话:%@",self.model.telphone1];
    NSString *str2 = [NSString stringWithFormat:@"tel:%@",self.model.telphone1];

    NSString *str3 = [NSString stringWithFormat:@"拨打电话:%@",self.model.telphone2];
    NSString *str4 = [NSString stringWithFormat:@"tel:%@",self.model.telphone2];
    
    NSString *str5 = [NSString stringWithFormat:@"发送邮件:%@",self.model.email];
    NSString *str6 = [NSString stringWithFormat:@"mailto://%@",self.model.email];
    
    NSString *str7 = [NSString stringWithFormat:@"访问网站:%@",self.model.website];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"快捷支持" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle:str1 style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str2]];
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:str3 style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str4]];
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:str5 style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
       [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str6]];
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:str7 style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.website]];
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
   
}


#pragma mark --- 获取公司基本信息

-(void)getCompanyMessage{
    
    L2CWeakSelf(self);
    
    [SVPShow show];
    
    [AFNHelper post:CompanyMessage parameters:nil success:^(id responseObject) {
        
        weakself.model = [SupportModel mj_objectWithKeyValues:responseObject[@"result"]];

        [weakself defaultMessage];
        
        [SVPShow disMiss];
        
    } faliure:^(id error) {
        
        [weakself defaultMessage];
        
        [SVPShow showInfoWithMessage:@"请求服务器失败"];
    }];
}

-(void)defaultMessage{
    
    if(!self.model){
        
        self.model = [[SupportModel alloc]init];

        self.model.telphone1 = @"029-88333000";
        self.model.telphone2 = @"400-613-1868";
        self.model.email = @"support@jump.net.cn";
        self.model.website = @"http://www.jump.net.cn";
        self.model.address = @"西安市高新技术产业开发区科技二路72号捷普大厦";
        self.model.postalcode = @"710075";
    }
    
    self.telephone1.text = self.model.telphone1;
    self.telephone2.text = self.model.telphone2;
    self.email.text = self.model.email;
    self.webStr.text = self.model.website;
    self.address.text = self.model.address;
    self.code.text = self.model.postalcode;
}

@end
