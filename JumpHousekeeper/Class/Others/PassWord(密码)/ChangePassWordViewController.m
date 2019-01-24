//
//  ChangePassWordViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "JumpBaseTabBarViewController.h"

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
        
        self.topH.constant = 100;
        
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
    
    BOOL isPhoneNum = [self validateCellPhoneNumber:SafeString(self.phoneNumber.text)];
    
    if(isPhoneNum == NO){
        
        [SVPShow showInfoWithMessage:@"手机号格式有误"];
        
        return;
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

    L2CWeakSelf(self);
    
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
    
    BOOL isPhoneNum = [self validateCellPhoneNumber:SafeString(self.phoneNumber.text)];
    
    if(isPhoneNum == NO){
        
        [SVPShow showInfoWithMessage:@"手机号格式有误"];
        
        return;
    }
    
    
    
    if([self.type isEqualToString:@"1"]){
        
        JumpLog(@"注册");
        
        for (UIViewController *vc in weakself.navigationController.viewControllers) {
            
            if ([NSStringFromClass([vc class]) isEqualToString:@"JumpDeviceTableViewController"]) {
                
                [weakself.navigationController popToViewController:vc animated:YES];
            }
        }
        
    }else if ([self.type isEqualToString:@"2"]){
        
        JumpLog(@"修改密码");

        [self defaultLogin];
        
    }else{
        
        JumpLog(@"忘记密码");
        
        [self defaultLogin];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- 修改密码和忘记密码提交成功后都需要重新进行登录

-(void)defaultLogin{
    
    L2CWeakSelf(self);
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"更改密码后需要重新登录,确认更改?" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"确认" style: UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [JumpKeyChain deleteKeychainDataForKey:@"userInfo"];//删除保存的账户密码
        
        JumpBaseTabBarViewController *vc = [[JumpBaseTabBarViewController alloc]init];
        
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        appdelegate.window.rootViewController = vc;
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [weakself presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark --- 正则校验手机号码

-(BOOL)validateCellPhoneNumber:(NSString *)cellNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,175,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|7[56]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if(([regextestmobile evaluateWithObject:cellNum] == YES)
       || ([regextestcm evaluateWithObject:cellNum] == YES)
       || ([regextestct evaluateWithObject:cellNum] == YES)
       || ([regextestcu evaluateWithObject:cellNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

@end
