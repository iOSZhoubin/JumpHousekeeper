//
//  JumpLoginViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpLoginViewController.h"
#import "ChangePassWordViewController.h"
#import "JumpBaseTabBarViewController.h"
#import "ScanningDeviceViewController.h"

@interface JumpLoginViewController ()<UITextFieldDelegate>

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
    
    self.passWord.delegate = self;
    
    self.account.delegate = self;

    [self.passWord setSecureTextEntry:YES];//密文
    
    //如果有本地保存，那么直接赋值
    NSDictionary *dict = [JumpKeyChain getKeychainDataForKey:@"userInfo"];
    
    NSString *account = SafeString(dict[@"account"]);
    NSString *password = SafeString(dict[@"password"]);

    self.account.text = account;
    self.passWord.text = password;
}

#pragma mark --- 登录

- (IBAction)loginAction:(UIButton *)sender {
    
    if(self.account.text.length < 1){
        
        [SVPShow showInfoWithMessage:@"用户名不能为空"];
        
        return;
        
    }else if (self.passWord.text.length < 1){
        
        [SVPShow showInfoWithMessage:@"密码不能为空"];
        
        return;
    }

    NSString *account = SafeString(self.account.text);
    
    NSString *password = SafeString(self.passWord.text);
    
    NSString *isLogin = @"1";
    
    NSDictionary *userInfo = @{@"account":account,@"password":password,@"isLogin":isLogin};
    
    [JumpKeyChain addKeychainData:userInfo forKey:@"userInfo"];
    
    JumpBaseTabBarViewController *vc = [[JumpBaseTabBarViewController alloc]init];
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
    appdelegate.window.rootViewController = vc;
}

#pragma mark --- 忘记密码

- (IBAction)forgetPassWordAction:(UIButton *)sender {
    
    ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
    
    vc.type = @"3";
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- 扫码注册

- (IBAction)sweepAction:(UIButton *)sender {
    
    //判断是否开启了相机的权限
    BOOL isopen = [JumpPublicAction isopenCamera];
    
    if(isopen){
        
        ScanningDeviceViewController *vc = [[ScanningDeviceViewController alloc]init];
        
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

#pragma mark --- textField代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
