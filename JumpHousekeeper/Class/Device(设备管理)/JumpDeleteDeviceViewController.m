//
//  JumpDeleteDeviceViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/2/21.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpDeleteDeviceViewController.h"

@interface JumpDeleteDeviceViewController ()

@end

@implementation JumpDeleteDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"解绑设备";

}


#pragma mark --- 获取验证码

-(void)gerCode{
    
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
