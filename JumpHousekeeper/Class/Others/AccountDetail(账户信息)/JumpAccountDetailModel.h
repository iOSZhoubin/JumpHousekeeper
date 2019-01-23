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
@property (copy,nonatomic) NSString *accountName;
//账号
@property (copy,nonatomic) NSString *account;
//真实姓名
@property (copy,nonatomic) NSString *userName;
//手机号
@property (copy,nonatomic) NSString *phoneNumber;
//邮箱
@property (copy,nonatomic) NSString *email;
//详细地址
@property (copy,nonatomic) NSString *address;

@end
