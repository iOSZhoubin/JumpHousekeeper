//
//  JumpAccountDetailModel.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JumpAccountDetailModel : NSObject

//昵称
@property (copy,nonatomic) NSString *nickname;
//账号
@property (copy,nonatomic) NSString *account;
//真实姓名
@property (copy,nonatomic) NSString *truename;
//手机号
@property (copy,nonatomic) NSString *phonenum;
//邮箱
@property (copy,nonatomic) NSString *mailnum;
//详细地址
@property (copy,nonatomic) NSString *address;
//设备id
@property (copy,nonatomic) NSString *deviceid;
//
@property (copy,nonatomic) NSString *fdesc;
//
@property (copy,nonatomic) NSString *fid;
//
@property (copy,nonatomic) NSString *loginid;




@end
