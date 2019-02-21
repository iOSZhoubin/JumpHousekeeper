//
//  ChangePassWordViewController.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpBaseViewController.h"

@interface ChangePassWordViewController : JumpBaseViewController

//1-注册（未登录情况下） 2-修改密码 3-忘记密码
@property (copy,nonatomic) NSString *type;

//type为1时必传   扫描后的字符串
@property (copy,nonatomic) NSString *deviceStr;

//type为1时必传   1-注册管理员  2-注册用户
@property (copy,nonatomic) NSString *resultType;

//type为1时必传   1- 添加设备下进来的（已登录）2-登录界面注册进来的
@property (copy,nonatomic) NSString *fromeType;

@end
