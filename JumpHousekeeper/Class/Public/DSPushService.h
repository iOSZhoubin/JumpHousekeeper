//
//  DSPushService.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/4/10.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSPushService : NSObject


+ (instancetype)defaultPushService;

//授权和注册
- (BOOL)DSPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

//这个是为了在HomeScreen点击App图标进程序
- (void)DSBecomeActive:(UIApplication *)application;

//注册成功得到deviceToken
- (void)DSPushApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
//注册失败报错
- (void)DSPushApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

//这是处理发送过来的推送
- (void)DSPushApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)DSPushApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end

NS_ASSUME_NONNULL_END
