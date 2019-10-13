//
//  JumpEchartsViewController.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/10/10.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JumpEchartsViewController : UIViewController

//1-监控一览 2-异常一览 3-最新安全事件（SOC是图表）
@property (copy,nonatomic) NSString *type;
//设备id
@property (copy,nonatomic) NSString *deviceId;

@end

NS_ASSUME_NONNULL_END
