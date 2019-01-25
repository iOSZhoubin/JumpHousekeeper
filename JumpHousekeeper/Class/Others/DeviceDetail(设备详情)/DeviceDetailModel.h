//
//  DeviceDetailModel.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/25.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceDetailModel : NSObject

//设备状态
@property (copy,nonatomic) NSString *status;
//最新安全事件
@property (copy,nonatomic) NSString *news;
//设备版本信息
@property (copy,nonatomic) NSString *version;
//设备安全补丁
@property (copy,nonatomic) NSString *patch;
//设备升级信息
@property (copy,nonatomic) NSString *upgrade;
//设备许可信息
@property (copy,nonatomic) NSString *license;
//设备IP地址
@property (copy,nonatomic) NSString *ip;
//设备ID
@property (copy,nonatomic) NSString *deviceId;

@end
