//
//  DeviceDetailModel.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/25.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceDetailModel : NSObject

//
@property (copy,nonatomic) NSString *ftype;
//
@property (copy,nonatomic) NSString *fw_virus;
//
@property (copy,nonatomic) NSString *fid;
//2019-01-22 00:00:00
@property (copy,nonatomic) NSString *fupdate;
//无限期
@property (copy,nonatomic) NSString *license;
//20190118-20190118
@property (copy,nonatomic) NSString *rulever;
//设备ID
@property (copy,nonatomic) NSString *devid;
//设备版本信息
@property (copy,nonatomic) NSString *ver;
//设备IP地址
@property (copy,nonatomic) NSString *ip;
//
@property (copy,nonatomic) NSString *fw_appver;
//
@property (copy,nonatomic) NSString *fw_ips;
//漏洞扫描-NVAS
@property (copy,nonatomic) NSString *fname;
//
@property (copy,nonatomic) NSString *fw_mailrule;
//CPU
@property (copy,nonatomic) NSString *cpu;
//内存
@property (copy,nonatomic) NSString *mem;
//设备状态 0-离线 1-在线
@property (copy,nonatomic) NSString *online;

@end
