//
//  JumpLoginViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpLoginViewController.h"
#import "ChangePassWordViewController.h"

@interface JumpLoginViewController ()

//用户名
@property (weak, nonatomic) IBOutlet UITextField *account;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passWord;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation JumpLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];

}

-(void)initUI{
    
    self.navigationItem.title = @"登录";
    
    self.view.backgroundColor = BackGroundColor;
    
    self.loginBtn.layer.cornerRadius = 5;
    
    self.account.clearButtonMode = UITextFieldViewModeWhileEditing; //输入时右侧显示x号
    
    self.passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.passWord setSecureTextEntry:YES];//密文
}

#pragma mark --- 登录

- (IBAction)loginAction:(UIButton *)sender {

}

#pragma mark --- 忘记密码

- (IBAction)forgetPassWordAction:(UIButton *)sender {
    
    ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
    
    vc.type = @"3";
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- 扫码注册

- (IBAction)sweepAction:(UIButton *)sender {
}
@end
