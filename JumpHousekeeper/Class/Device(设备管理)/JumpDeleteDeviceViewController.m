//
//  JumpDeleteDeviceViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/2/21.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpDeleteDeviceViewController.h"

@interface JumpDeleteDeviceViewController ()

//设备码
@property (weak, nonatomic) IBOutlet UILabel *deviceCode;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *codeField;
//获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
//提交按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
//验证码发送间隔
@property (assign,nonatomic) NSInteger timerNum;
//定时器
@property (strong,nonatomic) NSTimer *timer;

@end

@implementation JumpDeleteDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"解绑设备";

    self.sureBtn.layer.cornerRadius = 5;
}


#pragma mark --- 获取验证码

- (IBAction)getCodeAction:(UIButton *)sender {
    
    self.codeBtn.enabled = NO;
    
    [self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [self getCode];
    
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



#pragma mark --- 获取验证码

-(void)getCode{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"0";
    parameters[@"t"] = @"7";
    parameters[@"d"] = SafeString(self.deviceId);
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([SafeString(responseObject[@"result"]) isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"获取验证码成功"];
            
        }else{
            
            [SVPShow showFailureWithMessage:@"获取验证码失败"];
        }
        
    } faliure:^(id error) {
        
    }];
}


#pragma mark --- 确认提交

- (IBAction)sureAction:(UIButton *)sender {
    
    [self clickOkAction];
}


-(void)clickOkAction{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"0";
    parameters[@"t"] = @"7";
    parameters[@"d"] = SafeString(self.deviceId);
    parameters[@"c"] = @"验证码";
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        if([SafeString(responseObject[@"result"]) isEqualToString:@"1"]){
            
            [SVPShow showSuccessWithMessage:@"解绑成功"];
            
            [self backAction];
            
            [KNotification postNotificationName:@"JumpDeviceTableViewController" object:nil userInfo:nil];
            
        }else{
            
            [SVPShow showFailureWithMessage:@"解绑失败"];
        }
        
    } faliure:^(id error) {
        
        [SVPShow showFailureWithMessage:@"解绑失败"];
        
    }];
}

@end
