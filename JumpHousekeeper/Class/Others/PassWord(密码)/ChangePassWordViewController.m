//
//  ChangePassWordViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "JumpBaseTabBarViewController.h"
#import "JumpLoginViewController.h"

@interface ChangePassWordViewController ()
//设备号
@property (weak, nonatomic) IBOutlet UILabel *deviceCode;
//设备View
@property (weak, nonatomic) IBOutlet UIView *deviceView;
//距上高度   注册时为100  其他为40
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;
//确认按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
//手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passWord;
//密码标题
@property (weak, nonatomic) IBOutlet UILabel *passWordTitle;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *code;
//验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
//授权码
@property (weak, nonatomic) IBOutlet UITextField *authorizationCode;
//验证码发送间隔
@property (assign,nonatomic) NSInteger timerNum;
//定时器
@property (strong,nonatomic) NSTimer *timer;
@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}


//设置默认值
-(void)initUI{
    
    self.sureBtn.layer.cornerRadius = 5;

    if([self.type isEqualToString:@"1"]){
        
        self.deviceCode.text = self.deviceStr;
        
        self.navigationItem.title = @"注册";
        
        self.passWordTitle.text = @"密码";
        
        self.topH.constant = 130;
        
        self.deviceView.hidden = NO;
        
        [self.sureBtn setTitle:@"注册" forState:UIControlStateNormal];
        
    }else if ([self.type isEqualToString:@"2"]){
        
        self.navigationItem.title = @"修改密码";
        
        self.passWordTitle.text = @"新密码";
        
        self.topH.constant = 40;
        
        self.deviceView.hidden = YES;
        
        [self.sureBtn setTitle:@"确认修改" forState:UIControlStateNormal];

    }else{
        
        self.navigationItem.title = @"忘记密码";
        
        self.passWordTitle.text = @"新密码";

        self.topH.constant = 40;
        
        self.deviceView.hidden = YES;
        
        [self.sureBtn setTitle:@"确认提交" forState:UIControlStateNormal];

    }
    
    [self.passWord setSecureTextEntry:YES];//密文
    
    //设置键盘类型
    self.phoneNumber.keyboardType = UIKeyboardTypePhonePad;
    self.passWord.keyboardType = UIKeyboardTypeDefault;
    self.code.keyboardType = UIKeyboardTypeNumberPad;
}


#pragma mark --- 获取验证码

- (IBAction)getCodeAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if(SafeString(self.phoneNumber.text).length < 1){
        
        [SVPShow showInfoWithMessage:@"手机号不能为空"];
        
        return;
    }
    
    BOOL isPhoneNum =   [JumpPublicAction isTruePhoneNumber:SafeString(self.phoneNumber.text)] ;
    
    if(isPhoneNum == NO){
        
        [SVPShow showInfoWithMessage:@"手机号格式有误"];
        
        return;
    }
    
    if([self.type isEqualToString:@"2"]){
        //修改密码
        [self getCodeLogin];
        
    }else{
        
        //忘记密码和注册都为未登录情况
        [self getcodeUnlogin];

    }
    
    
    self.codeBtn.enabled = NO;
    
    [self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.timerNum = 60;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f  //间隔时间
                                                  target:self
                                                selector:@selector(countdown)
                                                userInfo:nil
                                                 repeats:YES];
}


- (void)countdown{
    
    self.timerNum --;
    
    if(self.timerNum < 0){
        
        [self.timer invalidate];
        
        self.timer = nil;
        
        self.timerNum = 0;
        
        [self.codeBtn setTitleColor:RGB(44, 159, 252) forState:UIControlStateNormal];

        self.codeBtn.enabled = YES;
        
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        
        self.codeBtn.titleLabel.text = [NSString stringWithFormat:@"%ld秒",self.timerNum];
        
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld秒",self.timerNum] forState:UIControlStateNormal];
    }
}


#pragma mark --- 确认

- (IBAction)sureAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if(SafeString(self.phoneNumber.text).length < 1){
        
        [SVPShow showInfoWithMessage:@"手机号不能为空"];
        
        return;
   
    }else if (SafeString(self.passWord.text).length < 1){
        
        [SVPShow showInfoWithMessage:@"密码不能为空"];
        
        return;
        
    }else if (SafeString(self.code.text).length < 1){
        
        [SVPShow showInfoWithMessage:@"验证码不能为空"];
        
        return;
    }
    
    BOOL isPhoneNum =   [JumpPublicAction isTruePhoneNumber:SafeString(self.phoneNumber.text)] ;

    if(isPhoneNum == NO){
        
        [SVPShow showInfoWithMessage:@"手机号格式有误"];
        
        return;
    }
    
    
    BOOL password = [JumpPublicAction checkPassWord:self.passWord.text];
    
    if(password == NO){
        
        [SVPShow showInfoWithMessage:@"密码过于简单,请重新设置"];
        
        return;
    }
    
    
    if([self.type isEqualToString:@"1"]){
        
        JumpLog(@"注册");
        
        [self newUser];
        
    }else{
        
        JumpLog(@"忘记密码");
        
        [self defaultLogin];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- 修改密码和忘记密码提交成功后都需要重新进行登录

-(void)defaultLogin{
    
    L2CWeakSelf(self);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更改密码后需要重新登录,确认更改?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
   
        if([self.type isEqualToString:@"2"]){
            //修改密码
            [weakself changePasswordLogin];
            
        }else if ([self.type isEqualToString:@"3"]){
            //忘记密码
            [weakself changePasswordUnLogin];
        }

    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark --- 未登录情况下获取验证码（忘记密码）

-(void)getcodeUnlogin{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"0";
    parameters[@"t"] = @"5";
    parameters[@"l"] = SafeString(self.phoneNumber.text);
    
    [SVPShow show];

    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([responseObject[@"result"] isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"验证码发送成功"];
            
        }else{
            
            [SVPShow showFailureWithMessage:@"验证码发送失败"];
        }
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"验证码发送失败"];
    }];
}

#pragma mark --- 获取验证码(已登录)

-(void)getCodeLogin{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"0";
    parameters[@"t"] = @"4";
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([responseObject[@"result"] isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"验证码发送成功"];

        }else{
            
            [SVPShow showFailureWithMessage:@"验证码发送失败"];
        }
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"验证码发送失败"];
    }];
}

#pragma mark --- 修改密码（已登录）

-(void)changePasswordLogin{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"0";
    parameters[@"t"] = @"4";
    parameters[@"c"] = SafeString(self.code.text);
    parameters[@"p"] = SafeString(self.passWord.text);

    [SVPShow show];
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([responseObject[@"result"] isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"密码修改成功"];
            
            [JumpKeyChain deleteKeychainDataForKey:@"userInfo"];//删除保存的账户密码
            
            JumpLoginViewController *vc = [[JumpLoginViewController alloc]init];
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            appdelegate.window.rootViewController = nav;
            
        }else{
            
            [SVPShow showFailureWithMessage:@"密码修改失败"];
        }
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"密码修改失败"];
    }];
}

#pragma mark --- 修改密码（未登录）

-(void)changePasswordUnLogin{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"m"] = @"0";
    parameters[@"t"] = @"5";
    parameters[@"c"] = SafeString(self.code.text);
    parameters[@"p"] = SafeString(self.passWord.text);
    parameters[@"l"] = SafeString(self.phoneNumber.text);

    [SVPShow show];
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([responseObject[@"result"] isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"密码修改成功"];
            
            [JumpKeyChain deleteKeychainDataForKey:@"userInfo"];//删除保存的账户密码
            
            [weakself.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [SVPShow showFailureWithMessage:@"密码修改失败"];
        }
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"密码修改失败"];
    }];
}

#pragma mark --- 注册提交

-(void)newUser{
    //发送手机号、设备号、密码、验证码(管理员)、验证码(用户)
    
    //@/iosapi.php?m=0&t=3&l=%@&d=%@&p=%@&o=%@&c=%@
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"0";
    parameters[@"t"] = @"3";
    parameters[@"l"] = SafeString(self.phoneNumber.text); //手机号
    parameters[@"d"] = SafeString(self.deviceStr);      //设备号
    parameters[@"p"] = SafeString(self.passWord.text);//密码
    parameters[@"o"] = SafeString(self.authorizationCode.text);//验证码(管理员)
    parameters[@"c"] = SafeString(self.code.text);//验证码(用户)

    [SVPShow show];
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([responseObject[@"result"] isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"注册成功"];
            
            for (UIViewController *vc in weakself.navigationController.viewControllers) {
                
                if ([NSStringFromClass([vc class]) isEqualToString:@"JumpDeviceTableViewController"]) {
                    
                    [weakself.navigationController popToViewController:vc animated:YES];
                }
            }
            
        }else{
            
            [SVPShow showFailureWithMessage:@"注册失败"];
        }
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"注册失败"];
    }];
}

@end
