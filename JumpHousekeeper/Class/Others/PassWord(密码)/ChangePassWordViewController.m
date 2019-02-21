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
//头部视图高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;
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
//授权码Title
@property (weak, nonatomic) IBOutlet UILabel *authorTitle;
//设备码里面的分割线
@property (weak, nonatomic) IBOutlet UILabel *line;
//密码栏整体View的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passH;
//密码栏的分割线
@property (weak, nonatomic) IBOutlet UILabel *line2;
//密码栏分割线距上的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line2H;
//验证码发送间隔
@property (assign,nonatomic) NSInteger timerNum;
//定时器
@property (strong,nonatomic) NSTimer *timer;

@end

/**
 * 当type为1主要判断的是页面的展示：显不显示设备码（其他不显示设备码）显不显示输入密码（添加设备不需要输入密码）
 *
 * resultType主要判断的是显不显示：授权码
 */

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}


//设置默认值
-(void)initUI{
    
    self.sureBtn.layer.cornerRadius = 5;

    if([self.type isEqualToString:@"1"] || [self.type isEqualToString:@"4"]){
        
        self.deviceCode.text = self.deviceStr;
    
        self.passWordTitle.text = @"密码";
        
        if([self.resultType isEqualToString:@"1"]){
            //注册管理员
            self.topH.constant = 100;

        }else{
            //注册用户
            self.topH.constant = 130;

        }
        
        if([self.type isEqualToString:@"4"]){

            self.navigationItem.title = @"添加设备";
            [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
            self.passWord.hidden = YES;
            self.passWordTitle.hidden = YES;
            self.passH.constant = 90;
            self.line2.hidden = YES;
            self.line2H.constant = 0;

        }else{

            self.navigationItem.title = @"注册";
            [self.sureBtn setTitle:@"注册" forState:UIControlStateNormal];
            self.passWord.hidden = NO;
            self.passWordTitle.hidden = NO;
            self.line2.hidden = NO;
            self.passH.constant = 130;
            self.line2H.constant = 42;
        }
        
        self.deviceView.hidden = NO;
        
        
    }else if ([self.type isEqualToString:@"2"]){
        
        self.navigationItem.title = @"修改密码";
        
        self.passWordTitle.text = @"新密码";
        
        self.topH.constant = 40;
        
        self.deviceView.hidden = YES;
        
        self.passWord.hidden = NO;
        
        self.passWordTitle.hidden = NO;
        
        [self.sureBtn setTitle:@"确认修改" forState:UIControlStateNormal];

    }else{
        
        self.navigationItem.title = @"忘记密码";
        
        self.passWordTitle.text = @"新密码";

        self.topH.constant = 40;
        
        self.deviceView.hidden = YES;
        
        self.passWord.hidden = NO;
        
        self.passWordTitle.hidden = NO;
        
        [self.sureBtn setTitle:@"确认提交" forState:UIControlStateNormal];

    }
    
    [self.passWord setSecureTextEntry:YES];//密文
    
    
    if([self.resultType isEqualToString:@"1"]){
        
        self.authorTitle.hidden = YES;
        
        self.authorizationCode.hidden = YES;
        
        self.line.hidden = YES;
        
        self.viewH.constant = 41;
        
    }else{
        
        self.authorTitle.hidden = NO;
        
        self.authorizationCode.hidden = NO;
        
        self.line.hidden = NO;
        
        self.viewH.constant = 82;
    }
    
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
        
        //忘记密码和注册
        [self getcodeUnlogin];
    }
    
    
    self.codeBtn.enabled = NO;
    
    [self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.timerNum = 10;
    
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
        
    }else if ([self.type isEqualToString:@"4"]){

        JumpLog(@"添加设备");

        [self addDevice];
        
    }else{
        
        JumpLog(@"忘记密码");
        
        [self defaultLogin];
    }
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


#pragma mark --- 未登录情况下获取验证码（忘记密码，注册，添加设备）

-(void)getcodeUnlogin{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if([self.type isEqualToString:@"1"]){//注册下
        
        //登录界面注册下获取验证码
        parameters[@"m"] = @"0";
        parameters[@"t"] = @"3";
        parameters[@"d"] = SafeString(self.deviceStr);
        parameters[@"l"] = SafeString(self.phoneNumber.text);

    }else if ([self.type isEqualToString:@"4"]){
        
        //添加设备下进来获取验证码
        parameters[@"m"] = @"0";
        parameters[@"t"] = @"6";
        parameters[@"d"] = SafeString(self.deviceStr);
        
    }else{
        //忘记密码下
        parameters[@"m"] = @"0";
        parameters[@"t"] = @"5";
        parameters[@"l"] = SafeString(self.phoneNumber.text);
    }

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
    
    NSString *password = [JumpPublicAction md5:SafeString(self.passWord.text)];

    parameters[@"m"] = @"0";
    parameters[@"t"] = @"4";
    parameters[@"c"] = SafeString(self.code.text);
    parameters[@"p"] = password;

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

    NSString *password = [JumpPublicAction md5:SafeString(self.passWord.text)];

    parameters[@"m"] = @"0";
    parameters[@"t"] = @"5";
    parameters[@"c"] = SafeString(self.code.text);
    parameters[@"p"] = password;
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

    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *password = [JumpPublicAction md5:SafeString(self.passWord.text)];
    
    parameters[@"m"] = @"0";
    parameters[@"t"] = @"3";
    parameters[@"l"] = SafeString(self.phoneNumber.text); //手机号
    parameters[@"d"] = SafeString(self.deviceStr);      //设备号
    parameters[@"p"] = password;//密码
    parameters[@"o"] = SafeString(self.code.text);//验证码(用户)
    parameters[@"c"] = SafeString(self.authorizationCode.text);//验证码(管理员)

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


#pragma mark --- 添加设备

-(void)addDevice{
    
    L2CWeakSelf(self);
     
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
    parameters[@"m"] = @"0";
    parameters[@"t"] = @"6";
    parameters[@"d"] = SafeString(self.deviceStr);      //设备号
    parameters[@"o"] = SafeString(self.code.text);//验证码(用户)
    parameters[@"c"] = SafeString(self.authorizationCode.text);//验证码(管理员)
    
    [SVPShow show];
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([responseObject[@"result"] isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"添加成功"];
            
            for (UIViewController *vc in weakself.navigationController.viewControllers) {
                
                if ([NSStringFromClass([vc class]) isEqualToString:@"JumpDeviceTableViewController"]) {
                    
                    [weakself.navigationController popToViewController:vc animated:YES];
                }
            }
            
            [KNotification postNotificationName:@"JumpDeviceTableViewController" object:nil userInfo:nil];
            
        }else{
            
            [SVPShow showFailureWithMessage:@"添加失败"];
        }
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"添加失败"];
    }];
}




@end
