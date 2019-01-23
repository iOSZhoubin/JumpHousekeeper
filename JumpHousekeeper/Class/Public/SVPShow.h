//
//  SVPShow.h
//  Jump
//
//  Created by jumpapp1 on 2018/12/13.
//  Copyright © 2018年 zhoubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVPShow : NSObject

//开始加载动画
+ (void)show;
//加载动画消失
+ (void)disMiss;
//加载成功提示
+ (void)showSuccessWithMessage:(NSString *)messgae;
//加载失败提示
+ (void)showFailureWithMessage:(NSString *)message;
//加载警告提示
+ (void)showInfoWithMessage:(NSString *)message;

@end

